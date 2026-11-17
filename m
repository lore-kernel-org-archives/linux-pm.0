Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794916106;
	b=jaw0jTP85roVrR+4wpAaaxnERmDVJ9PQVQlNTU64GL46TlCQ4WMszPinY9vyNSbp1GWM
	 Ds2MWut99C/uV6+3xlubu4Y1aBQFp0MhsWxPsxkLzFC9FiRUGKzpNcZtIBWCmpH5Ggwh2
	 DRkz+TacNklPIT7Itphsg+MsbXMC+9PQezYKm0oErVeQqyLHz3fJITfkp3awVmJaLphER
	 u7TvcGxQQiJce2NjkhEfD1arH6BrCdrTQBA+1StmYnG0ym+5zXSZ0QoMHuJFWzFm8mKIP
	 98qHo0yB/rrVkW1Sqjly35eh6sEuOvimzL3Tg3lYcOsQtgw9fIlH3B4M3pSaBLZzLyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916106;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=fCqZ0Zd4HVCI/jRgXBSCy8S8OFyXtFOLF3BsI1zh8Sg=;
	b=3OE/7V9IlC9K8F183BaYQJVTFK8oV0NsEA2F81lO4fpZOigF4CSTfn8XX5LQlYB17ofS
	 mNUXN1BQajB4QligEtXs1UaFfDuFqkV8sgkAiU1TkZvQ5S7rSYC7jSd6Fxo47FZKn0ML7
	 Bn7ftZ38HWhZnS65Jwn+/8nSOr0LGg5ckZnz9BDG8i777sSdeNLYKIf3/ZPNPMInsSm1V
	 TwQGvyvJpYH867FO9o+PudnsgEEDk0Y/QtA1dpDSmw36R6xftoMgriN/hR+ghPovxuluw
	 BiRXLpLuSQzLPujAGej6Ahl40d2Up2AW8VLxweLy97/aiEjXOEw/hOWXYpYzDqiMOwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785D606A329
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 11:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8785D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ee36376a0dso3088779e0c.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 03:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794916105; x=1795520905;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fCqZ0Zd4HVCI/jRgXBSCy8S8OFyXtFOLF3BsI1zh8Sg=;
        b=fkL4raILAfmeERxzvTa95/oi88FZuKxfnKmhg1fu36RRlEJnr52ic5orPXgusGy3gj
         eTbei++VfhbgCGMQizGvCpLQYnyXVk6fP0QB7y8Ov6kYg28rFT7Qziva9+qC4CsGzBWg
         ELm1dU2n7Nr+CfjUERTG+lyMh6e9SFlX/XUncGDWRQtC6jj00qypCVxpW8Q4oTDgtAv7
         TnPYcrrdamFCKzWg0grYls1BQw2eNA3M1xeBfujqPA2WWWV3/7dMrOEogmsvJDUTQRMF
         H0s7k1gck9S99A4r0VNJR4p6zq1oLDdmhony30chwrJK2vDLDY0yX5Dxlxfmc6t/OO3t
         ZlsQ==
X-Forwarded-Encrypted: i=1; AL+hErGArhDk1HhaiIAcV8LH8pZU4euxdJmkv4mHX+JWr+NgxAEllVwe5NlO7fvJSdB70i6bd3iaIhSB6g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9m1dopGKtdmgGf8EJjGo6xgD7MNRZC20UgV/mNliKAs9elU1hn
	aZmElwy/g1RNDNzkBnBLMfqrPFBNvZ5/7eMzbrxbjgzOS2G9sGyfdt5HLua8+hdm
