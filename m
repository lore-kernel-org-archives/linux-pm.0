Return-Path: <SRS0=4Unk=4M=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A1AC38BE0
	for <linux-pm@archiver.kernel.org>; Mon, 24 Feb 2020 20:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7D920836
	for <linux-pm@archiver.kernel.org>; Mon, 24 Feb 2020 20:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582575182;
	bh=i0dgw2Q+1YVKmGGlsPI7If+6J0Et1FGH9ivpNgD/N8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IeX6xDfUvYh9YnYzHiRfJNGXkAiG79z2cSiSLtMdDVg4uJuyEMz+g7UGOfvIxzx2U
	 3YKl/hgDDPDSIVcuqJPjJI61ald8Q7tEKvwb/Wd5xbOWLUFS5YHbvw0rSddLJQTWQy
	 27HVw0FokqkjLNwUtfldC8Q29H7J6p54TZDD7h6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBXUNC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:13:02 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41201 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgBXUNB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 15:13:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so13451500eds.8;
        Mon, 24 Feb 2020 12:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TwCT11Q8st6DRF5f77QlbvmNTg2E5sCFURGACQNwpRo=;
        b=M0qrcKD1M4eGLM7wE1bVijszZHCZ3HAstykQhGiAT8kwM8u1A9FA1M4/bnWGs2SSAh
         OntM4rK2t0bx1eZ6Sw2QpBNjWHAjZwm40zs8dqcLB/5QKPdLg+gVBgriIHgBxLeqiQGH
         mtkzawKMsPDG9So3snvEEO6qFzcSSsC6FFQAKTBFH9ym+/1F9lcSy9eePmGzYOLNdhO9
         TEtWXhuBSb/BIcd1ep2Ok/JepZ9Ng4roi+GKiHpao87Y+cDWflKUHF5+Kpl+jHXxh6PX
         WsfHbUnTuD8OGBwOu7J621GKErKrMKzQMS6LIIZ8dmEb6Ys41qhHvQ02EHLcnqDMf4H+
         X0Zg==
X-Gm-Message-State: APjAAAU9VPfYo01EI2VXMD3RZzz/NZyPDrMzZo1mqary0+ox0yd4l30D
        TI1HIJd7M700ixCfF7hvfDQ=
X-Google-Smtp-Source: APXvYqz1+/Sz4RMczX4pFEQdlHMFqh55PdbPuTHZn3Ir9AYpBo51uk9X0M9WvatqCco7VEZqEmqhhQ==
X-Received: by 2002:a17:906:2653:: with SMTP id i19mr47243420ejc.287.1582575180052;
        Mon, 24 Feb 2020 12:13:00 -0800 (PST)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id d16sm1051538eds.18.2020.02.24.12.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 12:12:59 -0800 (PST)
Date:   Mon, 24 Feb 2020 21:12:56 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] regulator: max14577: Add proper dt-compatible strings
Message-ID: <20200224201256.GA8060@kozik-lap>
References: <CGME20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45@eucas1p2.samsung.com>
 <20200220145127.21273-1-m.szyprowski@samsung.com>
 <20200220165614.GD3926@sirena.org.uk>
 <964b8c4c-36ca-203d-e62b-4a8fc970e23d@samsung.com>
 <20200221123813.GB5546@sirena.org.uk>
 <b52332cd-1dec-fdfe-51fc-8605d94abe7d@samsung.com>
 <20200221171342.GI5546@sirena.org.uk>
 <61dc8192-e313-021f-9e23-928257a66984@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61dc8192-e313-021f-9e23-928257a66984@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 24, 2020 at 03:08:05PM +0100, Marek Szyprowski wrote:
> Hi Mark,
> 
> On 21.02.2020 18:13, Mark Brown wrote:
> > On Fri, Feb 21, 2020 at 02:23:57PM +0100, Marek Szyprowski wrote:
> >> On 21.02.2020 13:38, Mark Brown wrote:
> >>> We could just remove the compatible strings from the binding
> >>> documentation, they won't do any harm if we don't use them.
> >> Frankly I have no strong opinion on this. I've just wanted to fix the
> >> broken autoloading of the drivers compiled as modules.
> > Shouldn't adding the relevant module table for the platform devices work
> > just as well for that?  Possibly also deleting the of_compatible bits in
> > the MFD as well, ISTR that's needed to make the platform device work.
> 
> Right. This will work too. MFD cells will match to their drivers by the 
> name and modalias strings will be correct. The question is which 
> approach is preffered? Krzysztof? I've checked other mfd drivers, but I 
> cannot find any pattern in this area.

I would guess that adding MODULE_DEVICE_TABLE() for OF-matches in main
MFD driver would fix the issue... otherwise the same problem we have
with max77693 (also MUIC/extcon/regulator/charger).

Some of these drivers (I guess only charger) bind to a OF node so they
need a compatible. I think we added this to regulators and extcon for
symmetry.
Without this binding, the charger would need to read a specific child
node from parent. This make them tightly coupled. It seems to me more
robust for each component to bind to his own node, when needed.

Another reason of adding compatibles was an idea of reusability of
MFD children (between different MFD drivers or even standalone) but it
never got implemented (children still depend on parent significantly).

In general, I like the approach of children with compatibles but I will
not argue against changing the drivers. They could really use some
cleanup :)
Long time I tried to remove the support for platform_data [1] - maybe
let's continue?

[1] https://lore.kernel.org/lkml/20170217200200.4521-1-krzk@kernel.org/

Best regards,
Krzysztof

