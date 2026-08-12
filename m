Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E98437107
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533704; cv=none; b=pP/0Ru9Dy+GLdzhgiyit0jU5wVafvLvZPcXlTqksf4tAftoNXYK80z4YsyEIFzvIwe/kC6alT8pBka96ofQqr59SmTjHyHuLsNggR3Sp8TSxTGqVsAHZHeC4Rl90ZziQymPyD+Xe+nw7tZZkCfOEDfdkobPmTAF0EJD750SCfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533704; c=relaxed/simple;
	bh=ZDQ5pPWDKwycT4E4mNOoJZ2LV+cHXkkjmMM1uiBduVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaoIuPwJjK52GYSl51ECrZy/9T1h0cnej5SsAHPOh7hhny8penzbq9AFd5YM5HLl5LIuamCPhuOBR38uLfcx7DBLUlL5uGbt+LoJ2PREOmirwkPUrgt3YrS+JEgIdKJOiBOrKegbdqf/SynkRWP7mydbR/G3gCuK/00aPjAx/hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1220348a91.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 04:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533702; x=1787138502;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DCCZvy6wBuqHUxauMraEzIMerW1TTEAMcJhR4qIYKD4=;
        b=e3ge3jSNHe6oYx/2t1HEfu0k375EdmVvcWQuNss35hkQrNB+cB5Yu7lyCHy41rdgBA
         UQxxuyDlmAppxKbKf58MtzKdjqwhZYm+yGy4w4JP7fjiptnfGkfQv+tF8v6yGWqNpcLz
         YmQFV88sbxiEzbmeE6rbEky69cYAgxqXjMzZpHcRSiInEdlaBjydyJmUWKU5VO6FILqK
         7F8De3o744fptwqZAl6ZgO7k4md4XcLPd4kzdhLXIDbny5nCRhzRzNVyN/8yXPEJFy8M
         hAJMaplMxt+dheYCODYK5sXM4R4ECi+AEoXQK8p9t4zzUVXc2UOw0R8/Zd/yvrx9rJsS
         6MEA==
X-Forwarded-Encrypted: i=1; AHgh+RqMpkhtnGmpaJzNnfW7wDbkDwDtmIs/E9ws/iC92rLOLNevtGBz2IrI4tlFkgRnLKbc+jHEFw2xlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+Zeh+Z2tAb282XIS/0/r77zg0OzbZNzvfU60Sbqp3tJoVLeS
	xJWIOGXV8Ci3gJacTl+x3CRW3OyS3EMGjcA5wofuAVBYPwRvAD6080RolYLGkw==
X-Gm-Gg: AR+sD13DuOhUwBoDPlEhVbAgL6AbViirzRkJY/pC4r52hiTsCvNDl6FYEtfNjHhyNmo
	5Q18BL/jRN0AlO701HLN2w7vIQBGix4dnOrxW+BjDE84idNEtERo6pDLiOqojSBlT2eo1z1Q6qz
	+KFHmjOJE0WakGhbQxTFH02b6KRqfZCiDnl8g8cHIQkN7PW7Z5BTvuSAWOfmCMQo4XpUeqmVeTh
	mf7Gzdd15VeR6ThPAUDn/qjlnLW4d9bNPiWPDL70ZnVK6DPsxmH88G7bebVMY3KE4Ut4Cn9TrKb
	pt7RD36j78ZQTRYVjAziicRsWmfEbijqAjhgFYwUaPkrVecIv9rASi8KJJalchDMZy3Usz4qS/t
	BoUFlbfJrucRO996DN/6bIbS/93Dypu5BmD3hCskHNsRYo5dFoQgUiUQB6KbJoQAdUSTwU0ukPE
	VHomf11WnXw0FpG1D73V3w6nJLCF3t7oD97LusYmFGA9qF28K5/rPgoYBEtHS5kgw8g7TA8UbrA
	Nzr2FM2PoClrZo/Q4XIo6nSUA==
