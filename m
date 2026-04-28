Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6127CCE0
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337575; cv=none; b=bTZgHFzkN8/MzAv1sQK+S0n20OV2khx1fgSiKwEduJnMFL0LNpuHmuRJU6fRDu1b/XF6C/rEHUj2V8PVDY0PhKAdrgH449dpLg5XWx8wLqjhk/uhwxMVg8+5qxOyuQ7IpE0+ERKPpcNLrcWD15k26w6u9FKtjIE7TQXfPuVP4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337575; c=relaxed/simple;
	bh=8Uem3oqRD7Kri2DSyAgANGL+qzMirF3VGc9HlXIQYOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LALFqhnwe/zcTFGynD2V5yU//e87bOrKqe/Qw5culGWvxGyuHEg1qHA1M2XUvBXifhG8pyN2R7GoFWZLj52m4tJxECPQa0gzuiNgylHe/Ri3a64oneuXpS3W5HFAMO/NiY5mOtZfUit/qdlByAMkUoW1vgWxVjkItrTogpvD3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=UmLvCjgn; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="UmLvCjgn"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c79662bbd2eso7419262a12.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777337573; x=1777942373; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3FnaIBp0espZORVL/rfnjBPdcVtbw4VckmuHvIfsjM=;
        b=UmLvCjgncUFnkOkej4+wGBHe0fTbbx54IoP/u0gXvql2aNFmqqno+yqwl+Ccx54FTN
         gkS26kFBc2qdrgwLMIhHZo9xqUwAylAU2efyVow9NXrRClAnEBtKOtj/Mp0qDcDB/4pb
         j2zd9BfXxrR086oPDlyxqLHwu+R15O3ovW4uYngGN7f5NWjRPVzDTRD+39B9JVFrd16p
         DobTC1E1tD9X+FTQaV5U2PD9+FJcFOxI/fIqxRCnGTh9g/geoS2QDELG7DPvgPquAd8u
         YrsmS/8TVtKpJgNA9HeCptCErNwn5dpt/rcBqDGk/iUM1o8rRq4SZxubM1IjxyIxGeAj
         +hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777337573; x=1777942373;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3FnaIBp0espZORVL/rfnjBPdcVtbw4VckmuHvIfsjM=;
        b=H7JQXST5AYSGP/jr52zW64bTuQ7tNahA3eiBrVem4pt8d+Do6RWQW4f1ee8oAfQs16
         7sJ/9MekQBKG+1tzU5+eHimIoOw302wVdLnvR0E1UA5FiIaqOVEWGHOy/VzhNSD4sfVv
         yWeYlM9EBNtostUozJpbVZioYtSS2cbfzxU5FkmPfxSaDpBkX5N4vJFk5XAgF62UcPjq
         MSZMld4h1X2GSi5i5s5LTYiGdI2bo4iB0BqlY5YHbTsw2vq34/rv4yhwSOG59esqBbfs
         AjO9u6z+/FbCc+Z1XnbTmltpq7CyQaEIu7FV5MDSFqcR3EQJCn/MNU1Xkbm/iNv+srs/
         xOHA==
X-Forwarded-Encrypted: i=1; AFNElJ/kN5e1aQIpfDu4mDA7JKBiDYf5LCX1Na/wD/dYArjfUyZD/7YVOO4L8e1JFXaIIssWEI3PdFoiYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMtRYAFcKPGvhZHp4MDRaGQ+smuR6Q09KgVAENPcc4ZznEcv85
	/+0SEKNBhzQVXxROtKIaXMNk/y64e/MADFZA0tgBMznntlX8hpjOGPRPe/PMBg6vx1k=
X-Gm-Gg: AeBDiet1QffSRWQ62vcJZLLrLo4r5Q5QdaISoNYZ16HkYHFCqUVLmdi65EGtKRgs1JG
	oQjGVLVXzdjUrjuphxA+esJo7QslepE3vjaHUcr0ZVWbNVxDI0aqqx5kwhECxQ4T0eoaWXV75PO
	V3yFECdxUbPr26RWUQMqT/JEzCr+/KtCUKvcZ3FYPxtEQb/0BJU5LYoj5OeW8yOlRkjnv+KZXPS
	axp2fKhhAThO3U0OTKcgHnkMkoGRsvwzHRW0U/cM0g0VYdvORmiiWr5yvqg7jlhnm0atXpH4WjF
	0bEyNmDPxivIUn4GQCMOE3hKCSBtTvwd7Z2X7ViI4p+Jgnwba+DBnuOr23xjsbUteW6SWJlmqGd
	WeQPextfGHC7pvN/1rCptImqhXgUDTULEhD8xNIBO3SlwRyuaBe9oqDGJMAQ9S/Azl0geenH2Ee
	Jnqw4zH4OvFRzZLHRerIAp3z8s9pCE0g==
