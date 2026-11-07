Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061917;
	b=beqVUbquzypflqmXT1ykuc7XzDbFCpsepnUPztaGbEUoBPbV913+JSIcSWtmyT93itjn
	 FEnTbRXG34vKANI+CpVFYQZv4VzSLXXyXvsw8sKecUOoIkinYtFHqPBRrlfhbW2DHUs91
	 30E8a1spJBmcafsStrOQAALzrmm4gP9zf9pJ5iMSP57zivSY3wPP6pGVC6ixLW6R33Ve8
	 jni5t6S4C1UVNAf1onZZRUMKuKNs51R9Ce8Q47eV8ZNVxloipI7Xp88cbNCNiiC3YcKjE
	 kTb/JSY4h3u+FYsdgm6GYEsjP6Kj3MgsvTnJQNBM7QegLlDSzq7VZJSzn7D3JS/73bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZoIG6xGUckziyxrgLVSirxu4lsbujH943lx05d+W1o4=;
	b=a8Fh6tAp9x0pl07tP3Cp133nb8suLySPJoEd1U0oFy7m2jlHFD02d1iW9M7ev/gdc5HB
	 B/AQ/fFyXJb2W+R6q50sXSIF6Fxq3aqA8XjNvCB8WnEI0paEMRiIL1dnCH2F6nPDsOhBf
	 xA7pVXicRen+MsXI5xXXOyDnVMdforkXIg/FMuDFXLfZfcKFTKJ7iyxbOd1/1d8IgxX9f
	 TXPM1iKQvIxoqw5Wy5co+VN9+JbSPNGkiFOtOKN3O9VEH/sj+pYGQX796GJyShCceS3hQ
	 rpCjqc8WtifYUAfJ38SSSUh2TMTkgN+60y9kRxSYlWx6XLWyopH3QFVwf0uuSc9pOIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n8RvLljB;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09A606A334
	for <linux-pm@vger.kernel.org>; Sat,  7 Nov 2026 14:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD09A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n8RvLljB
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so9576735e9.3
        for <linux-pm@vger.kernel.org>; Sat, 07 Nov 2026 06:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794061915; x=1794666715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZoIG6xGUckziyxrgLVSirxu4lsbujH943lx05d+W1o4=;
        b=n8RvLljBZAHkGD4IUQKY4cjEjIVp1EwUf1ZM+mX/imo7ukmZy6B0+hQzfSy6y7u9Af
         PYUoU97X5VhhqInbhvz/hKxNkam9Xp3PlMb9QatA/i2r6UOn/k5gS6oaRaltzu7xG4hX
         6MDrWSk6KwT/fcsFF9O9Gl0qSFM2xqYUj+AMbopPlaE769VUF282Lye+fPBK8Nmh8Z6o
         4FfjKRfWfBU6e+CuiZQiDxLy/EGmtqHReknBtiEaDDqsn+BU5ZxUEPPyyPc5rzWno/a+
         O1cKPJfEO1Xln62oHN3OwG+SPTEHMtytOHQeiQCBkfQTbxIkOu/VSIwT39xa+1mEl9df
         AGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794061915; x=1794666715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZoIG6xGUckziyxrgLVSirxu4lsbujH943lx05d+W1o4=;
        b=sT4urjK1nMTMkpiLMXL6C8a2ZSu8PfXY24mgXm7jp/2Q03TO5y2eLDyXy5pg7QTM/n
         vMCbAmVZwbk8Pf/0JJ6coQc9cRynH6pBz/Rn+7F34vaCbvxNTkwPivl4ldPIethL7dnM
         DWJevZ4Lgeyl2hGya/R8ZtMbmPmD+yEbr12oA0QEYJx+Ez4jDz0Ab1+NTdEjXQ8R+3a+
         ze7wPXo5gt+x/elO0UAWZr/3U4aknhFC0v36zSLfGSUHhfvRtBPt0Od9O9gWz8qbR9xi
         9VjHwZ6QNlKjH4ZQ8KxuFZIhiBZBuOH0lvMe7aq3nl2b2kpT/0he2tlgY5mClgIa8Kjz
         Qywg==
X-Forwarded-Encrypted: i=1; AKwUvBxOS8QHkdgZsc7Pe5lXb58OsvjCtQvufxElPbxPblq3jIDjp1RYBxh1mtG9ITuPCzcTV1by0wGanw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8mwRUcbuQvxmbordQ3Nio181WKzNLAHZmssJXUWoFjsQg0GmrC
	HpUPU7jEtk4KvlPh95OAB6tcjZ/6W1WHSBD+Uwn4U0BHL9w9bFb0hb8g
X-Gm-Gg: AYBFou0rN7lGURsPCWKjH3HjKV3Cd4pgpEjzJp/7EJrM7l8VKuzav+fuyElW6yo8wj7
	6ecLlXNVRkp7mD9KnViN15sEnTYr6bIfU0u/0Vu0ig+wy+jd24zl67BuZ/4cUI24ZMjicP1ywIE
	/bcORJjBoL9WGvfV4c4e00qnrw1iv1poJfO8iNVT7b11af9jraSMWEGfgdmZcIVqSVcSndO7C+S
	4O+jCxNevd3dw4huzrhuVvJoy+JyxtF7Jvvrl7r+XuU1/KjHqwO9JoQhVYrkGLOHZwJV1olowOC
	eZX+hoIVUciCbDpgHQnSv7A/kx1BpfoEZ9NQLyiuqrj3YeWi0FeM4PK4a3LpxlqNyVvYHl735nc
	AU7xmYPkag4gQC1yELvaNhPAWWgE8vMTIp6hbAHH6x8mGI33jj+zhqexUxmPivAGmI9il5Wi6QI
	fXHY2auAheDlqBm0rY/P+bj5EYvFqf2RSBA6CHoPdiQttnjCYYkCFE/YZB7j/Mntztpq7ct5oNg
	pvyCWxQD3+Wvm/Ikt2ZjJ8bXVk5BRLlVdDMI8dGAZtx/cfiZdsi2eUfOuZglyezLyP+DvL7E+Ut
	sDosnszQdbB3x5vwxAbNVtjiA0vgSBndG1rqo2p4HARSUZzbatgEauCDwJy0
