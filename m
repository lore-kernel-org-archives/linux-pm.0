Return-Path: <SRS0=thCJ=B3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45ADC433E1
	for <linux-pm@archiver.kernel.org>; Mon, 17 Aug 2020 11:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7917820674
	for <linux-pm@archiver.kernel.org>; Mon, 17 Aug 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597665281;
	bh=NtSDV9pYFkFiji0DnKWayqlaXE3KNJaPLKjwikpsD1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yQ8TKt099HrBtGU90iU6APKuqkqaz5Gj/9S2cNvS7ZDnpunvlZwzU5gqyKM2Dtlzw
	 kZgpHle2k1Aa5HOW4qOB1S4KJrZEU8vRtxEMRiC7WjlU1u/D3lg4wSBF3zaNTreecL
	 fT+YO+v0162bmdGiFAKkcObsvQAfM1MGjy/+Pviw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgHQLyk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:54:40 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37088 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgHQLyk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 07:54:40 -0400
Received: by mail-ej1-f66.google.com with SMTP id qc22so17377705ejb.4;
        Mon, 17 Aug 2020 04:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gmv/LnTVhDrv4xWlObrgrgJVEX/mNaVJGKXV8qYtozI=;
        b=Ue3v5MDBEdMuiNsbc4OH91xK1LVNqSrguYNy9giH+LGh6ohII25WZ9zLP5ive77Itl
         iU3rV/DOvO4WjVbeztaj5S1mmegdXIG7zbE8LBkgINMj7Sixor5ESgN5+OacOQ6MW/0b
         rkOsc/Gdz9LaFlVGAI50D//UlaaO4ZGYpqk/zBUyFDoye2KBxdke7GHEWYe6QSmJIXLu
         l5sqvAQNAIfC1CH8idUup5gE9p/ZNuH9Vz0OCU0qIPUzKRZ98KPmlt/4yV5l+7Pd+ybj
         oh/6lsHOKTeh+UQoSwlgsyYYR8+a2+gDICOSoX7e5jxrZe0Hg2adjNMNiJD1BaCs7pY0
         l+ig==
X-Gm-Message-State: AOAM531qTCzODtjCkdt6ZGpWXym5c3W73HFA4LpmRFi0LyabdlqO7cxF
        2Cd6vCWk0jJij1M0Cn/eXq8=
X-Google-Smtp-Source: ABdhPJylUYlFzbESSX2S/SjTNBdk/1xQdv9oriQFghbtaaJ60FujFjyCBl8q6FkbYF8v9lJ6dAPjlQ==
X-Received: by 2002:a17:906:3890:: with SMTP id q16mr14249884ejd.107.1597665278339;
        Mon, 17 Aug 2020 04:54:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.242])
        by smtp.googlemail.com with ESMTPSA id v14sm14175860ejb.63.2020.08.17.04.54.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 04:54:37 -0700 (PDT)
Date:   Mon, 17 Aug 2020 13:54:35 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     oss-self-reviewed-patches@listhost.cambridge.arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kgene@kernel.org, b.zolnierkie@samsung.com
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: Additional locking for
 'curr_rate'
Message-ID: <20200817115435.GA2346@kozik-lap>
References: <20200811101727.3976-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200811101727.3976-1-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 11, 2020 at 11:17:27AM +0100, Lukasz Luba wrote:
> The 'curr_rate' is protected by local 'dmc->lock' in various places, but
> not in a function exynos5_dmc_get_status(). The lock protects frequency
> (and voltage) change process and the corresponding value stored in
> 'curr_rate'. Add the locking mechanism to protect the 'curr_rate' reading
> also in the exynos5_dmc_get_status().
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 3 +++

Thanks, applied.

Best regards,
Krzysztof

