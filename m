Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C53BC433FE
	for <linux-pm@archiver.kernel.org>; Mon, 18 Apr 2022 01:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiDRBsu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 17 Apr 2022 21:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiDRBsr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Apr 2022 21:48:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0925218391;
        Sun, 17 Apr 2022 18:46:09 -0700 (PDT)
X-UUID: d68495b8f1f4433097644694d028bf1c-20220418
X-UUID: d68495b8f1f4433097644694d028bf1c-20220418
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 775895775; Mon, 18 Apr 2022 09:46:05 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 18 Apr 2022 09:46:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Apr
 2022 09:46:03 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Apr 2022 09:46:03 +0800
Message-ID: <f4ce1101bb536e7314f23790675437ad77aff97e.camel@mediatek.com>
Subject: Re: [PATCH V3 13/15] arm64: dts: mediatek: Add opp table and clock
 property for MT8183 cpufreq
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <jia-wei.chang@mediatek.com>, <roger.lu@mediatek.com>,
        <hsinyi@google.com>, <khilman@baylibre.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Date:   Mon, 18 Apr 2022 09:46:03 +0800
In-Reply-To: <a1ae5616-48b8-054b-aad3-a9569eed20e1@collabora.com>
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
         <20220415055916.28350-14-rex-bc.chen@mediatek.com>
         <a1ae5616-48b8-054b-aad3-a9569eed20e1@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2022-04-15 at 14:24 +0200, AngeloGioacchino Del Regno wrote:
> Il 15/04/22 07:59, Rex-BC Chen ha scritto:
> > - Add cpufreq opp table.
> > - Add MediaTek cci opp table.
> > - Add property of opp table and clock fro cpufreq.
> > 
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  32 +++
> >   arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 270
> > ++++++++++++++++++++
> >   2 files changed, 302 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > index f3fd3cca23e9..8953dbf84f3e 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> 
> ..snip..
> 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 4b08691ed39e..4ae3305d16d2 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -42,6 +42,244 @@
> >   		rdma1 = &rdma1;
> >   	};
> >   
> > +	cluster0_opp: cluster_opp_table0 {
> 
> Please don't use underscores in devicetree for anything that's not a
> phandle.
> 
> 	cluster0_opp: cluster0-opp-table {
> 
> > +		compatible = "operating-points-v2";
> > +		opp-shared;
> > +		opp0_00 {
> 
> Apart from the underscore being invalid, across the kernel, you can
> find many
> instances of opp tables, containing names related to the frequencies,
> so, for
> consistency (this is not a rule!), perhaps it would be a good idea to
> do so.
> 
> 		opp-793000000 {
> 
> > +			opp-hz = /bits/ 64 <793000000>;
> > +			opp-microvolt = <650000>;
> > +			required-opps = <&opp2_00>;
> > +		};
> > +		opp0_01 {
> 
> 		opp-910000000 {
> 
> > +			opp-hz = /bits/ 64 <910000000>;
> > +			opp-microvolt = <687500>;
> > +			required-opps = <&opp2_01>;
> > +		};
> > +		opp0_02 {
> 
> ..snip..
> 
> > +		opp0_15 {
> > +			opp-hz = /bits/ 64 <1989000000>;
> > +			opp-microvolt = <1050000>;
> > +			required-opps = <&opp2_15>;
> 
> P.S.: Please fix the typo below!
> 
> > +		};	};
> > +
> > +
> 
> ...also...
> 
> > +	cci_opp: opp_table2 {
> 
> 	cci_opp: cci-opp-table {
> 
> > +		compatible = "operating-points-v2";
> > +		opp-shared;
> > +		opp2_00: opp-273000000 {
> 
> This one is fine instead :))
> 
> Cheers,
> Angelo

Hello Angelo,

OK, I will modify this issue in next version.
Thanks!

BRs,
Rex

