From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] thermal: exynos: fix register read in TMU
Date: Thu, 1 Oct 2015 19:42:43 +0530
Message-ID: <20151001141243.GA5061@sudip-pc>
References: <1443699599-9693-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAJKOXPfyC8etcPe373q6Pc1qWb2zVnHE96V+Rh5mPmpzAxFjiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36833 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbbJAOMy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 10:12:54 -0400
Content-Disposition: inline
In-Reply-To: <CAJKOXPfyC8etcPe373q6Pc1qWb2zVnHE96V+Rh5mPmpzAxFjiA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Oct 01, 2015 at 10:18:57PM +0900, Krzysztof Kozlowski wrote:
> 2015-10-01 20:39 GMT+09:00 Sudip Mukherjee <sudipm.mukherjee@gmail.com>:
> > The value of emul_con was getting overwritten if the selected soc is
> > SOC_ARCH_EXYNOS5260. And so as a result we were reading from the wrong
> > register in the case of SOC_ARCH_EXYNOS5260.
> 
> How the value is overwritten if the soc is Exynos5260? I can't see it
> (although the "else if" is still more obvious than "if" but how does
> the description match the code?).
The code here is:
if (data->soc == SOC_ARCH_EXYNOS5260)
	emul_con = EXYNOS5260_EMUL_CON;
if (data->soc == SOC_ARCH_EXYNOS5433)
	emul_con = EXYNOS5433_TMU_EMUL_CON;
else if (data->soc == SOC_ARCH_EXYNOS7)
	emul_con = EXYNOS7_TMU_REG_EMUL_CON;
else
	emul_con = EXYNOS_EMUL_CON;

So if data->soc is SOC_ARCH_EXYNOS5260 , then emul_con becomes
EXYNOS5260_EMUL_CON. But again for the else part it will become
EXYNOS_EMUL_CON.

regards
sudip
