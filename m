Return-Path: <SRS0=cFiq=5F=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC49C4332B
	for <linux-pm@archiver.kernel.org>; Fri, 20 Mar 2020 23:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A31920739
	for <linux-pm@archiver.kernel.org>; Fri, 20 Mar 2020 23:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584745774;
	bh=OjsxF1LdD1nvuzC9Rnbc3oDYh5n5+vXsU4+XqcJAGZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FKRYcsGdk+ADC5KKk1cwzjZ+s3wbWp0NyGnNQypLUA3rwYroVRsWEidVDP6Pq5los
	 a1gzPIOp30Wh5zR+zHAABe79Nk/YeWTti8IQ9P3KsBDD+1AcfQ7MGN25sHYvivm7ZO
	 Hqj4ECeI1qbHP9Aknw+fisTIrHkCzwIriSKpHfvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCTXJd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:09:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45626 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCTXJd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 19:09:33 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so7359335ios.12;
        Fri, 20 Mar 2020 16:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zI/A5t6sz0HZZha9rW07DEcIwNV0BjOpWxSE/SxyAvE=;
        b=pyctteacxTNKQLqO0H1vXCpiwIBS9RlGwV9A272SYtBtLacrayjMhfCEYFhz5qeI7U
         WDBl1oLP+2wNRvDzuKpYhc12bUvOlINmA4gX/2xdEcUYkPGXlykaGs97JpD2YFPr2Byh
         /XWXN5BshbzCuOnBH0QPY/afHBCAbWSDY3xWNoe9FsBy8Zjnzk3K9f3xyyR6rfgjIxzG
         GoCsaUggZI5QEpcnU1Jd96B4ma4Scn8ff1qI/JteYd09URlyTvBVQsmXSPHhOzvqZnIj
         j/SPWke8SjK5mNFGJCJv6Bw2fx9vroQiURD6MXKC5BPebGBBqfQaMXUsbw6Gcpo57Qqg
         VoTA==
X-Gm-Message-State: ANhLgQ1LdtptLkzSuEYXLsi820wbibIyebDOUhoQqd9wFqW2A/VP7r91
        FSfvMVrLuqeOqJVXqNJ4Aw==
X-Google-Smtp-Source: ADFU+vu8yuQGmtMjuXxAe3eJym4ITk7sMDRSQjp8IwrmCn4xXCWAQBhmn9VQa6+RdyyyGEdTKHltrg==
X-Received: by 2002:a5d:8cd3:: with SMTP id k19mr10026199iot.123.1584745772527;
        Fri, 20 Mar 2020 16:09:32 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g69sm1604552ile.3.2020.03.20.16.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 16:09:31 -0700 (PDT)
Received: (nullmailer pid 14611 invoked by uid 1000);
        Fri, 20 Mar 2020 23:09:30 -0000
Date:   Fri, 20 Mar 2020 17:09:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Subject: Re: [PATCH V4 08/13] dt-bindings: interconnect: add MT8183
 interconnect dt-bindings
Message-ID: <20200320230930.GA10504@bogus>
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
 <1584092066-24425-9-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584092066-24425-9-git-send-email-henryc.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 13, 2020 at 05:34:21PM +0800, Henry Chen wrote:
> Add interconnect provider dt-bindings for MT8183.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/dvfsrc.txt        |  9 +++++++++
>  include/dt-bindings/interconnect/mtk,mt8183-emi.h      | 18 ++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/mtk,mt8183-emi.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> index 7f43499..da98ec9 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> @@ -12,6 +12,11 @@ Required Properties:
>  - clock-names: Must include the following entries:
>  	"dvfsrc": DVFSRC module clock
>  - clocks: Must contain an entry for each entry in clock-names.
> +- #interconnect-cells : should contain 1
> +- interconnect : interconnect providers support dram bandwidth requirements.
> +	The provider is able to communicate with the DVFSRC and send the dram
> +	bandwidth to it. shall contain only one of the following:
> +	"mediatek,mt8183-emi"
>  
>  Example:
>  
> @@ -20,4 +25,8 @@ Example:
>  		reg = <0 0x10012000 0 0x1000>;
>  		clocks = <&infracfg CLK_INFRA_DVFSRC>;
>  		clock-names = "dvfsrc";
> +		ddr_emi: interconnect {
> +			compatible = "mediatek,mt8183-emi";
> +			#interconnect-cells = <1>;

Nodes with a compatible and no defined way to access the hardware always 
look suspicious. Can't you make the parent node an interconnect 
provider.

Rob
