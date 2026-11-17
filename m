Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933544;
	b=GyhbfxjbxIfmjTs0He6wHsyIMPsCfFvkXSt2iWPUCh1N4c87MwLfEjH788DCJkypaNbd
	 Zxczz+S2f0o0ChWo/tvj78QItaYw2wtjnlyPkfO2pDTxXI1i8XWYplm1KqNgSoTx2+U37
	 ogLDeHkQkcm6tRoPT+tk4T1iFu4SR4U1mwfRKb2PY84MI8QXSThYhjbYbU+AzJBkU1B+s
	 5iMg4PPuh6jiG9i+XVIzTX/vivPpsflgFa2yYsjQSAYgSbtznagtHdC+C39AGPytzmJGn
	 YQPnhKl8cW52PO/WtFj6q85k8EE1x8zbWq5UU3KLLPjcW6fMXMI6/AVIcMiILyZ/2bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933544;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Z/XV0mK39zFS7JOXvDWInmC0g759RMa7DDlWP4M3P5A=;
	b=UMXoVjTlfO8SRDMiefmyAXu9ydwUSOoEBPUtFpLHfmAm2MPMIeHwF8FN2S907/5le9IT
	 AIIWqkxBjv6aHvX7+FsR2SHfeElT5AunnHGrmxs0IrwB8ul34o0NDzYFurBTjKEpVAx4r
	 WH8MWjROuZA75lJkGLi6SFNGlpGccKWMWirilTk9bFSYqGXynrMiSjQH9ikWJeOFPZ3Ji
	 VAJwxFJjrZVxWlYWqmQ62lxfaIIojTsKPqykCeqiWZL9NPgIIUfdD4Y9KH+0XBvAhlPlN
	 H8ZkpxhyQV+oJ4VqPCXBVXopmsqJ4R3FEuaJS3UyBc8+Ve6NYQmroIktI1mzZYO8vwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F493606A33B
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 16:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F493606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ece6c1d1cbso1520519e0c.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 08:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933543; x=1795538343;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z/XV0mK39zFS7JOXvDWInmC0g759RMa7DDlWP4M3P5A=;
        b=eO4S7SfeYLzuhvAZFKmM9YC87jS8N6qFrDOPgbzRHCbHUW0Te76fdkRTQbj8D53ewG
         a2FJPtPoXLI8nHd2cFdWpsW6s2t0kuv77QYc1+UuvqiNGfMUsLn3+9K0Gtuf3ntFoQJD
         wME2fqjSmJEI9pdePEEfZMDRQS3MIysQ2Y4Bl7vzJ9i/pNCbhohIEL3sZuPu8k0M8oLY
         JX1rRVD66JcRkuGxd5aPSxpy+NEiRT0Q1g1pylDBjH2dJwo+GEIfGWu2u9hGbKuyKBM5
         2SSOQwtmXQG4rBFo+TPVo7aBL9MYjsiKJfYyOqtxciszQCqm6yz5UZq/y/dxUQ6kZqvr
         tEzg==
X-Forwarded-Encrypted: i=1; AL+hErH4n10iqhdW5gBC2kRtc4HA8RMNAVyZ6o/zDDnXbd5VNCga9re40Gr2BC0gyqsnIBDs7lModr7hkg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9vgpZksAn2N5GdnoJDZekefZ0OjycFGBaLVsNiMgxfAwCcFSvz
	sMZ9ShGlnMNID3DAWtbk7L2BkckdpKc0TSNMKmYQ5OIRGdQ9rBIMs1YKL52IyxZz
X-Gm-Gg: AYBFou0TYlee3oUt0rEDLZ+80GVPElDI/4XgBB6dBzeueJH4g4Z2h6Tnqhu0u/C0YfX
	14JZZR9GHsOg0Oj8oGjjiZqVhTJkYHFdMOc9n1sQ+/BbpmCCqv4j4wo3LGWFABIvcRYjDOp9TaY
	1LF0u507aWrezmpR/l1UbK4TbXmMJP59h9X6dwX+CuPHkXd6xCxIcWAe2f7etTKZ/WXTLL0xX2N
	179DyORPUDXVPUpXj2YqKtB0SOK4ZkNkJy02JnjjGssU2UAAKCMtwOw9rH91393OGJ4wloJ/DPI
	7icd/6VdTmXzidDAS6K7ihtRogO3wh46pL2gWHikjKaWrt7TXopBKIEGU5+e29z+HEvaySn6axr
	zJsmFIr+0odeM3R4yDfEQj9dpYmaqOLPoumlj6o3Fci+nd4fVlDWzXIsBJ5NFAEF48XEYFu+7cz
	LxrfmylulIVi/oK38onSXri6IZXlPVVoQruXKCzBsRcDLpoKnMkDq+DSfgY/QzqxjxeqBqwU0Up
	6NLbKG7KKs5tTYIKBqGDsrOFxVaGz5bhhVwHE++UvNDHZ2X4mB61FQNN1gtatVt1nXPqI7DiFnR
	27grEDVDbuXK8SI/NLkc6rg0+NW/L52M5r2GEcaHTfvg1/iY9SvQ++Xi1HzewG7auOk=
