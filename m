Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806598;
	b=TUR0k9vTdU1+ni1lP0H+igEh8ELYmblBpkz6LkP1uDvU1zPQRliILPW+U8o2Tt4+ipc+
	 8Si6274tGofGJlZCWHVvU3UDm8YiWHQpSZzdTDsUhhTnljDQ5HRDZhqFdA8jCNNbiWDCA
	 ARfrNSVIHMqkGphHJsaSuIlEA3+kXeNCx5Lnu7vDZsLsu4u8W9v1vB1ZTBn8ToBO4Fkqr
	 TS9B9v9Vk/u0fE4GQnhMktJbRMpREJc6LraYOdbNjrTi41Ux8XHlZOAmm3/ip/CfzYLn1
	 Qmn+XNR+xuWvNrmLPxFdTM0vKb6aJ8GywTBMw0PJAplVJw5Hco0BlunzIBdab/59X/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=U0mDUtMC+UWGZUbp+/6kngYQYdcHCcyFlHG1lR13jwk=;
	b=JlgPhF8jv3d8OI2capSt3lYJMiYtdSso8DbXfXPm7A06I1ypkNoHbenuUxXMndS/Gq3v
	 JZpMtGPetK2Tl4ZaGmYdTm8UJjEufhlfvSUYwVS8gD78ijSujf+DXDsZXDHSFXZGEiRKG
	 PpOLe04xaozLZ4uk5NqYiMSjjTqW9yjBSKTe79NALYIh6KYybnLroNFo5hL0m//s1cwL/
	 +bzGYeOmCaZqhECOTaSLRK7+vZ9/zU/c1T4SzRViXrLT8egmLxCgOyznNViD6D6qJEi2u
	 Egtzhzb1N79G4YTuMlrQRZuw/iPvgWjyuy94DkabsHMHXRMvZ389A5JHk55dkJgfnaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t1IeGCRZ;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45574606A685
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 19:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45574606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t1IeGCRZ
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so1349265566b.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795806597; x=1796411397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U0mDUtMC+UWGZUbp+/6kngYQYdcHCcyFlHG1lR13jwk=;
        b=t1IeGCRZ/lvgaOLnwNNmsq9E3E1xueXDnAYLXr3+EurSjEscFyEs2gqVIggnq+Z958
         B8f1/UN6PbxLTVQEjgGK2N1xqr/AQSU99qs6UvT9rBD7VjKbzUA/jGHs/hs0GhbC0Dsj
         ek0gaok5GZNKll1aM7IrpHYay2ELOEE5YzGO9pKfVDkt1nWr264eDXPMWS2FQY7yqvsk
         mZvHe/yqaW7qD+s19/FCHOsATOIl0JSVMiOAs2TVgECrSiD+B7o5rhV39VodsXOofsYi
         40WhxVCWZ0YmechQxer0l+QWYQJl3/Y3Iv6/kIatP6ddHTUQousOlyG8de29NuDy9cg0
         PGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806597; x=1796411397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0mDUtMC+UWGZUbp+/6kngYQYdcHCcyFlHG1lR13jwk=;
        b=IZ2VSocYrGxcbAAHTJah1aucudmM3deqr08s6AaOPpA67OEJ4eKEOjYYxQ27jwb9Ug
         Y/WxQXBweIwgA5/qtZ7MZ9yejQB4ODUBH99zzMC9di2VNsQB27cryufn26Qm0BDmifEH
         qP6v4ZgGQktPvQdECHVvKQCukeqmHoGX5NvbSKXpOIXC4GVdS/UO/gWA/OLX0ijexCIj
         6G7qQqJ/7/mFlO7ZjiePLIVgTsI1FkBzX+sLGT2Qfj244AUSIDVt0qPBlIR5TESSLcrC
         aNh8OUm7QXGNx7/XjJ2aSU2YGxYfqrIoR+B4w2gGGNZDCBjyh7krYfdRc209wXFefRhU
         CHlA==
X-Forwarded-Encrypted: i=1; AL+hErEsvk4hU0nEGJWMyfk1InnLCoMH3J6dJpCHyh84PnTAoQ+S9WGUlhiBUaONFaC3AZB3ymLCZL7qWw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/gysc0MFSuidG0oSKD50EkDauJcU0JiFcRtST/uvPhh7Pc+HG+
	pRZDYplQAb9CtmoD/QjPPotnVuBiN1OmlYEA6YHuHEkM0L/6XQwuavmo2HRmFKtZHOo=
