From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4 3/8] ARM i.MX6q: Add GPU, VPU, IPU, and OpenVG resets
 to System Reset Controller (SRC)
Date: Fri, 01 Mar 2013 13:05:38 -0700
Message-ID: <51310A12.1040209@wwwdotorg.org>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de> <1361878774-6382-4-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45111 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab3CAUFn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Mar 2013 15:05:43 -0500
In-Reply-To: <1361878774-6382-4-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On 02/26/2013 04:39 AM, Philipp Zabel wrote:
> The SRC has auto-deasserting reset bits that control reset lines to
> the GPU, VPU, IPU, and OpenVG IP modules. This patch adds a reset
> controller that can be controlled by those devices using the
> reset controller API.

> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx-src.txt

> +Specifying reset lines connected to IP modules
> +==============================================
...
> +example:
> +
> +        ipu1: ipu@02400000 {
> +                resets = <&src 2>;
> +        };
> +        ipu2: ipu@02800000 {
> +                resets = <&src 4>;
> +        };

reset-names is mandatory in the documentation and implementation; you
should probably add them to the example too.

Nit: You could use BIT(x) instead of 1 << x in a few places in this
file. But not a big deal.
