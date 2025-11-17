-- Insert example users from view-badges.html
-- These users represent the core contributors to the HAAG platform

DO $$
DECLARE
    current_ts TIMESTAMPTZ;
BEGIN
    -- Set current timestamp
    current_ts := NOW();
    
    -- Insert dima (Research Progress Tracking expert)
    INSERT INTO person (
        name, display_name, actor_id, inbox_url, shared_inbox_url,
        public_key, last_refreshed_at, published, instance_id, local
    ) VALUES (
        'dima',
        'Dima - Research Tracker',
        'http://134.199.214.141/u/dima',
        'http://134.199.214.141/u/dima/inbox',
        'http://134.199.214.141/inbox',
        '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAdimakey1\n-----END PUBLIC KEY-----',
        current_ts,
        current_ts,
        1,
        true
    ) ON CONFLICT (actor_id) DO NOTHING;
    
    -- Insert leyang (Gamification & Engagement expert)
    INSERT INTO person (
        name, display_name, actor_id, inbox_url, shared_inbox_url,
        public_key, last_refreshed_at, published, instance_id, local
    ) VALUES (
        'leyang',
        'Leyang - Gamification Expert',
        'http://134.199.214.141/u/leyang',
        'http://134.199.214.141/u/leyang/inbox',
        'http://134.199.214.141/inbox',
        '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAleyangkey1\n-----END PUBLIC KEY-----',
        current_ts,
        current_ts,
        1,
        true
    ) ON CONFLICT (actor_id) DO NOTHING;
    
    -- Insert jamesthesnake (Conservation Technology & Administration)
    INSERT INTO person (
        name, display_name, actor_id, inbox_url, shared_inbox_url,
        public_key, last_refreshed_at, published, instance_id, local
    ) VALUES (
        'jamesthesnake',
        'James - HAAG Admin',
        'http://134.199.214.141/u/jamesthesnake',
        'http://134.199.214.141/u/jamesthesnake/inbox',
        'http://134.199.214.141/inbox',
        '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjameskey1\n-----END PUBLIC KEY-----',
        current_ts,
        current_ts,
        1,
        true
    ) ON CONFLICT (actor_id) DO NOTHING;
    
    -- Insert charlie (PhD Student - Gator Research)
    INSERT INTO person (
        name, display_name, actor_id, inbox_url, shared_inbox_url,
        public_key, last_refreshed_at, published, instance_id, local
    ) VALUES (
        'charlie',
        'Charlie - PhD Student',
        'http://134.199.214.141/u/charlie',
        'http://134.199.214.141/u/charlie/inbox',
        'http://134.199.214.141/inbox',
        '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAcharliekey1\n-----END PUBLIC KEY-----',
        current_ts,
        current_ts,
        1,
        true
    ) ON CONFLICT (actor_id) DO NOTHING;
    
    RAISE NOTICE 'Successfully inserted 4 example users: dima, leyang, jamesthesnake, charlie';
END $$;
