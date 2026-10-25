Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896540;
	b=SkIH1mYx2Qdwv5CTE3cUUdhsN77qF2yze3lBrNWcQRfUC5oTu4+bGd4lnnJCLD7BG/4H
	 19GMJAg0ybFbhkCF/k/HhR8ARLIQ5ouhhUA5IDFwOrh0KIFYSs7Bb6TKmya+jnQfZTpRR
	 JSJQXZQoY36CBrl6+BEGWwX4P1warXfuUskldKrkgatjERyfFnd2uFzHYIh8JC8qUEAvY
	 fCL5uEEM0X8olcb1KJNQsCFU9YCKUHRCYFZxcnVUJS/QYz5uPqhDRzzDmch1NfDPWIY2G
	 LgstIuuIUSweKoOnHIo2H/UGBEeoesKHVH4ahN08ifepclBo1ILw+gK24wPVkyi8TxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xv9yLRfHeZEkf9phVasO/TM2yP5oqXz3F+WdBaktVTI=;
	b=1f0Rf07k2mvNBhPibJr7zpDcp9o1wLuBGQC9MItctxNYQ988lpNsVhx6mQPGrjQIvTjE
	 81wV8TpOLrTI254gXxLjTp+GHc14drgzi4EbF3qTJlqJLZpj9/d9nZfflMJoCKkr6lX13
	 /tHVIi0FqXqu2XMJ7pBdEme8nAndIgvz1e4j0WQmCfil7tvryatTJ+7LMDvaLoFfMuWiH
	 3H+qviBR+Y3YnuI6xpAxC3S+LFoEGjPzItrSdIfr0ulTFr7Ht8tIVxwitksdL+K6D5IRO
	 KTtw+8PlyVyXsZY8shjm90dp2D1czxzuN+Usg5oItBfz3v4cc0ndT2hzaKtyvsxfWbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MRUtJt7G;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A97606A33F
	for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 02:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48A97606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MRUtJt7G
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1931ff67a29so4101429c88.1
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 19:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896539; x=1793501339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xv9yLRfHeZEkf9phVasO/TM2yP5oqXz3F+WdBaktVTI=;
        b=MRUtJt7Gkp4vafFe0rMwqOvDHoXxAMNyVJYKgIxP6STY7JiEtaQfRGX4Bfxa00RzZd
         LL9z7cyZsOY/4U6jo0Y82ZKnYeZ1xnNi4d2t5k2uSo3AfAtxKMndyfDNAgGYy05aj8O3
         +NOHRUj7mM7v7fo+STYhhLtoX7v3SUKlWkXZeFFQzfGnr+1EFv7yXE1lbrNRa/fILIlL
         PH4YGconi0OlzRG16TfoWqLahojfLcD9IiRsXiKBSsaWXiKATHLwZ+qecfhZ4HPZyt5D
         pN3gc5vWiZm5akOtpG9Dj9qY7/RqqfmML7d/xeFrZiipH2FEafl+aiMOHS0bvZbGQNJD
         kWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896539; x=1793501339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xv9yLRfHeZEkf9phVasO/TM2yP5oqXz3F+WdBaktVTI=;
        b=BVwEfBiFGLktalQaDb4NsHaAyvoUosY5Lnx9wCvqPJAuQ7P5a7ADS8oZ0M/E6BiDeY
         ygcBOJAh3PF5TrwkAhiihlDDKPLbaAw0Hn6MEPbP+2NkPTAMG+7zWecx9wjMuvDwYuXe
         YMZFyA4vGwpvJ4j09SC/KSHtOzsFneZC8qsLo4ng1obPiU5YaMc6Hwzf2YvGf6l988vl
         zxN7CgYzCqqSTEs++A5CVxlehMIHAefiUmbqaQDwaiSwAYQBYVeHsPDI7iaNd2I5XZ3S
         QJ4qM0ITfPK4EQPfe4AOTBbM7bBUcG4oMjFqPQTtR8ICj6HuQ+BhbLyec956NoOapvhR
         IIBg==