X-Received: by 2002:a05:6a21:339a:b0:3a2:ecb8:56f0 with SMTP id adf61e73a8af0-3a39c214537mr1036677637.33.1777337572752;
        Mon, 27 Apr 2026 17:52:52 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae1ff95sm798672b3a.17.2026.04.27.17.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 17:52:52 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi
 <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Magnus
 Damm <magnus.damm@gmail.com>, Saravana Kannan <saravanak@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Ulf Hansson
 <ulfh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Kuninori Morimoto
 <kuninori.morimoto.gx@renesas.com>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC 00/14] R-Car X5H Ironhide SCMI CPG/MDLC remapping
In-Reply-To: <CAMuHMdU=3AN8wHbnO2Cx4WsLuYWhv_fRfTA50fmrqyREO3nrbQ@mail.gmail.com>
References: <cover.1776793163.git.geert+renesas@glider.be>
 <7hcxzqr4qi.fsf@baylibre.com>
 <CAMuHMdU=3AN8wHbnO2Cx4WsLuYWhv_fRfTA50fmrqyREO3nrbQ@mail.gmail.com>
Date: Mon, 27 Apr 2026 17:52:51 -0700
Message-ID: <7hcxzjewik.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Kevin,
>
> On Thu, 23 Apr 2026 at 00:48, Kevin Hilman <khilman@baylibre.com> wrote:
>> Geert Uytterhoeven <geert+renesas@glider.be> writes:
>> > TL;DR:
>> >
>> >     Describe hardware in DT, and perform the mapping to SCMI in Linux.
>> >
>> > The Renesas R-Car X5H-based Ironhide board is the first Renesas
>> > SoC/board combination that implements the ARM System Control and
>> > Management Interface (SCMI).
>> >
>> > This means Linux can no longer perform various system operations (e.g.
>> > clock, power domain, and reset control) by accessing the hardware
>> > directly.  Instead, these operations are abstracted according to various
>> > SCMI sub-protocols, and Linux has to send messages to an SCMI-compliant
>> > firmware running on a System Control Processor (SCP).
>> > More specifically, the R-Car X5H SCP FW SCMI controls access to:
>> >   1. Core clocks and module clocks,
>> >   2. Module resets,
>> >   3. Power domains,
>>
>> I'm very curious how power domain hierarchy is described on this SoC,
>> because one more issue to add to your list is that hierarchy cannot be
>> described for power domains in SCMI.
>
> So far I had no need for such a description. AFAIK, this is handled
> inside the SCMI firmware, which does know the hierarchy.  Hence the
> firmware can power up a domain when any of its children is powered up,
> and power it down when the last of its children is powered down?

Yes, but this firwmare behavior is subject to the normal list of 
limitations/quirks/lack-of-bugs/etc. that we usually run into with
firmware.  So if there's ever a need for linux to understand hierarchy
for those reasons, you may find yourself stuck. :)

> I think the clue lies in having a PSCI top-level domain, cfr. what
> you wrote in [1]:
>
>    "But... how do I describe the relationship of this hierarchy? In
>     particular, when the SCMI-controlled PDs are actually subdomains of a
>     top-level, non-SCMI PD."
>
> Or am I missing something?

Indeed, the tricky part is when the domains may have CPUs/clusters in
them, and in my case with the TI SoCs, the top-level domain with CPU
clusters is PSCI controlled.

It wouldn't suprise me that other SoCs have similar features where some
domains are children or siblings of domains with CPUs in them.  This
kind of dependency is pretty complex to manage in just SCP firmware,
because it involves TF-A/PSCI as well, so it's a likely spot for
firmware "quirks".

Kevin
