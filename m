Return-Path: <SRS0=Zmrs=5I=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC1C3F2CD
	for <linux-pm@archiver.kernel.org>; Mon, 23 Mar 2020 19:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20A120780
	for <linux-pm@archiver.kernel.org>; Mon, 23 Mar 2020 19:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584993401;
	bh=NQaRm7h02AQ+1aFMatSyKbSNGnAj6l0t76/7oFmkOUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OsYhVq+9mu7eR8yMMo2OlpAWS22NuSU2yK9tsg7mrDctPUp2s80rwms9uR5CBwbyf
	 8epQc6AADBhkPPGe9wN9rFcZoC5hXjqv6PQmamOE9ic5fFQRgvMqTvwpwtsGFxdTnZ
	 UVOXrAKP1qJFJNYizzW1z+HuOYBZlitMCmDQo4u4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgCWT4l (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:56:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46885 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCWT4l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 15:56:41 -0400
Received: by mail-io1-f67.google.com with SMTP id a20so8418031ioo.13;
        Mon, 23 Mar 2020 12:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qXevwrfc2p5AdDU33jwvkxHfjutpsoW73v5+sjJRTb0=;
        b=j0ryfBGG7XuNoBOau6gEB1+gtV/03celkDK6vHlIDjjPB5DbbDUlMuxEkBxSJrX9Us
         RJpj06biB0MVgQxAR+noDYIHFAxke+1eHNOizifI7/9WwRwYY20RR0b2tfRKszNbuQh0
         sc1GdAoDTBpJ8g1zHjHK899fvLjZ6DW+UcDlfn7XyW2AGAuEXKYDXVPbs/mU0rWS/on7
         s0atcTxorreDTii7KHIQnsZAYdsNGaPL4vjX5KmJefA02o/Xzsvh4pwgwABP82zBu8Iv
         uqxtHBa2Udh58n3ejK90AJOW3NqCH6y+XjoT9unXxHgSEIeh1oV3rym/EujAHbGgmIZf
         /6CA==
X-Gm-Message-State: ANhLgQ1cLfECVfTPIZBDrknloZy5jCoZnlT4bFMM++wxD8AxLsWVNzsV
        JlJM0CPzRYG/xNOf3g8WJA==
X-Google-Smtp-Source: ADFU+vtLwq6QT60pJAfxzLxrg6bcvqD+KMyEIEHEsy8Q+CFNUhFt660np21tKveAFvaUbUdZlOgs9g==
X-Received: by 2002:a5d:9301:: with SMTP id l1mr20763884ion.68.1584993399925;
        Mon, 23 Mar 2020 12:56:39 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p14sm4584248ios.38.2020.03.23.12.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:56:39 -0700 (PDT)
Received: (nullmailer pid 8120 invoked by uid 1000);
        Mon, 23 Mar 2020 19:56:38 -0000
Date:   Mon, 23 Mar 2020 13:56:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     andy.tang@nxp.com
Cc:     daniel.lezcano@linaro.org, edubezval@gmail.com,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuantian Tang <andy.tang@nxp.com>
Subject: Re: [PATCH] dt-bindings: thermal: make cooling-maps property optional
Message-ID: <20200323195638.GA8059@bogus>
References: <20200309045411.21859-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309045411.21859-1-andy.tang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon,  9 Mar 2020 12:54:11 +0800, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> Cooling-maps doesn't have to be a required property because there may
> be no cooling device on system, or there are no enough cooling devices for
> each thermal zone in multiple thermal zone cases since cooling devices
> can't be shared.
> So make this property optional to remove such limitations.
> 
> For thermal zones with no cooling-maps, there could be critic trips
> that can trigger CPU reset or shutdown. So they still can take actions.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
