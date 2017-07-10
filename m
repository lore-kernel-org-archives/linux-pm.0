From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: cpufreq: move MediaTek cpufreq
 dt-bindings document to proper place
Date: Mon, 10 Jul 2017 09:58:52 -0500
Message-ID: <20170710145852.pwbpfrv2cyihy5kj@rob-hp-laptop>
References: <cover.1499399121.git.sean.wang@mediatek.com>
 <77ada8e9c184b4a58463bfe0f2c8b0ef149d2845.1499399121.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34612 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753309AbdGJO6z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 10:58:55 -0400
Content-Disposition: inline
In-Reply-To: <77ada8e9c184b4a58463bfe0f2c8b0ef149d2845.1499399121.git.sean.wang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sean.wang@mediatek.com
Cc: viresh.kumar@linaro.org, matthias.bgg@gmail.com, mark.rutland@arm.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Jul 07, 2017 at 11:56:46AM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> The old place is Documentation/devicetree/bindings/clock/ that would
> let people hard to find how to use MediaTek cpufreq driver, so moving
> it to the appropriate place as other cpufreq drivers done would be
> better.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../bindings/{clock/mt8173-cpu-dvfs.txt => cpufreq/cpufreq-mediatek.txt}  | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{clock/mt8173-cpu-dvfs.txt => cpufreq/cpufreq-mediatek.txt} (100%)

Acked-by: Rob Herring <robh@kernel.org>