X-Received: by 2002:a05:600c:1912:b0:4a1:ac66:6059 with SMTP id 5b1f17b1804b1-4b6dfe8e4d7mr101867365e9.26.1794061914851;
        Sat, 07 Nov 2026 06:31:54 -0800 (PST)
Received: from gandalf.magpie-herring.ts.net ([87.74.75.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad610sm175375145e9.3.2026.11.07.06.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:31:54 -0800 (PST)
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
	Zak Brighton Knight <zakbrightonknight@gmail.com>
Subject: [PATCH] reboot: fail run_cmd() before init so hw protection can force the action
Date: Sat,  7 Nov 2026 14:31:29 +0000
Message-ID: <20261107143129.875202-1-zakbrightonknight@gmail.com>
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
orderly_poweroff(). It only forces the power-off when running
poweroff_cmd fails. run_cmd() waits for the exec only (UMH_WAIT_EXEC)
so a successful exec counts as a started shutdown.

Before init has started that exec can succeed and do nothing. Usermode
helpers are enabled at rootfs_initcall and wait for the initramfs to
be unpacked. So a built-in driver that triggers during device
initcalls runs the initramfs copy of /sbin/poweroff. On a
dracut/systemd initramfs that is systemctl. It finds /proc not mounted
and decides it is in a chroot. It logs "Running in chroot, ignoring
request." and exits 0. Nobody sees the message because a usermode
helper starts with no stdout or stderr. The default
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0 arms no backup timer. The
one-shot latch in __hw_protection_trigger() then makes the kernel
ignore every later request. The machine runs without its critical
temperature protection until the next boot.

I hit this on a ThinkPad T520 running Fedora's 7.2.15 kernel, booted
while still hot from a long memtest run. The ACPI zone read 101 C
against a 100 C _CRT 0.29 s into boot. The kernel logged "HARDWARE
PROTECTION shutdown (Temperature too high)" and the machine kept
running for 90 minutes.

It reproduces in QEMU with Fedora's 7.2.13 kernel and with current
tip. The test uses an SSDT thermal zone whose _TMP is above its _CRT
and an initramfs with Fedora's systemctl as /sbin/poweroff.
hw_protection=reboot fails the same way. Setting
sysctl.kernel.poweroff_cmd on the command line does not help either
because do_sysctl_args() runs after the initcalls.

Make run_cmd() fail with -EBUSY until system_state reaches
SYSTEM_RUNNING. Both callers then take the fallback they already have.
__orderly_poweroff(true) syncs and powers off. __orderly_reboot()
syncs and restarts.

Firmware that reports a bogus critical temperature only during early
boot used to get away with it. Such a machine will now power off at
boot, as it already does when the same reading comes after init has
started.

A short window remains between SYSTEM_RUNNING and init being ready to
handle the request. A non-zero CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS
still covers that.

An AI coding assistant (Claude by Anthropic) helped find the cause,
build the reproducer and draft this patch.

Fixes: 10a0a8d4e3f6 ("Add common orderly_poweroff()")
Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
---
I haven't tested this on the T520 itself, only in QEMU (x86_64
defconfig with ACPI_THERMAL=y). Without the patch the guest keeps
running after the trip. With it the guest powers off within a
millisecond and logs "Failed to start orderly shutdown: forcing the
issue". With hw_protection=reboot it restarts instead. A trip after
init still runs /sbin/poweroff as before.

The reproducer is an SSDT thermal zone whose _TMP is above its _CRT,
passed to QEMU with -acpitable, and an initramfs with Fedora's
systemctl as /sbin/poweroff. I can send it if that helps.

Commit ef1d87e06ab4 ("thermal: core: Add a back up thermal shutdown
mechanism") noted in 2017 that /sbin/poweroff can return success during
boot without doing anything. It added
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS, which defaults to 0. This
patch covers the early boot case whatever that option is set to.

 kernel/reboot.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 9a84401adde5..14c2bbbc5a3e 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -858,6 +858,18 @@ static int run_cmd(const char *cmd)
 		NULL
 	};
 	int ret;
+
+	/*
+	 * Until init has started, no userspace can carry out an orderly
+	 * poweroff or reboot. Running the command can still succeed: an
+	 * initramfs usually has /sbin/poweroff, and it does nothing when
+	 * there is no init to talk to. As we only wait for the exec, that
+	 * would look like success and the caller would never force the
+	 * action. Fail instead.
+	 */
+	if (system_state < SYSTEM_RUNNING)
+		return -EBUSY;
+
 	argv = argv_split(GFP_KERNEL, cmd, NULL);
 	if (argv) {
 		ret = call_usermodehelper(argv[0], argv, envp, UMH_WAIT_EXEC);

base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
-- 
2.56.0

