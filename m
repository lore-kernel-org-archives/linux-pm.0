Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02083D6461
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232604; cv=none; b=t1qkDKMXQeQPnJj2n30Qi33FueBVLuRIWNrxB5UenvtWcVqvXziYkyTrKZNcqgUtlAlkTFE+gFDUlbHyE8pTmJ3UwQ3exLRQF3yZGjIaZNIaMNw7MBCskn6Y4Q/Xikyenfa0sKEQoxa0m70CEoYjVeUhKlTUqhL3qayACLDNO2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232604; c=relaxed/simple;
	bh=N4PP06m13NVeyUJu1vz+YQr/JNlggaXnXk9toV/NnYE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=btnBjYQVoV+1kct7hlKLMEoDMRsfX1d2BiBv8kldSWKRsJpLAbfHF0TQNA5CeQvizVR98Ja/EH/mHMoZlBClgtfgsMONyjyXdDQW+o+paq3Ou46rUadTmvnsUIrbh5BxpYGV17VUagED+Vk0E5BtmYyWszvQ+hGcoG6/7+XUc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRbpH3zs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRbpH3zs"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cf7683a28so1229748f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775232601; x=1775837401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOokx9rHSXRUAd5xTDChxnMcBVuK5oRv0xp0uVULe4Y=;
        b=rRbpH3zsj4XE3sFQYiV+epeDbKelKnT0u6Iq/x0MNGi970y7BQTQxcPnTeWMN/kSor
         uoz34xGIYpBKbFjogQsR/h5ocgpMZupZw0NwfvmupG4tKUi4z0h0nRDLH/JBisRk9RJU
         g/llTkz3731ZNbskvfeFSZ5EuMzKgpCEMHTIKU0Ux0SseBh/OEzOBr6A36ul72CEBCWH
         OirW2s6lDxUznGxJanvfMfF6yEk0WET0yWe+wu3BmWp+8DcwYv2ZiLSnR3+iu7DGryVI
         bkMaafY+2/Etpw1YXdXhsK3GK/jz90ZVwbLUQK8Z2Njc0zK2Wb3TwDkkyofNsE1j1g6L
         zZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775232601; x=1775837401;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOokx9rHSXRUAd5xTDChxnMcBVuK5oRv0xp0uVULe4Y=;
        b=SGy0PmHFPcAHvIRvqsSJG7nAdgjjIEVNN0Igti2Pbs1lNCkpTNQuKJYNBKDyRK+wzv
         IYcYmZoxGRGKMGPDLCO8xOJe371DY5g2nUKAYU34VCZzApEERSmSkrHq/uvBNAOlggyM
         ZZnzvgVLhnbU3wKu9lhY0tNinqVvpuQJcGn3Id85h4syUMMjbyCyCJwvxhdougPbH6nu
         0BB3UD29WDXqtYnmqpx1IRl/ij1OAosRDXmM48BvbO98olP7gvNnwcP57KUPsuKgU0S8
         MwCHfZFZgM4NCWlOARuuE7eXlceYA76Wzbv15qb+ustt/70K66lIZhmfFFbFgtrQKZ/N
         WsdQ==
X-Gm-Message-State: AOJu0Yz8jWarMnPaFyZtCfoBDspu2gF/F2ji73JL+MqbntZBNIBI5Rgr
	BspfuXRZqLUiCkvRPOGqzTPMcsNDBO3at39gCWjrr2JdDsmQB2ngofi8tON+rg==
X-Gm-Gg: ATEYQzxJpiezlzp7klCxKSz5IDrP+1OYFChQ7PaHwEh9R3+QmnP6n03DRWtiA+zhci4
	ovWhF8XP528CojTW6U1cBDvcyQKisnrZZaXZQz6+MNcYpjjsOQmYv7Np1wFtHgzHzCWrZnbLpJu
	7qX/BV5BTv2Ww4UNmmCFSyYo8LMR+mviE6xl9ks1OG0kQttHHSjg7/RdAcRS3lwHYdbCYpC9sNl
	PbS8gHFePvTt3ds5r3JSWfYgwbom+oSG2UQ2Ru+YcXT1tva6nTyAWJVSIryKS5D+V+WWysuPDSK
	kKKlrBqZevRJdEbq9omFxH02sPCtwXyoVQtqYCLMNzQVW69Lw/8vP2rqY4soUO7UJGQmBkhQRFI
	5PS/QzzpDTtg6JS6D1rM7aLRuGrvzXZWuAdshDUXaWZfLzEu2rgkXTgWDqLeTzBB63icYNKezcx
	9t023UXkYgoUY5qSr1GmPtH+ZpHTL3UF8y8QTDeJkipdc/Ts3ajeXli3lGyRijCh2WgpCrTPaSu
	DOCEyY2F2jW3vo/RReapFPGOSxx/UUKdur3E97XTDHyM7vty6tSIdCkMFRt8F4iKA==
X-Received: by 2002:a05:600c:638e:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-488997dec25mr53434575e9.27.1775232600878;
        Fri, 03 Apr 2026 09:10:00 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:db00:e1f0:894e:62a8:6ac1? (p200300ea8f2fdb00e1f0894e62a86ac1.dip0.t-ipconnect.de. [2003:ea:8f2f:db00:e1f0:894e:62a8:6ac1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f08sm19285323f8f.6.2026.04.03.09.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 09:10:00 -0700 (PDT)
Message-ID: <ac269a91-0ba0-4798-acc6-ec294926bbb0@gmail.com>
Date: Fri, 3 Apr 2026 18:09:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PM / wakeup: Register class wakeup in pure_initcall phase
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Wakeup sources (e.g. autosleep) can be created as early as core_initcall.
Class wakeup is registered in postcore_initcall only, what results in
autosleep wakeup source not being shown in sysfs. To fix this,
register class wakeup in pure_initcall phase already.

The current behavior doesn't cause any known issue, therefore treat
the change as an improvement.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/base/power/wakeup_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index 308f8bde9..30f0d3d61 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -216,4 +216,4 @@ static int __init wakeup_sources_sysfs_init(void)
 
 	return PTR_ERR_OR_ZERO(wakeup_class);
 }
-postcore_initcall(wakeup_sources_sysfs_init);
+pure_initcall(wakeup_sources_sysfs_init);
-- 
2.53.0

