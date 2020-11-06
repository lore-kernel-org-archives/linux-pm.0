Return-Path: <SRS0=UEvt=EM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F791C2D0A3
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B251C21D46
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604687637;
	bh=V8u9ShZ2bfuwMPtCHpkI3ZGxTxtg38ZsL0KQxBRTbPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Evd333BJCFtJ2IMMFvC6NeaeXYRfNY+4p/P4Aa7hej1W/6bRz1m01Ti0m5SzGCgPL
	 LL82gqU2kHhHV6F5Y5bpSg813rh+BWyau6Y3XHdjMfAKcVTzugJuic/54qG04sTqs9
	 uVWlRIsvSJaDO2jJ/vvlETqbpI4LgnvkcWUalZjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgKFSdy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:33:54 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45712 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgKFSdx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:33:53 -0500
Received: by mail-ej1-f67.google.com with SMTP id dk16so3229130ejb.12;
        Fri, 06 Nov 2020 10:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=irZ12SbbSCqDVzveJpX+VcrhhOjlapLNW1b3S/AMVe0=;
        b=SGp8XcIEN1VSg9w4grmvcrqlZM/kiolJYCdumjvjNG86by9zQ3hKQzD2pfbnboJj2M
         1XeNyYxSBH7syoTx1eqxYJhpeCCgs9bCvtC6yjJsXSrBIHnITjUh867g0asRp9SDWkWc
         ZLZw6WG7dtM4x7suoWfngcZzqoH1IvjHkobpCUtNq0dGyhy/8HVFOynse5BBItzmFJIs
         k4ZsVNJj16V0UgjrP7CnTNbzBHuOEVNZXXlUPtoIFVYpDkjc2SjoNgeI4HGRelMGp9n9
         at1cZ0gzZ59Br+JpedUSECJOKXcjILwS/cQh3JUS1liw6HXSMu/HF+uJAshDMPLM9N48
         1xhw==
X-Gm-Message-State: AOAM5329Bo1reUBY+eBU81Qi1sGbB1Ek2Fvb+0W1mo9fn7sWnekdDB8K
        XgbCPSR9cV3zVsiZaiyUMPM=
X-Google-Smtp-Source: ABdhPJz8C1XSHSfMN9i1f3xXNic0zmGfdJdwpqf7v24uy1m3zgtFjeNADWRaTxkMnR0u3C6n71pCcA==
X-Received: by 2002:a17:906:2697:: with SMTP id t23mr3491901ejc.292.1604687631594;
        Fri, 06 Nov 2020 10:33:51 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a1sm1619624edv.88.2020.11.06.10.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:33:50 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:33:49 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 12/47] dt-bindings: memory: tegra124: mc: Document new
 interconnect property
Message-ID: <20201106183349.GL65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-13-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-13-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:48PM +0300, Dmitry Osipenko wrote:
> Memory controller is interconnected with memory clients and with the
> External Memory Controller. Document new interconnect property which
> turns memory controller into interconnect provider.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra124-emc.yaml     | 1 +
>  .../bindings/memory-controllers/nvidia,tegra124-mc.yaml      | 5 +++++
>  2 files changed, 6 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

