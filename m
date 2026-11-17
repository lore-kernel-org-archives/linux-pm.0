Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954662;
	b=iZXYxOnecmV0dkUGMa7aCx4JrxcLFql0Z4Z4IU0fumWVKEBYeORO6ujdBg3ThB+Nyk1j
	 NXaBP7eGfL5oPTpnWrd7ma+lPegdTo2MDctIXjmDaNSRdCCVq04taXMP9ZlheUTx3jmPO
	 hLwj/eA73tv8mQwoBoKG3HNVsj3pXgpXnQNrRu58dQtx0faLfeclLQ3YdankGjbVj7CQc
	 HRDjoJHKF6Jj9AAqp+38ANkCKQVLv4id9YUoUsxSbT+GlxRzLJh0S2/fvEktDrQqwbVXS
	 n1iu+W38LHY/LZHPYTCFLGaaFGnLs+jxx8PaWVhqDKR/uXui/xf57u7dGJg8g2SgMkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kn41xDmO6K3WsjRaDaey7uBoT48KF1e35QFJgiwKWm0=;
	b=3WynkBzLYg8yfklcqqmJbfT7Clv79aI7thdvRC8y0jhU1dKffwMyV8CaNwrrzlMWYR/i
	 wI5IbksepJlv0NTMIP3CY5qVoU2Z8a12WyO17PjExMQQvTabWQ10GYjQW7t6VovsC3E87
	 U6jERMVpHQavwVF4FDZh0f4yH/btJTLTKbqPsTV2SxuBVB46se8/NJwB3okwanhLokJj/
	 2rJPaDp5ywRS95Nc+9Y1BYtkWKXXKB//oWBHiFNw8d+fB0l5wBIdOa4MmF1R5Vati9rOP
	 TCHA8XFolYgFQilGyljJhE+6+ONS4GMeiADEI84N6QdgxsP+D6Jc2g0tpuJI9e0S4sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="GiJSTIQ/";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F5606A32F
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 22:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E63F5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GiJSTIQ/
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48dee593f18so203687f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 14:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794954660; x=1795559460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kn41xDmO6K3WsjRaDaey7uBoT48KF1e35QFJgiwKWm0=;
        b=GiJSTIQ/sNteBNs+3VlIyj/NfPGpq4S5n0IbqyE2sU4nKfITtpsT/DgbXvBYkMoqpw
         oC2wNeLrFEjBVqJeKrqC1doc5e5AtMkUm0JB0vBikrE81j42KSsYB4HpTvg+cpEARH14
         XCkxQMYDXnB60W1DHpGPKjIN1jN4YZjVMQAaSytJBHSwxZD+4RKhqf57KginvQzMpTvf
         HgK3cPAbqCvIfoAxbcWDXYXxNW7kbJpkeGwFTb9VFCn2Z33LzxFP8Bc1znIcGitm16Af
         FP08xwsRMRrddLQ/rEejNyw5IpjpCn04qEWy69xFXe4ZToiKCpYMiy8ZMLsX6EwhhJwI
         RkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794954660; x=1795559460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kn41xDmO6K3WsjRaDaey7uBoT48KF1e35QFJgiwKWm0=;
        b=QQgJcJmP6gByFchn1K+cbpxEgTHDbgw5XU2QsNjqsmOLId3YUNkOQSO5KOmoL82+Qh
         +OL7bdfIWkZjiPNNoSAA0M2o2+c16sKQPlsP9RdCgJphSBs+O88ll5vhLdU/iNqYS0Hw
         hYy4pl5I4La8AmMiaOdYvRpyl3g4KxDb9LnjcMk3wlSq0kePU83o7UT/+uJh7u63of74
         MWxA5I5DW3aTju5ZCG3fN4+l2Wvvzsenk7Ekq3QDcF2bn+3Kx1cXAyWvlI5p5I8MxzZ3
         7RICOC4AMIkK0FwdTcVQhfQmXbFfZ2xkY1qsdb8HEHjmoXPHqaIgWP/cVNW0w1ri6T8t
         YYIg==
X-Forwarded-Encrypted: i=1; AL+hErF/5IYlV0g7Iinvv4f+eZJ9WAGvF+xvJ3qaqZDyeCQo7gBshpyAyx0VsEuWY8zu8r7OpHFRyS0pkw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ObTzcrHQml4Cjin/V0NPeoKP/NmnV48xrdcdj5BWhyvpZDD7h
	ffvWYkAdT1pOUVBNuDauE2XDE77wAv5bKvRHm9Ks0qtfJwcdRNh5KL+JOpuS3I1o
