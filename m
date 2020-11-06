Return-Path: <SRS0=UEvt=EM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961BDC55178
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B402087E
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604687421;
	bh=XZzXv/2rJqQRV/9PlOrx9ODPr4zGhf0OxFpmRSIuCyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WzlaNYkzT0l7Is+SuEW55CtNoxHZ+HWrARjduQKRvfoIfX7S/MQsUzh9MwTmrJjtm
	 a/2q1jqvYfCWpkzLfVRFYWscCaHmCZgsNY9t+g6snhcWlI8ORxB1IlWhYusv9WtYoB
	 jjU+mmWlAzUJgKminFpymCRqPWRrYjMdh1TRZ7eA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgKFSaS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:30:18 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:38178 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgKFSaS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:30:18 -0500
Received: by mail-ej1-f66.google.com with SMTP id za3so3262758ejb.5;
        Fri, 06 Nov 2020 10:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HBwnRJAwBgSO7RnER97hOPywzds5kKgLbwT3heQfB54=;
        b=pRUlhocN/9QXRR+MwVB2erpSli1np6Ke9JFl/J08iF9XuNBUAVb1hsB5O+oSOldxkg
         pz858TWyYJ2/zoSj6GlbFpnzXL68Iz8udNFPCWgPBWeCtmnlki9zSNjPk2GgGGxUnkCL
         icNSrRse9Jrtry5z18SZeA4JPi8S593teMlIvpVI2VKQKH9/exJyuy11eY7bnQEN5pV7
         Q2eTysp7c0s8zOeavPZzPH7zX4Vfldhy6/M8WCjHu4USW5s5jNrlHWGW5tot6MYfZmGH
         4IIS6bzGsibJXDslglF8/1XnwSNosgnSWVf4gyorA4uMrLqfMJjFEP5JRtoViTT6Froh
         kSvQ==
X-Gm-Message-State: AOAM532JlE4i73GYLqK50ZJZI38Bk1BUwVfMQC/iJOHXF57PrBoqgIsG
        P94Rd72/OLqZCWi7t6ctxLc=
X-Google-Smtp-Source: ABdhPJwWgQOr4L+1v8Kqs30glduzQppkT27qtp6w9QSMRlqfDwHixdijnPXdR1P1E4UtW3MJyuNI0Q==
X-Received: by 2002:a17:906:1e08:: with SMTP id g8mr3293305ejj.358.1604687416196;
        Fri, 06 Nov 2020 10:30:16 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 11sm1463580ejy.19.2020.11.06.10.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:30:15 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:30:13 +0100
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
Subject: Re: [PATCH v7 06/47] dt-bindings: memory: tegra20: mc: Document new
 interconnect property
Message-ID: <20201106183013.GF65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-7-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:42PM +0300, Dmitry Osipenko wrote:
> Memory controller is interconnected with memory clients and with the
> External Memory Controller. Document new interconnect property which
> turns memory controller into interconnect provider.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-mc.txt          | 3 +++

Thanks, applied.

Best regards,
Krzysztof

