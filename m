Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795526381;
	b=tUnNb/j4d+YdmdFXStrQJXIEZeYJt94ZWk+5EJeTxEDvloWBD1l1xN+a16x3aI5Rgyir
	 xTCoLGmUnVi6sjeBBuCFu/wgdee/9LYtpG4LfUTAkWO1gp+GZTYl8ICV4uaiXK7gcZj4V
	 +1tt1/PCduZk/hh6wd3xTmBlsRi2t2O5CGCA6SFT+PO5vFgP8D+J7u6m+k2tA51mgXJPy
	 0sotb59wOpLUYPDeSXnqNiO6Hned7K6qXz2znqj0UKltM2bl/MCWv2rzYz23bxhxUdvMn
	 +A0JRY17AxfGognMEftlNR5CW14mlfkeczkd4FKto9zXKzlVhdGGyhoK8qz7cKfV+AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=I1ulVDnQMydRA55SV06KZXVEPk+ELjbN3ZZrUa+XmEo=;
	b=gPWRK4uxDEiRIQ0SSloOydualaBqx4TC7z5TG3wOGml2OxBPzUwtsbClR5diHcqBJ/K2
	 ZH5tntm2huTr7Fix8PHUcqTDpsxEfttIMTKPH22VXCJ2SlqKF5/1Gp/hlUcmcXTOUnT45
	 K1XVPdD4hINMknR5v+BDlBfNsrdxwPU56vd1r5bnWQMM2mVHINgtWIrtyWsdG5yr3W/cp
	 tvWtMAOhXuyFJ8VKIajxO6SsuL70Z2+EtlJcBbHVuN+dmBwpir0IsGuXpJ0ykq89cm1CF
	 +GiFYfX1VkmpjZSWJ1CbDShmV2mubJRWu3RxOszoh+M48CVY3W2QuTu/Hgt+DU5EWuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eBYWubu2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB8606A327
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 13:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18AB8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eBYWubu2
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so5309579a12.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 05:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795526378; cv=none;
        d=google.com; s=arc-20260327;
        b=YJm8YSiZ4iJQb+gWWkDXZsxkO1o3AI1Mqk0ZggfuEwzdsZ5EQ9lYPU1wEkCmJV0Ji3
         X4GPitvQ/l6u/979zcGydU8OQq5WWTVA5HVtqlnxmnSfseq4eLz4PHPACSMOkk96qGUc
         qWw2ySDtoffqSxnjGPIn0iR0ylm+Ah7f32DIkw71/1E5MzJNmumSS+6hk0RNZI3UU4ZK
         tFuhK/M8vzi1yi4OLLhc6iS/nH66X1W/S9QWJ3LUH9AEq6Port4chUd9dE1+m9axhEsQ
         8bB9ds4H2GZTmtGWXZKs06DFIIY915E/jfySsToleuhWN6XgRFf3enYZQY45Vz/lCGR6
         eekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I1ulVDnQMydRA55SV06KZXVEPk+ELjbN3ZZrUa+XmEo=;
        fh=qqQLitCUWQtHTjEmGQPZdbrKW/LoEWaWDEtLXymjm9I=;
        b=Y0wdbwdjL4k9ynIrMkjhZ1kynfNEBQoSNvFJe6uMX64oQUWQLjng3ujIusNiCKutz7
         1iCvffBdTOwrEgN9cX6FTsIvDjEe4w72+XZZUeS75nII96TyO9hpY81K32dKc57bTWqQ
         mniQv9L2gUMC5gPTR3BHXKuLpQZP8OLz/zN2qzbGlyzSLESff5qf6P+zIIKmJwm4Vs5r
         pX9K6OvtRElyoN4R0UhbdyeGyRlCV2j/S13mK84fpgT5HKx8reWbiT+fTIg4tEqJBf0W
         z+D2qSGTtNoyRVRFnzF0MoEgot8UaXsxkiAYDfHsHuGkV4vOU4kmHVSU+pBp5BbpjxRJ
         cC1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795526378; x=1796131178; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I1ulVDnQMydRA55SV06KZXVEPk+ELjbN3ZZrUa+XmEo=;
        b=eBYWubu2GiEXhpZu6NdOBq+vSwbV2FWVHzzO6RCiBLF3DvcP2g1JrmnU+BQv3R0zGN
         kvvTgrQIAxANAxro5Oi4eaxN11YT4WSo0OGv3sRSFgIFtpq2En16+JONirIcUEETALNQ
         lRVCNoT0kNT2qPFD2IWuVCxhrYBnh5jAlemWaTyIE7hEjR7KV8NybKjN0kUWJdA+sB4w
         QCdLvsMub7B5jXdqoCYHrijtJ+6czKn3vhUqvkpfWmPyXwN3GWPgW6exGBFya7/YtS85
         mfcSZbYjUeSYDWzqhY5Mvgb5gdQiAC4XUEToNNz56GmU6lGixrXnDd5LM/7NDwcPiHOn
         69aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526378; x=1796131178;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I1ulVDnQMydRA55SV06KZXVEPk+ELjbN3ZZrUa+XmEo=;
        b=06Kmes+7Nc7l5kFBcBYFAAIm+n4yjif5g+hbaCoosJl4UMwGQxDkgDyos1kM4fdTg2
         WXYYQfuAqPHbG9AQZc0w25DYNLU63JS9KZmOW6ljyHmwj+UXm6qWq/0l9LfQ7PSnIGk8
         llprqhXezS2QsflLG5+J9PUmlOcGPCTTaiHmSaBPacHAtu5jEr8Kt5giqkM8DCA52CAy
         x17u5sV7o5mIl3WMRt68NahHiWTSImhFpHGD7xPSRFRs9rsNhk8tFrsqH964vXz3YcNK
         stL2XoVlYjTPx9bDERjZTbhky6kvajq8BZt41wTgN8jGG0tSj4woVOTai22fyBNqv06S
         bnnA==
