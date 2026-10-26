Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006464;
	b=YWGhfIZsWqUyRoYTSJsbhglKOIv/6BEyETdIfKOqlJw2yq6GNHOPXu/HnxZoM9Kssz4f
	 iBLsvivKiVJy6zxxVqHKrEnVi8sOMhcyhXN2zrA9+JXEQ1q4jHTFMfnyYON7Qtxjgd1FP
	 Qsph9e447ZqPapm/JpfPOtTUq68y0QFCju1INJiVmYTnFVlgr1P9Hmb1QlF+1N66kE0wX
	 W/3orBVGhar2H8DGDcoQKCbJhtaOfle4GJmo5VmN9LrTc7HZa4gxcbEDVRH7MOD6FaVQu
	 RwpipEJco2NTwpld6vsDLjtimyFI2FcrzApDQeE5mAZFSa5mdv7AZPbpVExAFHDRxew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6iSIIg6+P2EzQoPUDKsVIp2JOndBTgeQtF66YjINF6E=;
	b=RjVE07poT1837WD36QZzP9Az2Ga6mKNqzeO0NJy+q4CYTxb0AtblebOeFSb/TlGmD1Lf
	 n1lxRSWjd5iTQojbmzFhP34J88Gf7pk0p8WWWm94DqN35pfv8XsauEdjBF7fZSOr+HJmS
	 ITp9zVWpYt9KWrFeSJY4dcsZaCvF2+ukb4qZBvizG6HbGnSUILaH0ITKHqdT4RzBvOrEd
	 /GN8ebyQREuvIz0eTSpWp7eI85beWsMlvYsbWhqRAZ33bQY424G7BOI/k635C+OyKBq2f
	 m1D8iVDMsvuo3fAI2JOXAf7uNrwwJoe4GUNXkBl6nVPitlIYOYOhaPH3dwmbnvNACsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WJtuW0+P;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C444606A323
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C444606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WJtuW0+P
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9f6a16aedso18243305ad.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 02:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793006463; x=1793611263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6iSIIg6+P2EzQoPUDKsVIp2JOndBTgeQtF66YjINF6E=;
        b=WJtuW0+P9oBFSy0iWI0B4zGLQ1rj8lafFkQeBrQtdVN8XcMXqOyCVwKRuCjkNZmgaN
         t1loMPGykOOdZmalrN2T0WjE/LyzlTnGbQF1jGzkpGXyLZxTwHKGr1Ml/dCgz07biWsb
         nJg5MTdvPqWxltUWGMPnR5WTk6OG0Abuc8KLSzbf/TCH6Ga07yVSp2rWIXaKZTHvoBKp
         5+haGFq5yHhn32yhknh1XIKHgVmTkdxonzIVWd3/kEaTmND84kE6cg8H2imPmh4M72W8
         8m28fg5oJabgWFzjLFsK3VRcGJ2F5G063gbteVa7G/alxXSfw6TIr47M6vaoDjVuzb35
         qghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793006463; x=1793611263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6iSIIg6+P2EzQoPUDKsVIp2JOndBTgeQtF66YjINF6E=;
        b=obENBiMJBzkIU3Ke4zO3kIxu7T/cJLoX8+m54W1pBSigX/+rbmiHAurT5/fRoUVmwH
         f0umk2FlZkxxLvsEc4zVqa+JGg6kwOWLayoieAebIpY2vu/TkemkvbczAEn3+2KB56Ke
         3PATHQvzf3tGORu8S9F9Qh1eKbGBbMh+1xGhwu51FwJC3S2BNnSPx2ll2uTIW6Qhq7Wz
         rx2nAmzPrAumVG2kMrgIZ14Ym1riMnAqlfFPCuIvSBtuO+X/GFJSwv722Cec5/8H/1oU
         rez3PweZCLY3jhiIAmRtVnuv0DBuDLY6ybTOY1Or8HoRcyuTXdFxEXE5fpdnZ0rsZSWX
         LqrQ==
X-Gm-Message-State: AFq9FYK+/ivzCttCVfczWYB5YoHu8XmJtE0eyRnc5I5yz/2yG16I27r8
	ofyND9SIwrsOb+rJh1yBywlUtX4rO2i7heS6z3SlHppwHSvh/ZSYybTn6FAs3h02
