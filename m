Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064402;
	b=yhw2S/GsRlVv88YcTIh0lifQDjq8NIcvrpRsENnzVh6nj6h0CaZF0Od9z2/XYJznCtRo
	 7U34pNhq4RH9EuqJ3r7l5hcvoBFiGU2dUCrFJoV9ylxGh+Mg5lJK7AOuEYJRfDSsigFmO
	 LXsS3WgSda93t6dHDkBzx7AImTTlffpb9IxcX+P2A5S4/Yow+yM248ssq0Nga0F0GuDNc
	 oxzyq7EDEJlevEiG4osVEZaLo/VyoHAMjXlL+rVPjCaf4TngeliV8JcmBLq8volFeH6Z3
	 j5KXfSAvcPzPfK9lGIvzwmgf+311XSYq26Zu4PYteJO5JTPjpo6k7V4ARppOvCISw1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064402;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HZ1sMAQnsO4h3gBSc4cW8ZYQQAs8UR5LsG1+6TNnwlA=;
	b=NygC/JXhCkt7QDfoNsC0fMI77TIR4ZnoU9kig5uNptW4zowO+/N2yx4E1ChvXBzDVvl9
	 VJQnIM1yqr26TY4YLGl0QDWyu8PYuXJoMkHyrsfnuEZVN9BrNKTXwXjZGblrrOjBXLrVo
	 uvt46+OqM3QvcQY+NSvY0cbdhp/W1wlXxgkiXfFLhWxiKeHi6MoW+iNRPMUEeVEfZMHKa
	 v0uXCp81aepSuGZXS3LoJJKE1X3noBrV2fEaC2OdfikiTqIvLZarP9I76mNhP+ghoyPsp
	 yJn9BgQX+w5/9FiZEoIICdLwcU+tZUYr2LrBsbTSpHgSzGlx5DtX5xRCBTk4dEPbgWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=CCev84UW;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b="3GwP0/b5";
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22626606A32E;
	Sat,  7 Nov 2026 15:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22626606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=CCev84UW;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=3GwP0/b5
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1794064381; bh=HZ1sMAQnsO4h3gBSc4cW8ZY
	QQAs8UR5LsG1+6TNnwlA=; b=CCev84UWEfGOmDguj3iDCzCmS4qau+ML2pxDkNbLrXO5yo0NgY
	QP3jk26CeSpHhqCsxefay0n8TiEGbKcNQxLxFM49nlOwSObYMdP/C+Lj4kMz+M9sEYnFX+d9Xyr
	QXnGz9o9M1aTYYOIK2lQ8EcQgtXH+YagrPZswxU8nPhBt7/H8tIMvthBdRNslNVa/a7mlhnGmTh
	FJZkYXgsJYrs4oZh6gkEa5m0uvLPFCxOtPnvFI6BVeRdzVXBh6BCqwK6T5bKsDx3spr8Qp/EnqT
	5GrCyYeuCJ2zeJjOXl4MruAkP8HXAmMyh3+QVsIlaua35Ks2UtIi0xa61SisasG/Naw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1794064381; bh=HZ1sMAQnsO4h3gBSc4cW8ZY
	QQAs8UR5LsG1+6TNnwlA=; b=3GwP0/b5tEc2fd0NA9oftAwP+pXheq/gGlusunvcJRmZL7gipz
	t8EgzqA03mqw+HA3QX5P4g9rb3H22w/tjLDA==;
Date: Sat, 07 Nov 2026 15:13:01 +0000
From: Bradley Morgan <brads@mainlining.org>
To: zakbrightonknight@gmail.com
CC: a.fatoum@pengutronix.de, akpm@linux-foundation.org, daniel.lezcano@kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com,
 mazziesaccount@gmail.com, rafael@kernel.org, rui.zhang@intel.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_reboot=3A_fail_run=5Fcmd=28=29_before_?=
 =?US-ASCII?Q?init_so_hw_protection_can_force_the_action?=
