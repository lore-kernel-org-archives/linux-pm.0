From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 0/3] thermal: exynos: Fixes for vtmu-supply regulator
 handling
Date: Tue, 8 Mar 2016 10:30:33 -0300
Message-ID: <56DED3F9.8050505@osg.samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:37013 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbcCHNao (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Mar 2016 08:30:44 -0500
In-Reply-To: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-samsung-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>

Hello Lukasz, Eduardo,

On 02/18/2016 03:19 PM, Javier Martinez Canillas wrote:
> Hello,
> 
> On a recent patch series to build a PMIC chip as a module [0], Krzysztof
> asked me to check if all the consumer drivers, using the resources that
> this PMIC provides, already support probe deferral.
> 
> While investigating that, I noticed that the Exynos TMU didn't do it so
> this series fix that bug and other two minor issues that I noticed while
> reviewing the driver and its DT binding.
> 
> The series are on top of Krzysztof's patches [1,2,3] not because there's
> a dependency but to avoid merge conflicts with in-flight patches. Please
> let me know if you prefer to use a different base instead.
> 
> [0]: https://lkml.org/lkml/2016/2/11/857
> [1]: https://patchwork.kernel.org/patch/8345791/
> [2]: https://patchwork.kernel.org/patch/8345741/
> [3]: https://patchwork.kernel.org/patch/8345701/
> 
> Best regards,
> Javier
> 

Any comments about this series?

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