X-Forwarded-Encrypted: i=1; AL+hErHxhxo6iKJO7x9/pkKZh48SqA5ihLZuaGN5tH0RR8e0EV0zltaE+zALHD6oxDmuj3d6+Rs8QTUOxQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9xQKr/J3RTgi+LCn1eTwwakgOhyDAx/Bka1mT5JMfqWYRhIkvz
	ns8gTYfZC6MBpboqjbSmmPY7XWm4gC32HUhloonFmf6nZJslKDG1MkCWHs5gy4amLvyQpdiNL3a
	MzMfMlPXkNStdUWrzwgDK6bUGnw6aXOqivmuyZSOyVQ==
X-Gm-Gg: AZFdTZffyV8rh8JvfbA7i8zBS19dtMtCrhVN7Uq0GX5g3sc5ea/GlHe+le5Cu3KdSwA
	RClznj6dnFiFfxAVAV4a287PcYIuw01928wxrKsPnZ+ANdFMBQbZTSJiDsCeBfM3g++ngA0dtTi
	lWSJkPk0HGu8JcSJN7csq5Rr9ryT/S7pM6VPVFhnPLJWFf58EP9VlfS/o/Jqq1BoWTqxp6EPe4y
	4tCZhqfq/7mu+dCVXj3Kb5VsnCvU4ZskoHEEuclG2PUIIRL2HgLG24Rx8uI0Nr8CIr/NgWq5Sj0
	dh9bNYXZtWUQsfEhu4l6dCciHjf01RioaxqVi+JmQVkmWIAX7/RXnIYHfWSfxplcsXzPMV8sP44
	MSbexeVQpKjz51QCHaQNbTvLCGMyKSxiUmbDb/0jIf6BDy85H2btLkyuK
X-Received: by 2002:a05:6402:1596:b0:6bb:6c8:c4d2 with SMTP id
 4fb4d7f45d1cf-6bb06c8ce30mr940474a12.31.1795526378188; Tue, 24 Nov 2026
 05:19:38 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026214359.3122870-1-briannorris@chromium.org>
