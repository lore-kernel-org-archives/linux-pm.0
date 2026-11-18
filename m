Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999000;
	b=VHhahhbLp1wS0qEjVSi+5tCtrQbK36IYYkX9siqQtUUnOT+wV/OTiRJVP2lrhe2Zfnt6
	 08gSsFKcmSdSVp1t64XwZ0nRHxKOyAKqmxkKg1ep69fJWyi3UCvvZYR05v5jjjXf8xoQ+
	 sOcQBfEQ8/XRPiIR4kYDrHZEnP0YuP0jG+bU3xUqV4DyLNdssKchbUEG0b0uEECM2mMCc
	 dr0JCOvxAGfmqFAuM6RCRqveCHMuVBnUiCEB+PuXNom9Xz9zWXKwwTrP5QGpE1fNs8yv/
	 dlyO8wQlc2lXZxrLUG7YtFO5uchAMdQe/6rdI9yQbAujw2/qepCzAtt7hlY4OyaF1Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fimuKL704+w6i+p1mK714enmZrR4sYS+1W8BVN4RDvI=;
	b=T59rMD8Tcnf8jlVF+ASBOBE1u50T+dXwFXHe3GnvluTd0c2LZFEL7j2tt3Ld+xCrlITJ
	 AZC44nokgrlgVDFqkG66V4lCZTpq7zwdm+TLxFAdHMLPebWkjHzouS+YVsJi5mcH49mli
	 xCBTeVPGtWABLlhV2vaNNQjU2fyQQJMcUZhngS4xWlSyspVpp9gTh2zhljv4TvT1ZgBpM
	 RikKuRUMf4itzD/IwiKi1bme29Q4TRZ4c/iU7KIy+pv/9VRBtrI0r5RZy29kfXNl5FtQx
	 Esi01z0u9LH8SBFeQnlIGD8AE48PrHPEWUidX6yztQofJ2PQkldqk774GB70dLCBMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IKL+IduS;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B736606A330
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 10:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B736606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IKL+IduS
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38318d69173so199380eec.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794998998; x=1795603798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fimuKL704+w6i+p1mK714enmZrR4sYS+1W8BVN4RDvI=;
        b=IKL+IduSHt8icXf7vsf/3N8oH0GRw551xT2y5OyDyRsDrs56U7awFNd8EZkpDthz1/
         eDRrSJnXP1k7vbjb8UsZrZpA+ffvyNwT+Tt3CCw8pZtgH0ygFYe0+48TSBouwgmTNp2Z
         slFGSTYqo5XuYigR9GvizeAJ6KuuDlAygGxEZvkq78xFTI4Pmbh7JpwQbC/twyJwRwvq
         e55U8Bq9S4ElelkYANd4q1J9Bez+nTvgItPm77Fe/vfv8fk419ChNyq8uM1wKc0N7K02
         ToHEJmbh5Zn+9h7HJV6DoNur+YgtCkU7boryD5EZuJLQvyH/Ul6frjivPmWr9EOgzKnH
         +PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794998998; x=1795603798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fimuKL704+w6i+p1mK714enmZrR4sYS+1W8BVN4RDvI=;
        b=AZjPPEgIxF2YTvEhNMjB8uOVXw5+gibQWkKWWuQLMJW9yzQ/6V6Gk4olYLC/j34L49
         9Y4sSLDy7dPRl0d8iKqxjXVAqUtkukA3QUiyM2Yi+lvUjbNl4RavoQSSVjH9n7w5R8RO
         7zempNMb9Us9a8d3riQthZGDnPh1jSV0GWKE+WSl+/O12Rp+QYD7wZUwUd0JSWWCsSYp
         prvDUfwLjLcFBSkupCsZzfa5AAwfSinb/ZWlNYKB57/zPNEoYlQb5OOfjL1/T7Qik9hF
         WJum/Fp4GdCFUq/6gO65U5P2j6p4/39Pn8IIoJ+ShSjwtSDkR7dcXQAa78tEhy3n3cFC
         UC3Q==
X-Forwarded-Encrypted: i=1; AL+hErH307C0WfiRF10HsOx7RD4Jk1T1UGOWH08K0TuO8YT+AfkThxuSKuEZ+6TnpdZAsd+aVYWLeAtrbg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+MKByL89aylmJjy6SuaKZOod0XO0kxqvaCPNve+j6mHqn5P8pI
	kKMW6u12APaWiTNWX8pyn3aTLzbyA4GBlRkwz1W6J23cq76vMhQExgky
