Return-Path: <SRS0=0y+j=5Q=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2D3C2D0EE
	for <linux-pm@archiver.kernel.org>; Tue, 31 Mar 2020 21:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F1F20CC7
	for <linux-pm@archiver.kernel.org>; Tue, 31 Mar 2020 21:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585688959;
	bh=NdWtnVNuVKjRGrLPm6X0u7WmrqQJGhb7w716gUg//+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RN2rBK+WdjWy4sLj53FeBABcVgD6oEGuND3/gddC97382vyRUjrH8n03FT9y47TRG
	 3l3qO7EZwtG0DtCV2Ty4ChOSpVZXz4aaAxjCgy9F78Qt43HpZvK7tACv2TyYB3fiMY
	 ACRATu1MWya3Y7AZPn17TphjGhxhlm4rduLx5dig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgCaVJS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:09:18 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33280 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgCaVJS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 17:09:18 -0400
Received: by mail-il1-f195.google.com with SMTP id k29so20890911ilg.0;
        Tue, 31 Mar 2020 14:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dMI5qNBG9wYA/uO+xFulRySfzKd9D1BIRG62nnFsQ0=;
        b=tvTH2TLi5sMctT7qyg2kK9JiuuCa4x5hcGvAFuZb4LFu8pqyRigPwZCZ6Vq+GG7Mdp
         K4vUbtXdkz5W5obq4TexW6ADF/c4xR/goq2CA6VoVVd8r8kmSmS/WXTYr3p+QR7qoCSq
         sMMHHNcvPhC4VcCKRwup9YVNe6qIAz/ANfgCQEMuH2Wdgpyfwm0m2zrKX+1anCjyta7J
         WGTDwSlzAtJlHzFUG9MrIVwFgGcVS1xGfhL9wsEJT/9cX9kh3mgbwJK9qbNDEWinGdZJ
         +raDVhY51hQsYDKrnD0a1kKk2WXOfnmrNS9NxEULHTFI0IL9tz4qK0V5mb0S5BKCqUej
         2pGw==
X-Gm-Message-State: ANhLgQ1EAX69f4DQSv666mYeODn17RRf8d3C7JBcfv8071zGudq039uW
        LYmnEP8T0+aEXzWv0T8ibw==
X-Google-Smtp-Source: ADFU+vubcd/9iBv3ykYCRlk0xEqc8HAfpunt9LuVdZGOZjb6sPLjzSyQ5YOuumeephzAg4UYoR2WIQ==
X-Received: by 2002:a92:5bd7:: with SMTP id c84mr18826606ilg.26.1585688957267;
        Tue, 31 Mar 2020 14:09:17 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t5sm12956iom.3.2020.03.31.14.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:09:16 -0700 (PDT)
Received: (nullmailer pid 14501 invoked by uid 1000);
        Tue, 31 Mar 2020 21:09:15 -0000
Date:   Tue, 31 Mar 2020 15:09:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: tsens: Fix nvmem-cell-names
 schema
Message-ID: <20200331210915.GA12554@bogus>
References: <20200324180513.3882-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324180513.3882-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 24 Mar 2020 12:05:12 -0600, Rob Herring wrote:
> There's a typo 'nvmem-cells-names' in the schema which means the correct
> 'nvmem-cell-names' in the examples are not checked. The possible values
> are wrong too both in that the 2nd entry is not specified correctly and the
> values are just wrong based on the dts files in the kernel.
> 
> Fixes: a877e768f655 ("dt-bindings: thermal: tsens: Convert over to a yaml schema")
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.yaml          | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 

Applied, thanks.

Rob
