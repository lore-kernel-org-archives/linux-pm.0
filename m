Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F91C388F9
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 08:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EEEB22258
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 08:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603788784;
	bh=SqUJ9x9risv90uZYTfnyI8hkuL48fOtSxMLCvQ2Gi28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HRq5UlWJl3GAVOBlInkh8WBgBuo+GsxDS9mK+erJTQPmoOJza2iKQ28Vidj6ooQmC
	 9qdGPPDPkrDtroECjADXdiqn8NuVxaGmgrhq/fDCU5RcJa0bEqhquWaUXmZ06Sfa0t
	 46KIsrY1jek8ezpRUH9hH9gUZnPVBPgO8BPlnF04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895120AbgJ0Iw7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Oct 2020 04:52:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40599 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895116AbgJ0Iw7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 04:52:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id p93so576841edd.7;
        Tue, 27 Oct 2020 01:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=miK2E28wkgKpBF1Fb19w02StT2/a3W+EFB25jg9SneM=;
        b=Hb8Uuy7WFlcCsoIAS0qHGUuWg/TSfyWokYWQWRHBg0No6zSu+t3giURfdXdtiD+8KP
         VM6BrJBUrAqFpa9AdN9CH4QPSOHNNCtZx/uu2pJ5Q8mcpTAdUmPRRzhtmvJM1GdhPKKK
         VdAHIaxuF+oxOy5OTuv1E/kpwt6U7bEHKUmxfjnHrhJNgDp1n3EtTHvLX2VsFPwMxcfF
         Jp84pvpmKwfG8pzUYcY+9Q/BxwARdmYk+4qRZpBn3K5dRPyknujn4aB2JtZRwnQFDKgj
         0pzppMv1bkGeKNdbpph1FGIROF0Z2p5VWbSFOJK+nDU2RZw7S4mLDCbPyR2NJr8Q19b2
         20zA==
X-Gm-Message-State: AOAM530Z7RhqsvzAjmBYEjZLy65is8zY4j8pqvMc4K4weZFfdJ0F0MtY
        HAotwad2mJQhFP3mvAgaNzY=
X-Google-Smtp-Source: ABdhPJx3r/Ivqz3bC6fK7Dk3U50yBK7Yqy4j7oDemcQ7xJqnXXJr2+AP4pt/yaUfzlPS/UM2jTnfbg==
X-Received: by 2002:a05:6402:135a:: with SMTP id y26mr1113530edw.114.1603788776652;
        Tue, 27 Oct 2020 01:52:56 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id m25sm503543edp.36.2020.10.27.01.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 01:52:55 -0700 (PDT)
Date:   Tue, 27 Oct 2020 09:52:53 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 00/52] Introduce memory interconnect for NVIDIA Tegra
 SoCs
Message-ID: <20201027085253.GC4244@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201026150845.GA87050@kozik-lap>
 <48a5cfdd-c170-f6d3-001a-2d343ecb2c5e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <48a5cfdd-c170-f6d3-001a-2d343ecb2c5e@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 10:14:10PM +0300, Dmitry Osipenko wrote:
> 26.10.2020 18:08, Krzysztof Kozlowski пишет:
> > On Mon, Oct 26, 2020 at 01:16:43AM +0300, Dmitry Osipenko wrote:
> >> Hello,
> >>
> >> This series brings initial support for memory interconnect to Tegra20,
> >> Tegra30 and Tegra124 SoCs.
> >>
> >> For the starter only display controllers and devfreq devices are getting
> >> interconnect API support, others could be supported later on. The display
> >> controllers have the biggest demand for interconnect API right now because
> >> dynamic memory frequency scaling can't be done safely without taking into
> >> account bandwidth requirement from the displays. In particular this series
> >> fixes distorted display output on T30 Ouya and T124 TK1 devices.
> > 
> > Hi,
> > 
> > You introduced in v6 multiple new patches. Could you describe the
> > dependencies, if any?
> 
> Hello,
> 
> The v6 dropped some older patches and replaced them with the new
> patches. Previously I wanted to postpone the more complex changes for
> later times, like supporting OPP tables and DVFS, but then the review
> started to take more time than was expected and there was enough time to
> complete those features.
> 
> There are five basic sets of patches:
> 
> 	1. DT bindings
> 	2. DT changes
> 	3. SoC, clk and memory
> 	4. devfreq
> 	5. DRM
> 
> Each set could be applied separately.
> 
> Memory patches have a build dependency on the SoC and clk patches.
> 
> The "tegra-mc: Add interconnect framework" and "Add and use
> devm_tegra_get_memory_controller()" are the root build dependencies for
> all memory/ patches. Other patches are grouped per SoC generation
> (Tegra20/30/124), patches within a SoC-gen group are interdependent.
> 
> I suppose the best variant would be to merge the whole series via
> tegra-tree in order to preserve logical order of the patches. Although,
> merging each set of patches separately also should be okay to do.

Thanks for explanation. I already have three patches for Tegra MC (and
probably two more will be respun) so this might be conflict-prone. The
easiest in such case is to provide me soc and clk patches on the branch,
so I could keep all Tegra MC together.

Best regards,
Krzysztof

