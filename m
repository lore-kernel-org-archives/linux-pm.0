From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: cpufreq: enhance MediaTek cpufreq
 dt-binding document
Date: Mon, 10 Jul 2017 10:02:38 -0500
Message-ID: <20170710150238.aie46rtl4anadofg@rob-hp-laptop>
References: <cover.1499399121.git.sean.wang@mediatek.com>
 <74cfd6007e87f0fcca401b31be17dbf98808d001.1499399121.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36816 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753646AbdGJPCl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 11:02:41 -0400
Content-Disposition: inline
In-Reply-To: <74cfd6007e87f0fcca401b31be17dbf98808d001.1499399121.git.sean.wang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sean.wang@mediatek.com
Cc: viresh.kumar@linaro.org, matthias.bgg@gmail.com, mark.rutland@arm.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Jul 07, 2017 at 11:56:47AM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Update binding document with adding operating-points-v2 as the required
> property and the cooling level as the optional properties and adding more
> examples guiding people how to use MediaTek cpufreq driver for MediaTek
> SoCs.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek.txt          | 170 ++++++++++++++++++++-
>  1 file changed, 167 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