X-Gm-Gg: AYBFou2r5cVPfEImh9ONJrAZDU2AtDTTjV9WiIeQ7LcaR4y416Zjl1vR9LyOemJjpbc
	w2AaEWi6HkoSSI1wVUzoVyfkfkUPwCDWdNqfQkT797bL82vnvugrgzssBTOChveIGdQf4rdHXSp
	oBVWYxnpUP+cYPJESYhGn52JA+fY8w3iUH7njLHY1tCs7k57K8Ph/RqV5BM3Epzu3w7f/7M3uJg
	kpkDVA8fdzsOJuzNqXO/TyrFXejFNel9z4gDh9jAZA/IteQnr052wajoCbMaINhBxAgk4FVi6C3
	ovQQ6ew7Jjh95pGyAkW8uqTvhwUigs01xABVCpQ1UTXx/Bn2X/tbl/1EtKdDlb+UAMkZAFyhjd6
	+NDMLX/BNOeHiXwXvoCbBsN0UBmfTDbryKp0DdrVI8r8X9l7PJ2gXT5H3b/YW8dt3w07XF7Rimp
	mdBFVOtLQDsVO6kCGDwzo3O67xt7C5f2zpKFW1Qv0fbhrnJJ0V1ueQg+hLjo9fHDL52zJ3CLfo5
	0nqhV47LiLoxVt7NVk+4NgmKpSRPPtxgqMjRNSHbcRSy+zMZVUMCzOSVlN+DUAW/eWjZqpMDIbm
	puHeIaFqc5Azgt8bAHYlPs5l08l8g7xl3z7FL7H8Ah+W7gqviX87wnxM1RlDMqpGj34=
X-Received: by 2002:a05:6122:512:b0:5cd:590:c22e with SMTP id 71dfb90a1353d-5ee34b160edmr4792832e0c.21.1794916105328;
        Tue, 17 Nov 2026 03:48:25 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e5b6b8sm8486585e0c.8.2026.11.17.03.48.24
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 03:48:24 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-996eeadfbeaso3317763241.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 03:48:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFGSuM9X+DuAQEEyenETmVMKUkpHD/3xohMMRyFsGtGCUKf3ENDk5aGCEb+eqEv7QLszUaGbVH5kQ==@vger.kernel.org
X-Received: by 2002:a05:6102:578c:b0:7d2:c786:5a95 with SMTP id
 ada2fe7eead31-7d64d69dc95mr4808481137.13.1794916104363; Tue, 17 Nov 2026
 03:48:24 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com> <20261024223501.1420953-2-daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20261024223501.1420953-2-daniel.lezcano@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Nov 2026 12:48:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com>
X-Gm-Features: Aa3M54o4xtj3bYccvEv51xwUP0A3vPBfjxtiJtpZqQUGyQco56wW9LsC221L5Po
Message-ID: <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] platform profile: Extract the core from ACPI
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>, 
	Jai Luthra <jai.luthra@ideasonboard.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jack Wu <jackbb_wu@compal.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Sun, 25 Oct 2026 at 00:56, Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
> Platform profile providers already use device-based callbacks and do not
> need ACPI types. The core is nevertheless confined to the ACPI build and
> refuses to initialize when ACPI is disabled.
>
> Move the implementation to drivers/platform/profile and introduce the
> firmware-independent PLATFORM_PROFILE symbol. Update all provider
> selectors. Keep provider-specific ACPI dependencies and the
> platform_profile module name.
>
> Isolate access to the legacy ACPI kobject in an optional compatibility
> object linked into the same module. Retain the legacy ABI on active ACPI
> systems, and initialize the class even when ACPI is absent or disabled.
>
> Use subsys_initcall_sync so the class is ready before built-in thermal
> and CPUFreq providers, but after ACPI has initialized its compatibility
> kobject.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Thanks for your patch, which is now commit 699041135f75b13a
("platform profile: Extract the core from ACPI") in pm/linux-next/

> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -1,4 +1,20 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config PLATFORM_PROFILE
> +       tristate "Platform profile support"

I guess this can be invisible (perhaps "... if COMPILE_TEST"?), as
you have updated all provider selectors?

If not, I guess this needs a "depend on X86 || COMPILE_TEST", so people
configuring kernels for different architectures do not see this option?

> +       help
> +         Provide a common sysfs interface for selecting platform power,
> +         performance and cooling profiles. Platform-specific provider drivers
> +         map their operating modes onto standard profile names, independently
> +         of the firmware interface they use.
> +
> +         The core exposes per-provider controls under /sys/class/platform-profile/.
> +         A provider driver must register before profile attributes become
> +         available. ACPI is not required; on ACPI systems the legacy system-wide
> +         interface under /sys/firmware/acpi/ is also provided.
> +
> +         To compile this as a module, choose M here: the module will be called
> +         platform_profile.
> +
>  source "drivers/platform/mips/Kconfig"
>
>  source "drivers/platform/loongarch/Kconfig"

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
