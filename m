Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207706;
	b=iL3Y/X6M3GhQ43nSTEqziy91KYEjZBXH2p7/CPuBHtMalnUnwvRe4iAZaBFpzwc66zdL
	 BaOJPI0EJOSTs5CBvSy4rwGiLV38PEdFDrZFTc8uBqYRGj96NdwshsoE4XgHta1sN3/R/
	 MevcNc3YMQATO1ZogUqcjhELT923HC+rhgK2hRRrLISfJGBDlq2L/YxMMeYNU7VkQFSvH
	 SsKc6ToKRTs/pOu0NJ4N7B7Vqn69o8S409+Krjaum+yaZgM4cv08mAKMQnQXYJD+wFX34
	 ZyupWpYJOmdleUYa6wac3dtOkGHON6q7A6Hm7RPzAjnWpVk7OaISY4AiIlVaBAZKJjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207706;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XySernhzzBiFDkDoSBdIuYjnJ3uguMdt2ZEblDh5bsc=;
	b=Ze1zvNZTcs6MJhZepK/U2Dw3pRTOLXrMGHTIBeFEPvmv+1ewbb06tExKn+IG7vjQokGa
	 EWEgr9ik1MRj+//xpGV3kQsICE9mep2CCMNID4tb9wztETO2Q44V0ZaV7f8QW7XJiqVCf
	 Ir2i2Zz4JPbQ/G7rq1yZab0O5yhGQvze4p24vBIhhR8+Hy78nfNgKgyJ4mApeo7avetWz
	 VCldqVkGYhOyZHMEfQuxg7dvpQY9jiwpTP/3F54QEftsMf8iRwy7ftDLAULypCFNcqlP2
	 A9Z/IiPx28lQiOXIK2UaIqQymMbHgEjqQuhjVZkVN+BdYTaPq8gkVo69FGXMLMrtBYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=bKI+0jA1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D6606A31C;
	Mon,  9 Nov 2026 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=bKI+0jA1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF8A1F0089F;
	Mon,  9 Nov 2026 07:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794207705;
	bh=XySernhzzBiFDkDoSBdIuYjnJ3uguMdt2ZEblDh5bsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bKI+0jA1oqJF31WvP1VRLM9Cxt933Ti41/EJmoXULis9uvJB2zSqIkubV9SZLdujP
	 pVAlQ+aXj7+XhNIvAlOXoeWSHgjJ6RgJQ9MMROYQSIVJzHY4yVSWLXeav6X9zbbSm+
	 9mlBJguwvgG7O0MdLD+dmHmEtfKc0ZJahXVfgoaQ=
Date: Sun, 8 Nov 2026 23:01:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zak Brighton Knight <zakbrightonknight@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH] reboot: fail run_cmd() before init so hw protection can
 force the action
Message-Id: <20261108230144.67ca14617e06edd938580a1d@linux-foundation.org>
In-Reply-To: <20261107143129.875202-1-zakbrightonknight@gmail.com>
References: <20261107143129.875202-1-zakbrightonknight@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Nov 2026 14:31:29 +0000 Zak Brighton Knight <zakbrightonknight@gmail.com> wrote:

> __hw_protection_trigger() asks userspace to power off through
> orderly_poweroff(). It only forces the power-off when running
> poweroff_cmd fails. run_cmd() waits for the exec only (UMH_WAIT_EXEC)
> so a successful exec counts as a started shutdown.
> 
> Before init has started that exec can succeed and do nothing. Usermode
> helpers are enabled at rootfs_initcall and wait for the initramfs to
> be unpacked. So a built-in driver that triggers during device
> initcalls runs the initramfs copy of /sbin/poweroff. On a
> dracut/systemd initramfs that is systemctl. It finds /proc not mounted
> and decides it is in a chroot. It logs "Running in chroot, ignoring
> request." and exits 0. Nobody sees the message because a usermode
> helper starts with no stdout or stderr. The default
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0 arms no backup timer. The
> one-shot latch in __hw_protection_trigger() then makes the kernel
> ignore every later request. The machine runs without its critical
> temperature protection until the next boot.
> 
> I hit this on a ThinkPad T520 running Fedora's 7.2.15 kernel, booted
> while still hot from a long memtest run. The ACPI zone read 101 C
> against a 100 C _CRT 0.29 s into boot. The kernel logged "HARDWARE
> PROTECTION shutdown (Temperature too high)" and the machine kept
> running for 90 minutes.
> 
> It reproduces in QEMU with Fedora's 7.2.13 kernel and with current
> tip. The test uses an SSDT thermal zone whose _TMP is above its _CRT
> and an initramfs with Fedora's systemctl as /sbin/poweroff.
> hw_protection=reboot fails the same way. Setting
> sysctl.kernel.poweroff_cmd on the command line does not help either
> because do_sysctl_args() runs after the initcalls.
> 
> Make run_cmd() fail with -EBUSY until system_state reaches
> SYSTEM_RUNNING. Both callers then take the fallback they already have.
> __orderly_poweroff(true) syncs and powers off. __orderly_reboot()
> syncs and restarts.
> 
> Firmware that reports a bogus critical temperature only during early
> boot used to get away with it. Such a machine will now power off at
> boot, as it already does when the same reading comes after init has
> started.
> 
> A short window remains between SYSTEM_RUNNING and init being ready to
> handle the request. A non-zero CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS
> still covers that.

Thanks.  Boy.  Tricky.  I shudder to think how much time this took!

> An AI coding assistant (Claude by Anthropic) helped find the cause,
> build the reproducer and draft this patch.

I need AI help too.

Sashiko liked it, but my AI review thing did not:

: The early thermal shutdown failure looks real, but run_cmd() is
: also used by __orderly_poweroff(false). An early Highbank power-key
: or Freescale hypervisor shutdown request would now get -EBUSY and
: be dropped, with neither a retry nor a forced fallback. An
: initramfs helper capable of powering off directly could previously
: handle that request. Please preserve the non-forced case.
: 
: SYSTEM_RUNNING is also set before do_sysctl_args() and before init
: is executed. During that interval, /sbin/poweroff can still exec
: successfully without causing a shutdown. The one-shot hardware
: protection request is then consumed, and the default backup timer
: is zero. This patch narrows that failure window but does not close
: it; please address the remaining path or describe that limit
: precisely.