X-Gm-Gg: AYBFou1R6iDrJD1BH7OLI+c1ws8zKsnPEkZrPWJKwrvZqqVVW2HEE570WzyN30/rZAe
	2ZTq8I47fFRA6ZTogUtDym3eatz1fLu6omge5l1tlwSINtW8SGpK8TM6TnDZ8aVKeCcZn4js0Lm
	nhEYQ0B2V8eDVf09DieSNnHvQA1x3cUk5ReRii1tNZ9kVB2NJiT2Rou6Zm/jcEnB+G0/I690POo
	17ZJDjO87llZe/Ps4VlbEK1+R7Dnnwb6HY7vMhgmfki4QeqjGXSVMbWeAtl/gNXwlPRIA7P6hCT
	3CV7oCioYT5U9bfXaObM2ELjQJbC8Uf9oPHBZ0ssBIIkUc1fgcCL0UCAMblDvQnrZqXPbGfj6rP
	yW0/Ya4/rNnI8eYngJaXGxlc7EaNotruXYtuvww0K665K7mwxKcEqTlbRYPt9li//K+3u5SmhRK
	1NcTcpgTFpc2w5YzjCr6OBnukq5o7Q7nK3FG9O35ln3hoE41yDw7U0b6J45j70zWB/hXWE+4ryQ
	3L6STI1Sawh7qc06XO1AjV6w3Ubl1H2cxqk9DmoHdFhR6RdcX7Eg/ia4UN4gPxQcDjKmz8opZTl
	/SJ+HA8=
X-Received: by 2002:a17:903:3805:b0:2e9:460e:ca57 with SMTP id d9443c01a7336-2ea9c66910dmr57327485ad.15.1793006462680;
        Mon, 26 Oct 2026 02:21:02 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6212:1232::1d0:de])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1215d2sm13517905ad.15.2026.10.26.02.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:21:02 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-pm@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Feng Kan <fkan@apm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: reset: syscon-reboot: Use devm_register_sys_off_handler(RESTART)
Date: Mon, 26 Oct 2026 17:20:47 +0800
Message-ID: <20261026092049.84858-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The driver registers its restart handler but never unregisters it:
there is no remove callback and the notifier block lives in the
devm-allocated context. After unbind the freed notifier stays on the
handler list and the next reboot oopses on it, observed on a
Hi3798MV100 board (PC is at 0x0, LR is at notifier_call_chain).

Use the device-managed registration, which unregisters the handler on
driver unbind; the DT-configured priority is passed through. This
mirrors the conversion of the syscon-poweroff sibling.

Fixes: 09fb07bcaf52 ("power: reset: Add generic SYSCON register mapped reset")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/power/reset/syscon-reboot.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index 60e855cae68e..348a9550e9e3 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -31,16 +31,12 @@ struct syscon_reboot_context {
 
 	const struct reboot_data *rd; /* from of match data, if any */
 	struct reboot_mode_bits catchall; /* from DT */
-
-	struct notifier_block restart_handler;
 };
 
-static int syscon_restart_handle(struct notifier_block *this,
-					unsigned long mode, void *cmd)
+static int syscon_restart_handle(struct sys_off_data *data)
 {
-	struct syscon_reboot_context *ctx =
-			container_of(this, struct syscon_reboot_context,
-					restart_handler);
+	struct syscon_reboot_context *ctx = data->cb_data;
+	unsigned int mode = data->mode;
 	const struct reboot_mode_bits *mode_bits;
 
 	if (ctx->rd) {
@@ -113,11 +109,11 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 		}
 	}
 
-	ctx->restart_handler.notifier_call = syscon_restart_handle;
-	ctx->restart_handler.priority = priority;
-	err = register_restart_handler(&ctx->restart_handler);
+	err = devm_register_sys_off_handler(dev, SYS_OFF_MODE_RESTART,
+					    priority, syscon_restart_handle,
+					    ctx);
 	if (err)
-		dev_err(dev, "can't register restart notifier (err=%d)\n", err);
+		dev_err(dev, "can't register restart handler (err=%d)\n", err);
 
 	return err;
 }
-- 
2.53.0

