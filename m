Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3694DC433B4
	for <linux-pm@archiver.kernel.org>; Wed, 21 Apr 2021 21:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1624E61435
	for <linux-pm@archiver.kernel.org>; Wed, 21 Apr 2021 21:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbhDUVHm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 21 Apr 2021 17:07:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38306 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245746AbhDUVHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 17:07:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 44BEF1F4262B
Message-ID: <31272ad0e6a5274080831406796960506c6a6912.camel@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: rockchip-thermal: Support the RK3568
 SoC compatible
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Johan Jonker <jbx6244@gmail.com>, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com
Date:   Wed, 21 Apr 2021 18:06:59 -0300
In-Reply-To: <557ae27c-1d62-69e0-7ae6-921571059f9f@gmail.com>
References: <20210421200445.32977-1-ezequiel@collabora.com>
         <557ae27c-1d62-69e0-7ae6-921571059f9f@gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2021-04-21 at 22:46 +0200, Johan Jonker wrote:
> On 4/21/21 10:04 PM, Ezequiel Garcia wrote:
> > Add a new compatible for the thermal sensor device on RK3568 SoCs.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > index 7f94669e9ebe..346e466c2006 100644
> > --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > @@ -9,6 +9,7 @@ Required properties:
> >     "rockchip,rk3328-tsadc": found on RK3328 SoCs
> >     "rockchip,rk3368-tsadc": found on RK3368 SoCs
> >     "rockchip,rk3399-tsadc": found on RK3399 SoCs
> 
> > +   "rockchip,rk3568-tsadc": found on RK3568 SoCs
> 
> This is still a text document.
> rob+dt has now scripts that check for undocumented compatibility
> strings, so first convert rockchip-thermal.txt to YAML and then add this
> in a separated patch.
> 

Is it a showstopper to convert devicetree bindings to YAML for driver submission?

Thanks,
Ezequiel

