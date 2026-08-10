Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D7407CE8
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373435; cv=none; b=iGYadOHcVVdMrmlsD/3E4X7ZCqmNgNFsOXPf1ok+h1N1b/jRIU5R50/MJrEnI/eyzY3pM8IpZXeVwVhe4/vyC07eeEpJOuUJZq2chJb/V5vwuEWk0bak5axBehWWJb5G/usqkIbxyZd9/NDCecIFEH1ksQr5SGEhU3Xi61efue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373435; c=relaxed/simple;
	bh=n5rMYOLB08GVMHx1R8PCKx0D3UZSKzHrcfaS81rxPSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCg851q0gBRCOwMEf41GechUX2OYItxcsH3/VRT7N5d2zD1AZe1lg4h9FU2jHaNdAH8tmQGjNyEs5h6SuGsx26xUfjLIjj+VAXyjuUfAfWQS4Be095cFRmrhAiKPiti+hYhN6i0OcD6bVBeJtxA9HQKchHPjIZXN7ZM7TxWkC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9674d727c0aso3014651241.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 07:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373432; x=1786978232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDUVqF9bGKPqsW39iH6LzgBQf6STHLl+9ztnXalCrFc=;
        b=G/6b502pjUi3EmRwMgAeMDj6gcXYChWprloqaClQ+OKI5QQIuNu0X6vILbeU49aEOO
         wI9gOgeQDF8XLAC7D8er6LVDZtqsOu9HWtows8yaxwJpIxm8nnOpvhBMMc3bv3XmnAWY
         djtDESbMOsWlJjxr2Dr0VIWMzUAKLrcgsIfeZoECEBfKbhomK5558Ggpb76KdPc3KPwV
         svKAFIsaWQH7hxMBg5K/bHbtqAkpPOg1afhV47A/8lyxH1oGeMJjyTsY7nImM4kUhlbf
         WEtl4+iVXGFw2nXWdAx1kxR03Vl5+o3SVMMhQDDEGAOcRtFcZnl2icDFR7Us66xWq1oM
         sIPg==
X-Forwarded-Encrypted: i=1; AHgh+RqAcCFd5eqsm86agD1TVvw15XYTFNDD8ilEN6NCFk60PbSDfoyr4wf8o7RQVcOdbojMiBpJLk9Qzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFYfb65sCVIHqrIBfgXV5u+lSijjOozutxnpFOMX6qt4aiev68
	enQppnPKltUs0QkTfJQKwqfL6JfDh71czx8/L+jWb1+IXKdWV0iRU3fkpHrSBkGn
X-Gm-Gg: AR+sD10Nd4IG9lbYh3t+56Hf+Wou5T+QX3hropgtGRVmSHLVoBVyNPdkxZjRcmDi5ZS
	HSZA/J+VZU0Mvro2Shb94iWXEnI4xjiUgVlfUNFGYaz4wDlomzaxSeTJwN9yanWhigE3v88/MJo
	0T769NeR4nN9azbiobEcRLxq/fpDLAPS2LzHyfe1TqZSpKKETMRboUFPU3zQsHxnv1m9CUCcP4E
	WMPfBdxospa68vVTGLjeq/wrASRAmPIUhTbYudDJ2MpkhgI1rCEjIIKLbe5tYgrsfUT2e2QMfOj
	Wqhep29yyknxpd3MvonkZ+rHw2Isq/LkFT81M2FwiZ2cTQhm9Z+pKiskn1ZCbnBSzd/Gdc3NR0G
	+jQkxlVIdXPFYCY/bTLy9kWD+wRGQQUlp1PvyQ7ub8w4O7dJ49+yZBUFqL7c6LaUM9pkO3+/fii
	/r4aFmQqnM7ZGSRAq2OhhoENGS9b/1TpF23p/6gs0p5XHfDZOfdBKvwOFmU/LWrZqQH/VNRi1DG
	and5KHXlftG4Y7OrG0TlYi/qw==