X-Received: by 2002:a17:90b:48ca:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-3930142adf5mr5134223a91.15.1786533701793;
        Wed, 12 Aug 2026 04:21:41 -0700 (PDT)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com. [209.85.216.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8e3f3dfsm3311729a91.15.2026.08.12.04.21.41
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 04:21:41 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1220330a91.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 04:21:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrnY7bFtwLaLuj7LI+vJ7er3tvvZKhulq6+Ij53VBzjdun1HRbc2JY8mflzn6B+bdj+BkQDH65mKQ==@vger.kernel.org
X-Received: by 2002:a05:6102:5692:b0:740:177:f357 with SMTP id
 ada2fe7eead31-76c8d1f94a9mr774665137.6.1786533275732; Wed, 12 Aug 2026
 04:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505329.git.geert+renesas@glider.be> <49726acff0fee1c3606e83c4f242ef6aad25b4b8.1783505329.git.geert+renesas@glider.be>
 <20260710-adventurous-burgundy-chimera-b2fff9@quoll> <CAMuHMdV=ckONBbTYELPJU8YWoNzdu3PJ95VR8cz+f_7dUeiPUw@mail.gmail.com>
 <20260716214924.GA1477674-robh@kernel.org> <CAMuHMdU0ss6wUEdjC+OYa3iQS439aJ8b_d9M2ws7Ayn4_kOyMQ@mail.gmail.com>
 <20260811163334.GA2354701-robh@kernel.org> <CAMuHMdWbzg-QpFBzzDa2hC3HzAmWUkerESC5O-cSVxmWX3_PkQ@mail.gmail.com>
 <45dfd858-9d59-47e6-91e0-ef9e6e909af6@kernel.org> <CAMuHMdXJFdJQP1GVXrOWRuYO8Si_WF5X+vpzmAgTZY+tQstR1A@mail.gmail.com>
 <7b066c1f-20b7-407f-9268-e9dbeafab004@kernel.org>
In-Reply-To: <7b066c1f-20b7-407f-9268-e9dbeafab004@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Aug 2026 13:14:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVXgNcxDJf8XsSjXhC5+Pq6+Z+mcn6Hn50u8KwimKt9RA@mail.gmail.com>
X-Gm-Features: AUfX_myBSrf5rDcsVRuaQc_or0Um_HrH3WBYGhc9bJh3otQ1_zgZw-LE1s1AUdw
Message-ID: <CAMuHMdVXgNcxDJf8XsSjXhC5+Pq6+Z+mcn6Hn50u8KwimKt9RA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] dt-bindings: clock: renesas,r8a78000-cpg: Add
 firmware property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Wed, 12 Aug 2026 at 12:38, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 12/08/2026 12:02, Geert Uytterhoeven wrote:
> > On Wed, 12 Aug 2026 at 11:51, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> On 12/08/2026 11:47, Geert Uytterhoeven wrote:
> >>>>>>>>> +  firmware:
> >>>>>>>>
> >>>>>>>> RPi is doing similar, but I have doubts. It looks way too close to
> >>>>>>>> generic "syscon" which is disallowed.
> >>>>>>>>
> >>>>>>>> I think this should be vendor+purpose specific, e.g.:
> >>>>>>>> "renesas,scmi-transport" or "renesas,scmi-firmware"
> >>>>>>
> >>>>>> If you can tell me the resource that a 'firmware' provider provides then
> >>>>>> it is fine, but you can't.
> >>>>>
> >>>>> It provides a firmware API, which is not available until the firmware
> >>>>> provider is initialized.
> >>>>
> >>>> I don't know what "a firmware API" is. What does it provide? I know what
> >>>
> >>> It can provide lots of things (everything we are no longer allowed to
> >>> touch directly from Linux ;-)
> >>>
> >>>> a clock, GPIO, reset, interrupt, etc. provider is.
> >>>
> >>> A clock is an object you can access through the clock API.
> >>> (s/clock/.../ for the other cases).
> >>> Firmware is a service (virtual object) you can access through a
> >>> firmware API.
> >>>
> >>> In all cases, the consumer of the object or service needs to know
> >>> which object or service to use (there can be multiple).
> >>>
> >>> In all cases you cannot access the object or service until it is
> >>> available (initialized and registered), for which we have -EPROBE_DEFER,
> >>> and/or "[PATCH v2 02/10] of: property: fw_devlink: Add support for
> >>> firmware".
> >>>
> >>> Thanks for your understanding ;-)
> >>
> >> I think that's the difference here. Clock is not an object, but a signal
> >> on a wire or within IC coming from one device (provider) to another
> >> (consumer). Firmware is not a signal, not a wire, not anything which can
> >> be provided from one to another.
> >
> > Oh yes, it is a service provided by the secure world or a different
> > CPU core to the application core running Linux.
>
> Service is still not a resource. Not mentioning it is way too generic,
> because anything can be a service. We have entire services-based economies.

Do you have a suggestion?
This is just a phandle linking a firmware consumer to a(n optional)
firmware
provider.

What do you suggest?
Perhaps "scmi-parent" (cfr. "interrupt-parent", which also does
not point to the resources consumed, but to the provider of these
resources)?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