X-Received: by 2002:a05:6122:1da1:b0:5df:682a:5d14 with SMTP id 71dfb90a1353d-5ee6468f6acmr81920e0c.4.1794933543133;
        Tue, 17 Nov 2026 08:39:03 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34eb123csm8421254e0c.16.2026.11.17.08.39.00
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 08:39:01 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d2dbe5c4b0so1376428137.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 08:39:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFHVJ5UzeQ1h3JisGWZb1dCct1c6XMuohLIoTZ9krAh30O7aMGSn26N7hK0AxlvW52clgUslBRsRg==@vger.kernel.org
X-Received: by 2002:a05:6102:50a4:b0:7cc:1ace:fd06 with SMTP id
 ada2fe7eead31-7d64d7a9d5amr4459124137.20.1794933540494; Tue, 17 Nov 2026
 08:39:00 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
 <20261024223501.1420953-2-daniel.lezcano@oss.qualcomm.com>
 <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com> <0de1444a-a0ba-4e16-a480-74a39c865ab6@oss.qualcomm.com>
In-Reply-To: <0de1444a-a0ba-4e16-a480-74a39c865ab6@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Nov 2026 17:38:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWfH+_4ijxko=LS_P6b1Y76WWDc8m4xL6qW1H+qKRQ98A@mail.gmail.com>
X-Gm-Features: Aa3M54oLa7UUmy4CFc0JRC-Lz0IWxEH7iP1kR67WyO7NUNvhNNuybpNvCvDbePk
Message-ID: <CAMuHMdWfH+_4ijxko=LS_P6b1Y76WWDc8m4xL6qW1H+qKRQ98A@mail.gmail.com>
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

On Tue, 17 Nov 2026 at 17:03, Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
> On 11/17/26 12:48, Geert Uytterhoeven wrote:
> > On Sun, 25 Oct 2026 at 00:56, Daniel Lezcano
> > <daniel.lezcano@oss.qualcomm.com> wrote:
> >> Platform profile providers already use device-based callbacks and do not
> >> need ACPI types. The core is nevertheless confined to the ACPI build and
> >> refuses to initialize when ACPI is disabled.
> >>
> >> Move the implementation to drivers/platform/profile and introduce the
> >> firmware-independent PLATFORM_PROFILE symbol. Update all provider
> >> selectors. Keep provider-specific ACPI dependencies and the
> >> platform_profile module name.
> >>
> >> Isolate access to the legacy ACPI kobject in an optional compatibility
> >> object linked into the same module. Retain the legacy ABI on active ACPI
> >> systems, and initialize the class even when ACPI is absent or disabled.
> >>
> >> Use subsys_initcall_sync so the class is ready before built-in thermal
> >> and CPUFreq providers, but after ACPI has initialized its compatibility
> >> kobject.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> >
> > Thanks for your patch, which is now commit 699041135f75b13a
> > ("platform profile: Extract the core from ACPI") in pm/linux-next/
> >
> >> --- a/drivers/platform/Kconfig
> >> +++ b/drivers/platform/Kconfig
> >> @@ -1,4 +1,20 @@
> >>   # SPDX-License-Identifier: GPL-2.0-only
> >> +config PLATFORM_PROFILE
> >> +       tristate "Platform profile support"
> >
> > I guess this can be invisible (perhaps "... if COMPILE_TEST"?), as
> > you have updated all provider selectors?
> >
> > If not, I guess this needs a "depend on X86 || COMPILE_TEST", so people
> > configuring kernels for different architectures do not see this option?
>
> The goal of this series is to make the platform profile firmware
> agnostic so it is available for all architectures

Sure... Are there any users of it on these architectures?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
