From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/6] binding-doc: usb: usb-device: add optional
 properties for power sequence
Date: Fri, 29 Jul 2016 16:11:09 -0500
Message-ID: <20160729211109.GA2788@rob-hp-laptop>
References: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
 <1469007629-31757-4-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33871 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbcG2VLL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2016 17:11:11 -0400
Content-Disposition: inline
In-Reply-To: <1469007629-31757-4-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org

On Wed, Jul 20, 2016 at 05:40:26PM +0800, Peter Chen wrote:
> Add optional properties for power sequence.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-device.txt | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

This probably should be put into a binding doc for the specific hub 
chip, but this is fine for now.

Acked-by: Rob Herring <robh@kernel.org>
