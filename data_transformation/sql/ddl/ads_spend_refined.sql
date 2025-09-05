CREATE TABLE IF NOT EXISTS postgres.public.ads_spend (
    date DATE NOT NULL,
    platform VARCHAR(50) NOT NULL,
    account VARCHAR(100) NOT NULL,
    campaign VARCHAR(100) NOT NULL,
    country VARCHAR(10) NOT NULL,
    device VARCHAR(50) NOT NULL,
    spend DECIMAL(10, 2) NOT NULL,
    clicks INTEGER NOT NULL,
    impressions INTEGER NOT NULL,
    conversions INTEGER NOT NULL,
    load_date TIMESTAMP NOT NULL,
    source_file_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (date, platform, account, campaign, country, device)
);
