From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: thermal: imx: update the binding to new
 method
Date: Mon, 12 Feb 2018 08:40:28 -0600
Message-ID: <20180212144028.al7thpjxvefnfyze@rob-hp-laptop>
References: <1516862269-25543-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:35397 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933843AbeBLOka (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Feb 2018 09:40:30 -0500
Content-Disposition: inline
In-Reply-To: <1516862269-25543-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, Shawn Guo <shawn.guo@linaro.org>, Leonard Crestez <leonard.crestez@nxp.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>

On Thu, Jan 25, 2018 at 02:37:49PM +0800, Dong Aisheng wrote:
> Due to the old method has already been marked as deprecated in binding
> doc, so obviously it's better to update the example to new bindings
> as well.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  .../devicetree/bindings/thermal/imx-thermal.txt    | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Applied, thanks.

Rob