X-Forwarded-Encrypted: i=1; AKwUvBwL2dLhzQPZsv3M0pfFngLD7msXyCZRxWZ/8q/9NyeCltzeijwpnhJGggMp+aagKMoWA5JYGBm8yQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKTJhTVhzpJCo32iyC2dYRjMUj/rZrkDF9Ansb2CcTQacV0kau7
	H1F9zBDzb0d/ojsH++rLSnS1600FEerbhP8kJpPLcCRoqH0Y/gy8/dSv
X-Gm-Gg: AYBFou0MYVhrvar1F0R3qkvPbsztMGUaKHHvNB9/wLR/QA81IPGXaJous+eA2/uLvW8
	Z7EmEkJ6AkSUlo2TvulvNUwxCGDM8HN66Jt/31P6pVB+/dJ7YsMvBtowmm4K1fTe7eezZBwrM7X
	ZYFaIm66vQNguyaJmj3pTE2Rv1lQcliJJs3XRV+Y22U/OO+dSmFL988B3YgD5Q+9LfYtJ0BWhMS
	0M8ZVRIHrDhLqfIHvdkve+0SPSaC4YJEjI57wMVmE65BRbbl2RwnjuW+ag1isNzfC5OqAQJbkxb
	aznCKxDqxf6VzPfdmVAZzFR41ypi75qBc3iP5OS497Z5Zrf+DrZNotJRPeMQlxye3DKgQG/oODA
	OEAg3F9h/fAl8ajXFky1713CE2/cejqaDG53tlTHwvmqqldH8C6M926MtOckugOUY/hx9oRfme0
	jEN4g2c5Kon/cJVDEDDkUZiT7x/ljrE779SiPr5g5s5UZS99GvLzdz3FgA4LksbuHEo/HgUyhta
	jLDytFZ5CFzk6cmgpO/fjLJmUeD/VagjUwY64NXG7/yffoyMjveESDWDDgVbg3adJlA74+A1K3Z
	T8ePvIUO0PcGYaCIiHHDRi9RBHPwiieYoIYoRlSL5no=
X-Received: by 2002:a05:701b:21c5:b0:194:b2e5:473d with SMTP id a92af1059eb24-199298b3af6mr4872191c88.5.1792896539394;
        Sat, 24 Oct 2026 19:48:59 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:58 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:48 -0700
Subject: [PATCH 8/8] power: supply: sbs-battery: use 4-argument
 i2c_smbus_read_block_data()
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-i2c-smbus-read-block-data-v1-8-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Pass the destination buffer size to sbs_read_string_data(), and pass
the buffer capacity reserving space for a trailing NUL terminator to
i2c_smbus_read_block_data().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 6714313bb3a3..f8b194c58a62 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -424,7 +424,8 @@ static int sbs_read_string_data_fallback(struct i2c_client *client, u8 address,
 	return ret;
 }
 
-static int sbs_read_string_data(struct i2c_client *client, u8 address, char *values)
+static int sbs_read_string_data(struct i2c_client *client, u8 address,
+				char *values, size_t size)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
 	int retries = chip->i2c_retry_count;
@@ -440,7 +441,7 @@ static int sbs_read_string_data(struct i2c_client *client, u8 address, char *val
 	}
 
 	while (retries > 0) {
-		ret = i2c_smbus_read_block_data(client, address, values);
+		ret = i2c_smbus_read_block_data(client, address, size - 1, values);
 		if (ret >= 0)
 			break;
 		retries--;
@@ -709,7 +710,8 @@ static const char *sbs_get_constant_string(struct sbs_info *chip,
 
 		addr = sbs_data[ret].addr;
 
-		ret = sbs_read_string_data(chip->client, addr, buf);
+		ret = sbs_read_string_data(chip->client, addr, buf,
+					   sizeof(chip->strings[0]));
 		if (ret < 0)
 			return ERR_PTR(ret);
 	}

-- 
2.56.0.257.gf7497c7d27-goog

