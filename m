From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 2/6] extcon: max77843: Add max77843 MUIC driver
Date: Wed, 04 Feb 2015 08:41:54 +0900
Message-ID: <54D15CC2.3010605@samsung.com>
References: <1422939846-29955-1-git-send-email-jaewon02.kim@samsung.com>
 <1422939846-29955-3-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1422939846-29955-3-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Beomho Seo <beomho.seo@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Jaewon,

On 02/03/2015 02:04 PM, Jaewon Kim wrote:
> This patch adds MAX77843 extcon driver to support for MUIC(Micro
> USB Interface Controller) device by using EXTCON subsystem to handle
> various external connectors.
> 
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/extcon/Kconfig           |   10 +
>  drivers/extcon/Makefile          |    1 +
>  drivers/extcon/extcon-max77843.c |  881 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 892 insertions(+)
>  create mode 100644 drivers/extcon/extcon-max77843.c
[snip]

This patch looks good to me. 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
