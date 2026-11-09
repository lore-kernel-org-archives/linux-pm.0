Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208828;
	b=ZjlMIWA6EyxP/HM815ZsGNZO+/KADaQkzs37th8LI9Pio9kHvgJCMbR6P6GpQtG56/GK
	 OmiuiWAOWwaalVcftz1VyD7gumIPhE+AA4iaPjMQbungNvE9TExxLobXwRBhdw7qQnSS1
	 +XDdai98P1uZn60Ui3UqpHFFtWBLvue1PNiFDqKM7GKaT9JH1U5uyxds7Z9EwCQEvp0vb
	 2+dgbXVWkuKUwE2FGn5b/q+FeA+dvrHwjHqvdYnxBjCUIl4DxucMoosxmzRmg7O0rHM+R
	 8a3MXg/7TUXfbE5mA71M5KpWxdxYL4ncu7jOxETYS3co1kP2rrGFpwbnALsx53FAnbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=S4dtTenJXleltLZYycO2fIiw6+tZG5tzNUtyBvNjc9Q=;
	b=NKAo6lZg5OiA/DhkUTAEqeIObCIGz9Tkft/5VUe9L5Gz9POjFvXQZmGINo3wwKhGB/oL
	 6Lw/feqqf44NraSYbqefrVQmtT4UzeGLPp021I5nSiweeyB7TuJj/1TxT9sU/epw5paie
	 wKN2c7zO4ePFfc0DYKgfvsUeNfGILDm0OdHAhERmoxZp2yZvMl3y0n0nsBFWvWDrdIoMA
	 XfnU5prrit6Alsf/yCmo5giR17wM5wisIbJnRgt8CtdYB4QRA+yaDodajrX200/wRzHQZ
	 dWGhhglaoJeDG67NxV3lZN03KOdhikFpbVmnOkq80RX18UCetbVbn2UeVGV6b1wwRkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grNwYsgE;
	arc=none smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26617606A322
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 07:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26617606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grNwYsgE
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c14f6f58aeso346500e87.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 23:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208826; x=1794813626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S4dtTenJXleltLZYycO2fIiw6+tZG5tzNUtyBvNjc9Q=;
        b=grNwYsgEl9HzLWn1gn44MnjYOjcM2AMsGDKQbrGRoYdIKerLUtBBT2mRVlDK6RNyHN
         2H6LkTRz5ws1JHGoJmPnLs+DR8YxK+qagXLZhsRv3CckKrTqBL7gIGZ9d8THkY8ankQQ
         RAiskOXsV7iV+Ogw9BFclS5f/EO7KWtS1Vu4sorrnRAtrPWDtJfiMeAlX6LUR9X7cfx9
         JLICJKmqrYJRmpFEAnhBMYVbdYbbVx/ImzTmQzSUyIyDdkVs75Hpxe0O1a+kOPcP+ym/
         D78wCEJbI/oS9D5nPVlfRiHgPlqez9PBsGa6UydXisLEbjmmlpm9vxqvwYnmA6fHuNZn
         xtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208826; x=1794813626;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4dtTenJXleltLZYycO2fIiw6+tZG5tzNUtyBvNjc9Q=;
        b=BwcB4TTt3Iy6+qsD+XSAUhzl6YfJGxKcXySW+k+A3qS4MYlhSaFjdf921d9wsegEE9
         0GhBULj4/6kdAQC2vikUFPPO2h1tqJqwL8My4eQTQ5A7+sYMIfYCSoGaDy9ztHVaL2Pr
         vt3CIG3ym/y0rno8PYWE6d0ScsgWZQxXNGvTJT+fTUmmgQb1Y24R9X/2u4EtDKm8FMFu
         OcLOC6kzGrtduXGmxM4vNpV4lEn+nzpxVimUVty0dNQiyprFEKDMr8/JdUHfI3DqKOoh
         iMi11otlbNvvAvzJrRA4y6YmPXsTIEGuLIO1q0MyYN+Wdgls7HS7e5jImyh8YXH7B78q
         LSdA==
X-Forwarded-Encrypted: i=1; AL+hErF8BS1lf87sauweImeQL7F6C0N4aQrBf8HT5GfOQoQ4I3nZYJeiLMHl9ec18HMx5sAzJnHvwZZNyg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8tJNJqUhXCaBRrGjwr0G1NjKu8D0u4Ag8aNOlotG4MFv7tpZOX
	iPkfDXChKrjK29H46VWl8uUIUEK/gFxqCoFuMdIKBfNe9Jg8F/5y/Xti
X-Gm-Gg: AYBFou1uSkoJiuqtI6IN5XsmpIFGiipcf9pXuky5dWQqWDWG+Tm1/FiQwWWj/bQEaZv
	IHFG6CydiM4eo00Qsa8Fxi+OFyyL0ZWHbMKkzI8fC1VOSeqZoAZjpoJ55exACnVxwq09lgJTgKt
	Xu+pLj+4w3o/a32LBDQIfruBEiCb+SRdCGoVZA2yd94ZCRj3SgzWDUuLXQ9LW1LqQaufCLrcIH9
	Ln0JA6EQBOxR1ZgDKn93Xo60C4cuY3Dyxfu1bJ+6L7PEl7XdvCrgxqpvkLHA4p8Zwh52Zn5u48H
	UiAuyUvxYZDOWnJ/6CpEZ72XCmoxgrpsYhRJHkfGDEq0yYSTIp5NazBDXK6zfcE/611FUV0b+7Q
	vuVjVTqtSj5O+U4Dqii9brhPVGG7/t+4xIWm+q4ZohQRVV1jQWjMRnbX85ZvzdLF4NVVpv1xw3l
	H9OO7Xj5nGom/tm4s3fQ7zU0MSPh4nMWoZAhQHAEURGHr6a6IVz66PV7m8VRAUMrap7n8xffNXU
	Ycmjw1BkYDW3yOxJL/XWdJbTXad8TMA1/+oazFyZ7i7R7IG6Gc+lsU7Y7jpCBGZCTFHjXZWgRao
	uCF/hxTexTHwuFwatPCVJN3oKFMJIlVyIi8K
X-Received: by 2002:a05:6512:838d:b0:5c1:4c83:ce65 with SMTP id 2adb3069b0e04-5c14c83ced1mr504370e87.19.1794208826052;
        Sun, 08 Nov 2026 23:20:26 -0800 (PST)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c14b8197c3sm704213e87.57.2026.11.08.23.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 23:20:24 -0800 (PST)
Message-ID: <b7a634b8-b837-4e3a-968a-8389db89b642@gmail.com>
Date: Mon, 9 Nov 2026 09:20:23 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reboot: fail run_cmd() before init so hw protection can
 force the action
To: Zak Brighton Knight <zakbrightonknight@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 Ahmad Fatoum <a.fatoum@pengutronix.de>
References: <20261107143129.875202-1-zakbrightonknight@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20261107143129.875202-1-zakbrightonknight@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/11/2026 16:31, Zak Brighton Knight wrote:
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
> 
> An AI coding assistant (Claude by Anthropic) helped find the cause,
> build the reproducer and draft this patch.
> 
> Fixes: 10a0a8d4e3f6 ("Add common orderly_poweroff()")
> Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