In-Reply-To: <20261107143129.875202-1-zakbrightonknight@gmail.com>
Message-ID: <C7A70189-8D7F-4E6D-BB97-FD9284C2E437@mainlining.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 7 November 2026 14:31:29 GMT, Zak Brighton Knight
<zakbrightonknight@gmail.com> wrote:
>__hw_protection_trigger() asks userspace to power off through
>orderly_poweroff(). It only forces the power-off when running
>poweroff_cmd fails. run_cmd() waits for the exec only (UMH_WAIT_EXEC)
>so a successful exec counts as a started shutdown.
>
>Before init has started that exec can succeed and do nothing. Usermode
>helpers are enabled at rootfs_initcall and wait for the initramfs to
>be unpacked. So a built-in driver that triggers during device
>initcalls runs the initramfs copy of /sbin/poweroff. On a
>dracut/systemd initramfs that is systemctl. It finds /proc not mounted
>and decides it is in a chroot. It logs "Running in chroot, ignoring
>request." and exits 0. Nobody sees the message because a usermode
>helper starts with no stdout or stderr. The default
>CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0 arms no backup timer. The
>one-shot latch in __hw_protection_trigger() then makes the kernel
>ignore every later request. The machine runs without its critical
>temperature protection until the next boot.
>
>I hit this on a ThinkPad T520 running Fedora's 7.2.15 kernel, booted
>while still hot from a long memtest run. The ACPI zone read 101 C
>against a 100 C _CRT 0.29 s into boot. The kernel logged "HARDWARE
>PROTECTION shutdown (Temperature too high)" and the machine kept
>running for 90 minutes.
>
>It reproduces in QEMU with Fedora's 7.2.13 kernel and with current
>tip. The test uses an SSDT thermal zone whose _TMP is above its _CRT
>and an initramfs with Fedora's systemctl as /sbin/poweroff.
>hw_protection=reboot fails the same way. Setting
>sysctl.kernel.poweroff_cmd on the command line does not help either
>because do_sysctl_args() runs after the initcalls.
>
>Make run_cmd() fail with -EBUSY until system_state reaches
>SYSTEM_RUNNING. Both callers then take the fallback they already have.
>__orderly_poweroff(true) syncs and powers off. __orderly_reboot()
>syncs and restarts.
>
>Firmware that reports a bogus critical temperature only during early
>boot used to get away with it. Such a machine will now power off at
>boot, as it already does when the same reading comes after init has
>started.
>
>A short window remains between SYSTEM_RUNNING and init being ready to
>handle the request. A non-zero CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS
>still covers that.
>
>An AI coding assistant (Claude by Anthropic) helped find the cause,
>build the reproducer and draft this patch.
>
>Fixes: 10a0a8d4e3f6 ("Add common orderly_poweroff()")
>Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
>---
>I haven't tested this on the T520 itself, only in QEMU (x86_64
>defconfig with ACPI_THERMAL=y). Without the patch the guest keeps
>running after the trip. With it the guest powers off within a
>millisecond and logs "Failed to start orderly shutdown: forcing the
>issue". With hw_protection=reboot it restarts instead. A trip after
>init still runs /sbin/poweroff as before.
>
>The reproducer is an SSDT thermal zone whose _TMP is above its _CRT,
>passed to QEMU with -acpitable, and an initramfs with Fedora's
>systemctl as /sbin/poweroff. I can send it if that helps.
>
>Commit ef1d87e06ab4 ("thermal: core: Add a back up thermal shutdown
>mechanism") noted in 2017 that /sbin/poweroff can return success during
>boot without doing anything. It added
>CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS, which defaults to 0. This
>patch covers the early boot case whatever that option is set to.
>
> kernel/reboot.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/kernel/reboot.c b/kernel/reboot.c
>index 9a84401adde5..14c2bbbc5a3e 100644
>--- a/kernel/reboot.c
>+++ b/kernel/reboot.c
>@@ -858,6 +858,18 @@ static int run_cmd(const char *cmd)
> 		NULL
> 	};
> 	int ret;
>+
>+	/*
>+	 * Until init has started, no userspace can carry out an orderly
>+	 * poweroff or reboot. Running the command can still succeed: an
>+	 * initramfs usually has /sbin/poweroff, and it does nothing when
>+	 * there is no init to talk to. As we only wait for the exec, that
>+	 * would look like success and the caller would never force the
>+	 * action. Fail instead.
>+	 */

Way way too long! I'm sure we can simplify this.

>+	if (system_state < SYSTEM_RUNNING)
>+		return -EBUSY;

This is as easy as it can get!

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>+
> 	argv = argv_split(GFP_KERNEL, cmd, NULL);
> 	if (argv) {
> 		ret = call_usermodehelper(argv[0], argv, envp, UMH_WAIT_EXEC);
>
>base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
>

--- Thanks!