In-Reply-To: <20261026214359.3122870-1-briannorris@chromium.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 24 Nov 2026 13:19:24 +0000
X-Gm-Features: Aa3M54ooVkb3f-H5oJfKOqKUsi4VT1Jkh00xU7wD3yuOn0cj9WC5t6c3w4KgoWc
Message-ID: <CADrjBPojS5tSJw+7E99AYec6NY46QLcM6iv=i3xodNJvvxKJRg@mail.gmail.com>
Subject: Re: [PATCH 0/9] google: Add support for Laguna CPM
To: Brian Norris <briannorris@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, 
	linux-arm-kernel@lists.infradead.org, 
	Mariano Marciello <mmarciello@google.com>, Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org, 
	=?UTF-8?Q?Jakub_G=C5=82owacki?= <jglow@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Brian,

On Mon, 26 Oct 2026 at 21:45, Brian Norris <briannorris@chromium.org> wrote:
>
> The Central Power Manager (CPM) is a co-processor on the Google Tensor
> SoCs, as used on Pixel phones. CPM supports power-management and a
> number of other features.
>
> The Application Processor communicates with CPM over a pair of mailbox
> channels. CPM provides clock, power-domain, reset, and interrupt
> services.
>
> This series adds device tree bindings, DTS, and drivers to support CPM,
> and several of the basic services provided by CPM. These services are a
> minimal set needed to bootstrap many other components on the SoC --
> e.g., I have a working proof-of-concept PCIe driver running on top of
> this series + pinctrl (not included here). CPM provides some other
> components not yet included in this series (e.g., PMIC, RTC).
>
> This series depends on the bindings and mailbox-payload-definitions from
> this series:
>
>   https://lore.kernel.org/all/20261023235408.3063350-1-dianders@chromium.org/
>   [PATCH v2 0/4] mailbox: Improve the mbox core then introduce the goog-mba driver
>
> So this series cannot be applied as-is yet. However, v1 of that series
> was under review for about 3 months, so I'd like to at least:
>
>   1) demonstrate its clients (this came up at
>      https://lore.kernel.org/all/CAD=FV=VW2h1zWDYWQ6LknX3O+3=EY665jde35Ly+UQzuscXy=Q@mail.gmail.com/,
>      for one); and
>
>   2) start review for anything that isn't significantly impacted by
>      potential changes in the above mailbox series.
>
> With luck, the general design and DT bindings don't need to change, but
> even if so, I expect any changes should not significantly affect:
>
>  (a) the CPM DT binding or DTS (apart from #mbox-cells)
>
>  (b) the CPM interface (cpm_request_client(), cpm_send_message())
>
>  (c) any of the CPM clients (irqchip, reset, clk, pmdomain)
>
> Thus, I think this falls somewhere between "PATCH" and "RFC".
>
> This series has been tested on a Pixel 10 Pro XL (a.k.a., Mustang) both
> as-is (plus the aforementioned mailbox patches), and also with minimal
> additional local patches to get other components running on top
> (pinctrl, PCIe, RTC), to prove out some more realistic use cases.
>
> - Brian

FWIW, I tested this series, plus Doug's mailbox series on my Blazer
and Frankel devices. It was enough to see USB come to life as a gadget
using the already in-tree tensor USB glue and phy drivers (see patch
here https://gitlab.com/LinaroLtd/googlelt/linuxlt/-/commit/b7866f74743fd6828036bae570ca6d022e23c4ff)

Tested-by: Peter Griffin <peter.griffin@linaro.org> (Blazer/Frankel)

Regarding merging the dts/dtsi (arch/arm64/boot/dts/google) and
(drivers/soc/google) parts can go via my Tensor SoC tree. We will
likely need an immutable branch for driver/soc/google part to base the
other drivers off.

regards,

Peter
