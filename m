Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896529;
	b=REaZxIhdyuBPLNy85x7uBkWN0wGz+/g8ria1CQ8P03aPtRn0UE762Ctu5jfY3n9DhMvj
	 7r9Zm8rX/dBuAuCZtKnU/2ocImPU4o4pDOoyv68dZF9ifVcCwRmTYj+roSuxiqVSKMobW
	 wcpivNdafHqdujCz+5/W2Cj7gopg2fNBwWgZFEHuZDGY8UTA+n5svdlXMTalEbL56ifq1
	 n/jjqo5+k+6MtPRmmYCWqqVu8hy+QTeMlC/eZmeBbaGrIAKbe9rXwM1y4/E8TnpWFojBV
	 W4o4KfQj0G0/YZLjqxynzGzh11ObN6is2VltC4D2XePy1sdSJ63vLwYTlBNyPsc/LZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=FRxwvjYywW2EDj8EBeP8mrgqVWNhsI+cL4nt5lpU7sA=;
	b=CsZTox43xS8/TsprAXPIqU9VO/zTajE0eyOxhNQD+L84cRyCRNKxokD6yUOlw1Kt1v2x
	 WStxYgvb75cqwhe/krH1ZDwBO29VVta/zo6A8b8tdlHfvnvzV/6WlBDC+l09t10rXKwgS
	 gPMkGyyZ6g/KT56bg1b/xa/1DT1FzUyvRjNr+03cZWy2PbAyk5sqzdVKYppkVXK5r2Nqy
	 UmtN/XzLmu2ra3rAiqi/RdrkIpE7E9Bo1yRcaWXO/mOoteqliahZjCtnre+qXwX06j91K
	 8rqr1nduyS9BxeLt6DuSHnOSpusRbGhSChpfgGte4rQTC3o9MVaMoe88l1ZgfzJtpAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TpxwA813;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE24606A333
	for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 02:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EE24606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TpxwA813
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-157fe9d771bso2424416c88.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896528; x=1793501328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRxwvjYywW2EDj8EBeP8mrgqVWNhsI+cL4nt5lpU7sA=;
        b=TpxwA813+P5znsifZUJ8deji2Cfy3YNYm07xUH+eLP83aZg54OT8spSktYMe6uqGRE
         iQECHez5gjvBbx6xLGeVbfT8DSZ1k8Qt62vdK8EaDhI3b1+wztqIkJbaJlCtnuCA5esL
         QRH/IaQA0IS4/4rwKKtRZShp/VJZY5B2CGAQ4+oQP9868SHQzHcsRMqbIUIJIrKAZ80n
         lruFtXxmDd9FsV8X+PllJ668rF3ZZJTTNnl5/6dcw99NfAg8N0Yo5T4C0J1RuHQYX1ve
         +cFbn2eSkjaZFV55MBT+LCMMz8FPEg4aiNN52QkcwWnlvHZrZ4/6zCg7MfQQ7POzh5gG
         lE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896528; x=1793501328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRxwvjYywW2EDj8EBeP8mrgqVWNhsI+cL4nt5lpU7sA=;
        b=AlikhuA9GqPuLZTmxbRZD/gmU9RPQ3+QcwG73zTX0yJcXwiuc0XEO0V7itg9zERx8B
         R7NDd0Pgr0z2wxDQ4DRgTYiIPdmqc3RwctYpw6cAInTENQc1wpvEI0ycGWfGSvzJ6LQO
         QdKyqRX72VunhYucXAycm/NS3ezXyB5JylRFmpnFY+dUCPPlluPoIWF1mzTql9luiCy1
         lPrcSO08Qdfu6csdzN4cjWVi2J3zRuJNLTnYzh6BykNqr8L62dESD71+QOMt+C4VZiZ5
         cy5d1SI4D9bvwaLaQEmDV/tU+4CsWU9ngTb6X0I+R9rX2iP4RXYCYixiwEEDfjfUWqML
         mPlA==
X-Forwarded-Encrypted: i=1; AKwUvBwcfpk+LVXVxo4SDrfsUwKMUM7sSYmUrZZXDo9h9yb3FG6jPind+gP7z9wRUSEZvygxJMoj4sNR6w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIzwXa2EIAkmYdw2IrSiuK1uCUdw0OHSuCSp0WcEM5Kjf9m2Ufb
	QDm0eFSR+D7dpnKWoH4ib8OwC9qHvkvDW8o3jibiNrfxNY2IBwn2gFAF
X-Gm-Gg: AYBFou0sX+xYlXEQ08ZLxAshd+5ow4xBpL4gLPp+sga+MuDPiy18ddZwJ5olrqMsaxa
	kKpSiff5by3cp9bZc+pAwKxfmpZA09tJNGfmtJymk14NxWGDJceYab4hRr4e665wXrFO0LBKmEA
	XQEoCQaFsq0MmTU2o/u1bwrpoJAMBxZRI0zzcJ6YSw/U7Y6KTPNMFCUtj4WLlFECUIBjbE/gAFe
	3nsvnOsK8M3u5jv0yo05rTxrbv4ivFs33WcW85hsbo/zIlIcZ1M3qnD5PZQxNK5Tu41MFKp8w8U
	TmniC+ZCVfC+1B1dAqEDwUthJBlai6zrr6SW+VwTkKXqs6KiBzyheyGfkECMm2RxCEYoEzyxNNN
	eMaxgVZU4TFox7TmmRxwUcYzBKSc88bWAYA8jnLG2LwR+GuxEVi0OKB6xfqvc1a6VuWQBR484I8
	RIua58HSjXTHUWpRQwZHqDzTcxuuVhKFY9DGv3XJc/w0Ruaci+qAPxIiM6Pcp/W3r20yO3QXXRU
	9IZY75y/JmusCxq7R/fc2CpEl0bZ1iWuXE2M+Kuvf39UGuw/nJhx1nD+g0UbivcjaqRz8LHT1pS
	TNYLZI8KfVru32YuxqaoGLNdtOvcLI/7KEaxMp/Isak=
X-Received: by 2002:a05:7022:1087:b0:17d:7b45:f905 with SMTP id a92af1059eb24-19937025befmr4633321c88.31.1792896528487;
        Sat, 24 Oct 2026 19:48:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:47 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:41 -0700
Subject: [PATCH 1/8] i2c: acpi: use 4-argument i2c_smbus_read_block_data()
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-1-19bb97467982@gmail.com>
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

Pass I2C_SMBUS_BLOCK_MAX to i2c_smbus_read_block_data() in
i2c_acpi_space_handler().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 84841ed13487..4acce685457f 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -751,7 +751,7 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
 	case ACPI_GSB_ACCESS_ATTRIB_BLOCK:
 		if (action == ACPI_READ) {
 			status = i2c_smbus_read_block_data(client, command,
-					gsb->data);
+					I2C_SMBUS_BLOCK_MAX, gsb->data);
 			if (status >= 0) {
 				gsb->len = status;
 				status = 0;

-- 
2.56.0.257.gf7497c7d27-goog