X-Gm-Gg: AZFdTZeazk6vCL0IHyJRkFKx7FaXMJGB8FTSXyuMT3wFzgNsyjysnsFPX1XhuPPwLEB
	uDf+z+nSJNrD+/FMPdYXavoA4nQfvHPEg0EW09N6gW1KLouUIzBgVjqrkfsfiJGDDf8F2z2zGLd
	W3iKmJNFqdMSi5F8T0ouxIcYOgI8b3VyVqat+BXtBISLtBd8YfzJW28rFbbNhFFJJCa8AY8wuHJ
	n7dF2wKBy5bPMlO1l8kKMfxYgFz7PiKarTNNaw5NZVREwl2W34FQdIEkvFxU7unY/KPJ/SVM8RY
	tIzChse5XjQIoiZChTNnAttPGAM3jQPhiGIResXloTtCz5mjnjnNT198wb9lxvxGhhJMPt0c5yr
	TezJPVXD1dNs6D8WqVS1yVOTd6M7aCbSafz+v5vo0VB0RGlfSR9E5qDnhVW3V5N7hMYow2BD8TV
	dEuiJm3ZBDIuH50nP/U9FW1I1cPqY+LLqV5pr9IOqpVGN3zaEnQVSbLFirAuPT8YabOS6BPVApR
	kZC4mzSTNJyT5lA5Um6MWePYtkbyYxD0HzWDdMUIASNPJHuGEjSQhRfffeRl/R3Sq30ZnOJxBUH
	vDrn8t5I8ioj8JaYP+Im+5A+kM9Tpj7CXIpg2eIgLVxpHjTIHeGRCUYFLgjyPLZgoQmqFQUFR2i
	5V9rX/Q==
X-Received: by 2002:a05:6000:4284:b0:4a5:33ad:871a with SMTP id ffacd0b85a97d-4a62d6d5650mr2165035f8f.0.1794954660052;
        Tue, 17 Nov 2026 14:31:00 -0800 (PST)
Received: from gandalf.magpie-herring.ts.net ([87.74.56.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c11643sm1133464f8f.49.2026.11.17.14.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:30:59 -0800 (PST)
From: Zak Brighton Knight <zakbrightonknight@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	Zak Brighton Knight <zakbrightonknight@gmail.com>
Subject: [PATCH v2] reboot: don't rely on the poweroff/reboot helper before init has started
Date: Tue, 17 Nov 2026 22:30:50 +0000
Message-ID: <20261117223050.1433943-1-zakbrightonknight@gmail.com>
X-Mailer: git-send-email 2.56.0
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

__hw_protection_trigger() asks userspace to power off through
orderly_poweroff(true). The kernel forces the power-off only if
running poweroff_cmd fails, and run_cmd() waits for the exec only.

Before init has started that exec can succeed and do nothing. Usermode
helpers work once the initramfs is unpacked, so a built-in driver that
triggers during device initcalls runs the initramfs /sbin/poweroff.
On a systemd initramfs that is systemctl, which exits 0 without doing
anything. The default CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
arms no backup timer and only the first request is acted on. The
machine then runs without critical temperature protection until the
next boot.

A ThinkPad T520 booted while still hot hit this. Its ACPI zone read
101 C against a 100 C _CRT 0.29 s into boot and the machine ran on for
90 minutes.

Skip the helper until system_state reaches SYSTEM_RUNNING where the
caller can force the action itself. __orderly_poweroff(true) then
syncs and powers off and __orderly_reboot() syncs and restarts.
orderly_poweroff(false) has no fallback so it runs the helper as
before.

SYSTEM_RUNNING is set before do_sysctl_args() and before init is
exec'd. From there until init can handle the request the helper can
still do nothing. A non-zero CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS
covers that window.

Fixes: 10a0a8d4e3f6 ("Add common orderly_poweroff()")
Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
---
Changes in v2:
- Skip the helper only where the caller forces the action itself.
  orderly_poweroff(false) runs it as before (from the review Andrew
  forwarded).
- The check moved from run_cmd() into its two callers. New subject.
- Shorter comment (Bradley) and commit message.
- Say which window is left (same review). The kernel cannot tell when
  init is ready so I don't see how to close it here.
- Dropped the Reviewed-by tags from Bradley and Matti because the code
  changed. Please have another look.

v1: https://lore.kernel.org/all/20261107143129.875202-1-zakbrightonknight@gmail.com/

An AI coding assistant (Claude by Anthropic) helped find the cause,
build the reproducer and draft this patch.

Tested in QEMU only, not on the T520. An early trip now powers off or
restarts within a few milliseconds. A trip after init still runs
/sbin/poweroff. An early orderly_poweroff(false) from a test-only
initcall still runs the helper. I can send the reproducer.

Firmware that reports a bogus critical temperature only in early boot
will now power the machine off at boot.

 kernel/reboot.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 9a84401adde5..546abe42964e 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -871,9 +871,14 @@ static int run_cmd(const char *cmd)
 
 static int __orderly_reboot(void)
 {
-	int ret;
+	int ret = -EBUSY;
 
-	ret = run_cmd(reboot_cmd);
+	/*
+	 * Before init has started the command can exec from the initramfs
+	 * and do nothing. Don't rely on it then.
+	 */
+	if (system_state >= SYSTEM_RUNNING)
+		ret = run_cmd(reboot_cmd);
 
 	if (ret) {
 		pr_warn("Failed to start orderly reboot: forcing the issue\n");
@@ -886,9 +891,11 @@ static int __orderly_reboot(void)
 
 static int __orderly_poweroff(bool force)
 {
-	int ret;
+	int ret = -EBUSY;
 
-	ret = run_cmd(poweroff_cmd);
+	/* As in __orderly_reboot(), but only if we can force the poweroff. */
+	if (!force || system_state >= SYSTEM_RUNNING)
+		ret = run_cmd(poweroff_cmd);
 
 	if (ret && force) {
 		pr_warn("Failed to start orderly shutdown: forcing the issue\n");

base-commit: 141b164bbe186423e295b139e40e8e2d11cf1341
-- 
2.56.0

