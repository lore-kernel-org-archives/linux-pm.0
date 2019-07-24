Return-Path: <SRS0=dCrN=VV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB68C7618B
	for <linux-pm@archiver.kernel.org>; Wed, 24 Jul 2019 14:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B272070D
	for <linux-pm@archiver.kernel.org>; Wed, 24 Jul 2019 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563980187;
	bh=OxXMwMrcLDY77gt4u/+s8XUR9YdokR3x8GzdU5X809w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T9JXTfaU7GkTjOws1WuHCnMjsYT06mJ8G8tsNrcO12JMPWHzGFszuXJd3QjTkLwDa
	 x6e2SpZFfEM9gkSWE4eZM+V2xE6y35IZdpK65GdZ4NX4KnvML2g5KZBLX6kFru6dti
	 rZWLCtSyEXZBIpGXp0FKodYAGfOWVsiSaYukzdXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfGXO40 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:56:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36121 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfGXO40 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 10:56:26 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so90287382iom.3;
        Wed, 24 Jul 2019 07:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3aE+MjGXqdyag2TVbnV9FXwm+spP+OBGssJslmm561I=;
        b=SMW4Rl8PzGJkM9gZS7wjL6tkB3SPBP4IcjkeqB+WX5CoPzXTDhmEjH7wu8Mzjux0R2
         hR1NPnjhWWjBBuRThP09CMA0nZ4A8D/IbXjbYhXUUhM2oWKFR/3CP7RSjKRwujqbLwJW
         +bGvz8s+KJ5/MQDJyFKVpx36ekdeQvTLn52p8myJmz9lQedPhevpde7rxMDgs3CcPMfG
         sGrHvBhPixUwWAkdZ2ObkTRwcDKe9p+WQ0ULiHTAC0HIye+Lq1OR8QEMZzu/b+y7ELa8
         pwuhWYOCh+3HS7sJNB6DhSAJiI/BF/Q17k7qDfjT0J2PMs0Wi5fJSN5VWnI/l2C1caQM
         Ddsg==
X-Gm-Message-State: APjAAAUGmbp5s+aVk7MJuyA7wJuUcNkNWbHugLVWFFqy28yWUTxlf+G1
        o78RuAnobnXXFTGvlaIdhA==
X-Google-Smtp-Source: APXvYqxlveMV1sSzvivUTiDzl1Jd26ULb0CfbzN67a2r/0tk3STwV2602H4eUdIB7uxdvnryu0y5iw==
X-Received: by 2002:a02:300b:: with SMTP id q11mr87478803jaq.54.1563980185089;
        Wed, 24 Jul 2019 07:56:25 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id s15sm36464486ioe.88.2019.07.24.07.56.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 07:56:24 -0700 (PDT)
Date:   Wed, 24 Jul 2019 08:56:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] dt-bindings: cpufreq: qcom-nvmem: Make speedbin
 related properties optional
Message-ID: <20190724145623.GA9855@bogus>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-4-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705095726.21433-4-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri,  5 Jul 2019 11:57:14 +0200, Niklas Cassel wrote:
> Not all Qualcomm platforms need to care about the speedbin efuse,
> nor the value blown into the speedbin efuse.
> Therefore, make the nvmem-cells and opp-supported-hw properties
> optional.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
