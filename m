Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793673383;
	b=NV5LYnkA+rEOlLkxAGoMCt6kSxuTAMmijSpm0/p6DktpOBD/fLL+yDhmI3sLTYJogmbJ
	 h8FlrYAYsBHH6e6+jf9253oFi8lEucFPjHAlVFLaRAYhpm0Zm0tYD2XgEfAyJasvToSqh
	 FaWxLP7vWkoNU1+OdYmO7ULSRy4pcx+J4rcblfyvf9SuMk6LE4R5U9qEDxM5NtOpp+CLm
	 SD6XlWDdKNXo9aOvylCmmInccqRqlW5OhvxIZ0JJp2chbDU5o5qVnCz/KK7LEXP9Pr2TB
	 7PLeMzIUlMgm329oP5PHhEHGjYMzV+zJrsheGTpujS2PW4Ng+Ix/AvCrEF5oq6NDcIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9Jlikt+rNAof8xPAw+Y9FynKuu4c36ojLvpof3Ekays=;
	b=UPDic8TyD4gw0dztq1BoVdvoS2DyzUpqc8KEdchLxYsliTn26RElgdSUWIIR4YRjsxyS
	 Nu9bCdJ+5ZTF6oQPEd5u6t228i3gbcL6lM4oWUjQnq19VoeYzPyAKI1tMFWUHKNB7nzOR
	 ZjMPoPOcS/rWW5Go8ooPqab4u6zsTHznkdwmr2Y2TtBaYH2+cr0RWoOc9QpnW4oJiwF/w
	 47dA35+zk2/ILpQ724vGP8vjXz+PZx3WwV39CLsC46DyjofYKThj5CaIIETEZ1ni/M/yu
	 Nzut4suD1Ua1oGwvQCYOqmKmkqhrAwJ53Kp8JoXcnfBbsdOYlm5grs/8tIpB6mP0lcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=a4TvgsYw;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DFD606A326
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 02:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71DFD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=a4TvgsYw
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15dd124bbe7so5117225c88.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 18:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793673381; x=1794278181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Jlikt+rNAof8xPAw+Y9FynKuu4c36ojLvpof3Ekays=;
        b=a4TvgsYwUyyS0K9tedfdNHQcVmmTszna7pZdCPWDEUtUfS8eazt+3tw7+E0fRMUfaS
         fbpUnYPgGgifY/ZvHRVF5OLPg2c30UiopXSfMUiyig6a/tRPEeKoYjvQSV6xLBEBDqii
         FCwYWgrkpqBCRUi49rZFN8p0cYjDCfC5cmtpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793673381; x=1794278181;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Jlikt+rNAof8xPAw+Y9FynKuu4c36ojLvpof3Ekays=;
        b=q6irtJ5Sqm7jNLmP00e5tp3mxjuLLL4w6mxqIMWay0e1EEQ17JjPuc+tXz5Yx7ehCi
         KQqSCCSDy98LCNSL72m39IxgHhsxpAqPLFzE2Do1GiqURa1q2uTgvNldvdSzHg/hNv7G
         57SVQtgGqWNlrQy8NcfUr6vFHJuddFG4Gc2d7FkLuj5KqB3XJThWgXJ3VnTWshFfC1c6
         WIEKDWsa1hJencR90MQcfmoojamdkxBQDgzNO3u2ZxkfAPsj1yeNJaYrGSOXHP6fRans
         Zuqrv8wW/feVaYMLf1aGSC6GkkyaUanlpYgFElJIA6bjc0QIRCfhpeLuB0oLzPMK/d3s
         GM5A==
X-Forwarded-Encrypted: i=1; AKwUvBzV5hwUTqwbSZkuy5vuFiBoAZBGmhT11qQbjFBtSC1PG90EGKExoBK6AkPBUEDtaWNlBGe0pUJG5g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJYP0yAd8A+V86G3CIYVFDA2rVIejjFIiNPzxiKgCUZLZYZDmo5
	4dxb+xOYLM8Bk+UCXH7AdZRep+hjDe399+apK2z6eRWyhOGV325am06PRnDXk86EPg==
X-Gm-Gg: AYBFou1GvPTGGJd732TQ21vhmz+kryV3aFnMXogt8Q9Sixz7GARqCtxRVhH+2hKDtMM
	G6a4kUqyt0g5BqrLo5MhoXFo2ZdslUBI+bjs0o+P4nN4/SWsZxVDSNdPjO1c5skMbofEJuGkOzk
	ODYfGP3znWY2lpIfnh8yC2rtcOm7pnkS8Ot9/0QXaHCAu74Un1TsvrmgOxueZW6/iEYfgVkZjhw
	25WmBNdFxq65vXAqUDMGk03kMZNO1Q9s5CZNzJ+Q5eNYiWu1aqQFifS3xugJ07q1/o/LiWEHEwc
	XislQoou92E+P1P3/eLhUuXm6YmkBz4/XnSd4O8qFaXYj9OcLJBaItbjeGTnblDtZpcThv1+E5y
	KnOo7XBP0pvPkKiyRSKlMpjhDMvM9lxa98tp/82Yk8biVq+T+L1WIfFPk8Nhe4DimGdZ/ls+jcZ
	wHUAdX6HpSsn0RE0j5t2NAHL0AwXRhs0DsRWk4+lwETG4M0iiy3tCpYLf6fsHB4G20Nx8Q4be/n
	hKkDOjvkKB0DXqcwUyMCcew31UNOIkCt3BDw1VbDs5RJV214lIfvEWaeM5kfd0qs3zgfIHpDBCZ
	RBXpjvoEUoQqVFLI5bWCnPlpYW8gyWR2VwbColPlEeJt72V4ochWvw7k27h4ne9KT1o=
