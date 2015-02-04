From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 2/6] extcon: max77843: Add max77843 MUIC driver
Date: Thu, 05 Feb 2015 08:46:37 +0900
Message-ID: <54D2AF5D.8080700@samsung.com>
References: <1423025771-4139-1-git-send-email-jaewon02.kim@samsung.com>
 <1423025771-4139-3-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:27399 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbbBDXqk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 18:46:40 -0500
In-reply-to: <1423025771-4139-3-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Beomho Seo <beomho.seo@samsung.com>

Hi Jaewon,

On 02/04/2015 01:56 PM, Jaewon Kim wrote:
> This patch adds MAX77843 extcon driver to support for MUIC(Micro
> USB Interface Controller) device by using EXTCON subsystem to handle
> various external connectors.
> 
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Acked-by : Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/extcon/Kconfig           |   10 +
>  drivers/extcon/Makefile          |    1 +
>  drivers/extcon/extcon-max77843.c |  881 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 892 insertions(+)
>  create mode 100644 drivers/extcon/extcon-max77843.c

Applied it. Thanks.

Thanks,
Chanwoo Choi