X-Received: by 2002:a05:6102:2082:b0:74d:5456:b6fb with SMTP id ada2fe7eead31-7652241d10cmr1596996137.16.1786373432328;
        Mon, 10 Aug 2026 07:50:32 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-979f2e53fb5sm3636387241.1.2026.08.10.07.50.31
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 07:50:31 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-977ba4d3b49so1516164241.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 07:50:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpn418I8zDll7DV00Feph7dlby3vJZi1P65OqFZTLEENdPCT6tM4pSEapoK780q5txrkDbXE8Hkwg==@vger.kernel.org
X-Received: by 2002:a05:6102:2082:b0:74d:5456:b6fb with SMTP id
 ada2fe7eead31-7652241d10cmr1596982137.16.1786373431244; Mon, 10 Aug 2026
 07:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785941595.git.geert+renesas@glider.be> <CAPx+jO87d7H92KSR7R7ObR05sM2JcHBCo+YuUf_1gE-KwhR7CQ@mail.gmail.com>
In-Reply-To: <CAPx+jO87d7H92KSR7R7ObR05sM2JcHBCo+YuUf_1gE-KwhR7CQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Aug 2026 16:50:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW78wFHKP8n2P_MEVASO3MFHCjXkEWSFXfE3-mCjkhsgA@mail.gmail.com>
X-Gm-Features: AUfX_mzSDh0l0A6CyrHddRhefJg-h_HSruJEAkSrbmndCIqd_rMaLktXcM1WovQ
Message-ID: <CAMuHMdW78wFHKP8n2P_MEVASO3MFHCjXkEWSFXfE3-mCjkhsgA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] R-Car X5H CPG/MDLC support
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Mon, 10 Aug 2026 at 16:18, Ulf Hansson <ulf.hansson@oss.qualcomm.com> wr=
ote:
> On Wed, Aug 5, 2026 at 5:21=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > This patch series adds minimal support for the Renesas R-Car X5H Clock
> > Pulse Generator (CPG) and Module Controller (MDLC), to aim for replacin=
g
> > the dummy clocks in r8a78000.dtsi with proper hardware description.
> > These two components are closely related, in the sense that they are
> > both supposed to be accessed through the ARM System Control and
> > Management Interface (SCMI) on the Ironhide development board.
> >
> > This series consists of three parts:
> >   1. Patches 1-2 add DT bindings and DT binding definitions,
> >   2. Patches 3-4 add minimal CPG and MDLC drivers,
> >   3. Patches 5-6 update the DTS.
> > Note that this series depends on v7.2-rc2, due to the use of
> > <linux/device-id/of.h>.
> >
> > Changes compared to v2[1]:
> >   - Add Acked-by, Reviewed-by,
> >   - Add fixed-rate clocks to kerneldoc of r8a78000_cpg_priv.map,
> >   - Use devm_clk_hw_register_fixed_rate(), drop unregister_fixed_clks()=
,
> >   - Drop fill_clk_map(), as it is not really needed until SCMI remappin=
g
> >     support is added later,
> >   - Replace <linux/mod_devicetable.h> by more specific
> >     <linux/device-id/of.h> in v7.2-rc2,
> >   - Add a comment to document only always-on domains are supported,
> >   - Consistently use /* sentinel */ for zero sentinels,
> >   - Drop trailing commas from sentinels,
> >   - Sort MDLC nodes (alphabetically, by label).
> >
> > Major changes compared to v1[2] (more detail in the individual patches)=
:
> >   - Add default support not using SCMI,
> >   - Drop everything related to SCMI.
> >
> > Note that this series does not use or rely on SCMI in any way.
> > SCMI remapping support will be added in a subsequent series (old versio=
n
> > at [3]).
> > Full hardware support without using SCMI could be added, too, if anyone
> > would care about that use case.
> >
> > For testing, I have pushed this series plus additional work (including
> > a rebased and updated version of [3]) to [4].
> >
> > While I know it is getting late in the cycle, this work (especially the
> > DT bindings) are a dependency for about any R-Car X5H progress, so it
> > would be good to have it included in v7.3.
> > Hence I plan to queue the clock patches (1, 3) in renesas-clk for v7.3
> > (Stephen still hasn't merged my earlier PR for v7.3 anyway).
> > Ulf: It would be great if you could take the pmdomain patches (2, 4).
>
> Patch 2 applied for next, but I left patch4 for now as it didn't apply

Thank you!

> cleanly (drivers/soc/renesas/Kconfig had a conflict), thanks!

I guess your tree still has the duplicate "default ARCH_RENESAS"?
Patch 4 just adds a single line there, and the conflict should be easy
to fix.

If you want to send me a new patch, please let me know.

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