X-Gm-Gg: AZFdTZd7oM2mMCAwcsFyWNPV3ONHutSWMyQgUx1psFe7m8dsaeGqENHdy7TgfDeCBAK
	lO+eO8HCaN6xtrUOm6u8W/UYW7GPd3/si41D3txmIWDzXceN5XZn6tBdhyQ8XTV+UXB/UJakCPT
	0C7KW/UwrekyqzPeM42Zf0rEyKUQrKu2EB+YlvpgcIgDbrkdBaIbCqxLzk/9ODiQLJWdTInH/uP
	qDdvkoWRApLXlPMbSfb7g7DJZxMVruXHDnILg6DGY8sLDrN8IkqZpGIyhB5BS10qQD6EaoTFzeG
	FKmNvNciYI+RL5F7ygxhqgNAG7svja1zjTOiNWyJ4fe4hjPe/ZJEWFm4qSHS9XfQ6HqCbdO/joP
	i65vM22vVcV/sMG3cbned62K308J7ZSXrt2wJWa2PcO4k/WJ1CLcu/rNDRH4q6zkTwUcEMxZ7jE
	V2Y1meXjJIAB3xIYAIX+T2u6PqYw1VBPxqBhrLnYKJLBaJOjl85t5AuvC07zvTZ6pnfIRA9J/sq
	ST56w8i5h9dYKfvOR1zxmRs781XZq66qgvQWZr+PTT2oIUjq+qPbq6AQTOzzEcfrCUo46TRWfm/
	/xCENx9//4mwR8JE/JdXxLCViAh+CKte
X-Received: by 2002:a05:7300:d088:b0:381:a911:1772 with SMTP id 5a478bee46e88-38281215ba2mr2333979eec.22.1794998998227;
        Wed, 18 Nov 2026 02:49:58 -0800 (PST)
Received: from archl-rock5b ([45.112.0.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45260a8sm11729913eec.3.2026.11.18.02.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:49:56 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS),
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 2/3] riscv: sbi: Register SRST handlers with firmware priority
Date: Wed, 18 Nov 2026 16:19:14 +0530
Message-ID: <20261118104935.1716-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118104935.1716-1-linux.amoon@gmail.com>
References: <20261118104935.1716-1-linux.amoon@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI System Reset (SRST) extension currently registers its poweroff
handler using register_platform_power_off(), which assigns it a lower
priority than the default PMIC poweroff handlers.

On platforms where OpenSBI handles system poweroff, a PMIC handler may
run first and perform I2C-backed regmap operations in atomic context,
triggering invalid wait context and scheduling-while-atomic warnings.

Register both SBI SRST restart and poweroff handlers using
register_sys_off_handler() with SYS_OFF_PRIO_FIRMWARE. This gives firmware
handlers precedence over default-priority PMIC handlers and avoids
board-specific workarounds in individual PMIC drivers.

Defer handler registration to a device initcall because sbi_init() runs
during early architecture initialization, before dynamic memory
allocation required by register_sys_off_handler() is available.

Preserve warm and cold reboot selection, retain the existing legacy
poweroff fallback, and report handler registration failures.

Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Suggested-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch:
   Link: https://lore.kernel.org/all/20261110061429.2036-2-linux.amoon@gmail.com/
---
 arch/riscv/kernel/sbi.c | 43 +++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index af1ccea222f1..ab6e5bf25411 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -512,23 +512,50 @@ static void sbi_srst_reset(unsigned long type, unsigned long reason)
 		__func__, type, reason);
 }
 
-static int sbi_srst_reboot(struct notifier_block *this,
-			   unsigned long mode, void *cmd)
+static int sbi_srst_reboot(struct sys_off_data *data)
 {
-	sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
+	sbi_srst_reset((reboot_mode == REBOOT_WARM ||
+			reboot_mode == REBOOT_SOFT) ?
 		       SBI_SRST_RESET_TYPE_WARM_REBOOT :
 		       SBI_SRST_RESET_TYPE_COLD_REBOOT,
 		       SBI_SRST_RESET_REASON_NONE);
+
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block sbi_srst_reboot_nb;
-
-static void sbi_srst_power_off(void)
+static int sbi_srst_power_off(struct sys_off_data *data)
 {
 	sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
 		       SBI_SRST_RESET_REASON_NONE);
+
+	return NOTIFY_DONE;
+}
+
+static int __init sbi_srst_sys_off_init(void)
+{
+	struct sys_off_handler *handler;
+
+	if (sbi_spec_version < sbi_mk_version(0, 3) ||
+	    !sbi_probe_extension(SBI_EXT_SRST))
+		return 0;
+
+	handler = register_sys_off_handler(SYS_OFF_MODE_RESTART,
+					   SYS_OFF_PRIO_FIRMWARE,
+					   sbi_srst_reboot, NULL);
+	if (IS_ERR(handler))
+		pr_warn("Failed to register SBI SRST restart handler: %ld\n",
+			PTR_ERR(handler));
+
+	handler = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+					   SYS_OFF_PRIO_FIRMWARE,
+					   sbi_srst_power_off, NULL);
+	if (IS_ERR(handler))
+		pr_warn("Failed to register SBI SRST poweroff handler: %ld\n",
+			PTR_ERR(handler));
+
+	return 0;
 }
+device_initcall(sbi_srst_sys_off_init);
 
 /**
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
@@ -677,11 +704,7 @@ void __init sbi_init(void)
 		if (sbi_spec_version >= sbi_mk_version(0, 3) &&
 		    sbi_probe_extension(SBI_EXT_SRST)) {
 			pr_info("SBI SRST extension detected\n");
-			register_platform_power_off(sbi_srst_power_off);
 			srst_power_off = true;
-			sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
-			sbi_srst_reboot_nb.priority = 192;
-			register_restart_handler(&sbi_srst_reboot_nb);
 		}
 		if (sbi_spec_version >= sbi_mk_version(2, 0) &&
 		    sbi_probe_extension(SBI_EXT_DBCN) > 0) {
-- 
2.56.0