X-Gm-Gg: AZFdTZdNVjh3kVe/pIZqc6bs0zX4/qqFxKStIRjc7oQIVmorMGDQM3UmB9PF3Kvghrt
	a76iX+bmdKiNId23jcQUq5y/cYcQHN/J+LMhFgFnemZizrTwelRAnFWamGiLaUoJpm66SNX9UQN
	DKMHanZGcHUjWpm8pJjy398HDVc2L2GubDbPg4O56Oslqf5Ree41MQRv0bM/8l0XCULUq7y7Im/
	yPdU0yz+KKY4PCVUBig42CST9hvn3Xl+lVIaTjfEOIcjiam62X9tRq0rgbxt3xtqjCznWnYcWvT
	b9Q6fNSE7T8z8fqipQP0/fAhZbpRcJaQI15dNOXXBMloN4kcXEF9Yj9FdJHJjPVBit1/gfSl0fg
	h7S+9cvhoJIlka2ycrv7E7BS2UG78olD7hdsLujlAA5iuQZ7qancWs8S98AVUaQXUPdaQbhs+7+
	3H9jHJWPsi1QZgha6refzuVW3YtYeITGAY9Xvxibnl4NTXd2tkeeYcCxFniY8Qd9UWfnW5zfqzn
	cQE3m1ny5g20aSRGTqcMtjGAianq2Th6upZQ3SB3Tbij15jxRHCZktuCqDalT5j0LDD1Lr4vn8G
	AgsA0Eys+3rqXkLr1wN94Yh/enHr5ZXTLxhZW98xW3impGBSjbcCUlr6Srq7j9GwXeEoJ3TmPzg
	3YzKk8x7pE52R0J3y1g==
X-Received: by 2002:a17:907:a890:b0:c50:9432:b7e3 with SMTP id a640c23a62f3a-c513aace654mr2369091766b.42.1795806596623;
        Fri, 27 Nov 2026 11:09:56 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm909175266b.69.2026.11.27.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:09:56 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Nov 2026 19:09:54 +0000
Subject: [PATCH 3/6] power: supply: max77759: disable AUTOIBUS for
 CHGIN_ILIM
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261127-max77759-charger-fixes-v1-3-b364a0862d72@linaro.org>
References: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
In-Reply-To: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Programming CHGIN_ILIM in CHG_CNFG_09 leaves hardware automatic input
current limit selection (AUTOIBUS) in whatever state earlier firmware
left it, so the programmed input current limit depends on bootloader
setup. On Pixel 6 the bootloader already leaves CHG_CNFG_09 at 0xbb
with bit 7 set, so there is no behavioural change on the only in-tree
board, but boards whose firmware leaves AUTOIBUS enabled are not
guaranteed to honour CHGIN_ILIM.

set_input_current_limit() updates only CHGIN_ILIM (bits [6:0]) in
CHG_CNFG_09 and never sets bit 7 (NO_AUTOIBUS).

Define MAX77759_CHGR_REG_CHG_CNFG_09_NO_AUTOIBUS (BIT(7)) and set it
together with CHGIN_ILIM whenever programming the input current limit.

Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max77759_charger.c | 5 ++++-
 include/linux/mfd/max77759.h            | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index 6876ae0a8188..49ab1766cc5d 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -355,8 +355,11 @@ static int set_input_current_limit(struct max77759_charger *chg, int ilim_ua)
 	linear_range_get_selector_within(chgin_ilim_ranges, ilim_ua, &regval);
 
 	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_09,
+				  MAX77759_CHGR_REG_CHG_CNFG_09_NO_AUTOIBUS |
 				  MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM,
-				  regval);
+				  MAX77759_CHGR_REG_CHG_CNFG_09_NO_AUTOIBUS |
+				  FIELD_PREP(MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM,
+					     regval));
 }
 
 static const enum power_supply_property max77759_charger_props[] = {
diff --git a/include/linux/mfd/max77759.h b/include/linux/mfd/max77759.h
index 7c0b13219d51..79d248df4c9f 100644
--- a/include/linux/mfd/max77759.h
+++ b/include/linux/mfd/max77759.h
@@ -102,6 +102,7 @@
 #define MAX77759_CHGR_REG_CHG_CNFG_07                  0xc0
 #define MAX77759_CHGR_REG_CHG_CNFG_08                  0xc1
 #define MAX77759_CHGR_REG_CHG_CNFG_09                  0xc2
+#define   MAX77759_CHGR_REG_CHG_CNFG_09_NO_AUTOIBUS    BIT(7)
 #define   MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM     GENMASK(6, 0)
 #define MAX77759_CHGR_REG_CHG_CNFG_10                  0xc3
 #define MAX77759_CHGR_REG_CHG_CNFG_11                  0xc4

-- 
2.56.1.839.g22a8290db9-goog