X-Received: by 2002:a05:7022:1110:b0:14d:c9e:a356 with SMTP id a92af1059eb24-1ac59dd07f5mr17524614c88.12.1793673381373;
        Mon, 02 Nov 2026 18:36:21 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:c57d:c93d:3543:aab5])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1ac1abcd6f1sm37000499c88.20.2026.11.02.18.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 18:36:20 -0800 (PST)
Date: Mon, 2 Nov 2026 18:36:18 -0800
From: Brian Norris <briannorris@chromium.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Griffin <peter.griffin@linaro.org>,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>,
	linux-arm-kernel@lists.infradead.org,
	Mariano Marciello <mmarciello@google.com>,
	Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org,
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>
Subject: Re: [PATCH 2/9] dt-bindings: soc: google: Add Google Tensor CPM
 binding
Message-ID: <aulIoq2oVjJ3DVzL@google.com>
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.2.Ib692ddd35c1dbea1757d9b1db6c1c7e938fc4ea6@changeid>
 <20261028-rapid-daffodil-rat-0adc6a@quoll>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-rapid-daffodil-rat-0adc6a@quoll>

On Wed, Oct 28, 2026 at 02:19:23PM +0100, Krzysztof Kozlowski wrote:
> On Mon, Oct 26, 2026 at 02:43:40PM -0700, Brian Norris wrote:

> > --- /dev/null
> > +++ b/include/dt-bindings/interrupt-controller/irq-cpm-google.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/*
> > + * This header provides constants for CPM IRQ.
> > + *
> > + * Copyright 2025-2026 Google LLC
> > + *
> > + */
> > +#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_CPM_H
> > +#define _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_CPM_H
> > +
> > +#define CPM_IRQ_RTC_ALARM_NO			0
> 
> Keep naming consistent. Clocks has _CLK suffix, so this should not use
> prefix.
> 
> 
> > +#define CPM_IRQ_AOC_MIN				7
> 
> Anyway, ABI constants should be indexed from 0 and incremented by 1.

What do you mean by this? Do I need to make up names for the
unused IDs between 0 and 7? On an initial search, I don't believe they
have any meaning at all. Does that mean I should make up some kind of
"RESERVED_<N>" naming here?

Between 7 and 156, these are just ... 150 different "service numbers"
within the AOC (Always On Connectivity) subsystem. I can name them
AOC_0, AOC_1, ... AOC_149 if that helps.

Or are you suggesting that I pack the actual use cases (so, 0 and 7-157)
into 0-151? I thought it was valuable to directly use the firmware
indexing where possible; if I change those, then the indexing loses its
inherent meaning, and we also have to add another layer of translation.

> > +#define CPM_IRQ_AOC_MAX				156
> > +#define CPM_IRQ_AP_GDMC_WAKE			157
> > +
> > +#endif  /* _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_CPM_H */


> > --- /dev/null
> > +++ b/include/dt-bindings/soc/google,lga-lpcm.h
> > @@ -0,0 +1,54 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +
> > +#ifndef __DT_BINDINGS_SOC_GOOGLE_LGA_LPCM_H
> > +#define __DT_BINDINGS_SOC_GOOGLE_LGA_LPCM_H
> > +
> > +/*
> > + * LPCM IDs of each SSWRP.
> > + */
> > +#define LGA_LPCM_CPM			0
> 
> What are all these?

The binding doc says:

      Each reset is specified by an LPCM ID (cell 1) and a reset ID (cell 2).
      See <dt-bindings/soc/google,lga-lpcm.h> for LPCM IDs and
      <dt-bindings/reset/google,lga-cpm-reset.h> for reset IDs.

and

      Each clock is specified by an LPCM ID (cell 1) and a clock ID (cell
      2). See <dt-bindings/soc/google,lga-lpcm.h> for LPCM IDs and
      <dt-bindings/clock/google,lga-cpm.h> for clock IDs.

These are the IDs used in the firmware interface to talk about these
things, as many of the SoC resources involved (clocks, resets, power
domains) are grouped in this way (by subsystem (SSWRP / LPCM), and then
with indexing within each subsystem).

In reading again, I see that the definitions and explanation of these
terms and the SoC organization are split a bit between the pmdomain
commit message and the binding doc. Where would you prefer I elaborate
more? In the binding doc, the comments here, or both?

Or are you suggesting these IDs should be allocated/structured
differently?

Brian

> Best regards,
> Krzysztof
