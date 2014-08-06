From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 0/2] Convert exynos PPMU driver to be built as module
Date: Wed, 06 Aug 2014 14:41:26 +0100
Message-ID: <9hhvbq54tx5.fsf@arm.com>
References: <1405692594-19352-1-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:51596 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752897AbaHFNl7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Aug 2014 09:41:59 -0400
In-Reply-To: <1405692594-19352-1-git-send-email-punit.agrawal@arm.com> (Punit
	Agrawal's message of "Fri, 18 Jul 2014 15:09:52 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, orjan.eide@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Punit Agrawal <punit.agrawal@arm.com> writes:

> Hi,
>
> There's no reason why the exynos PPMU can't be built as a module
> except you need -
>
> - The first patch exports the functions that are needed to build
> devfreq drivers as modules.
>
> - The second patch then converts the exynos PPMU devfreq driver to be
>   built as a module.
>

Ping!

> Compile tested only.
>
> Thanks
>
> Punit Agrawal (1):
>   PM / devfreq: exynos: Enable building exynos PPMU as module
>
> =C3=98rjan Eide (1):
>   PM / devfreq: Export helper functions for drivers
>
>  drivers/devfreq/Kconfig              |    2 +-
>  drivers/devfreq/devfreq.c            |    3 +++
>  drivers/devfreq/exynos/exynos_ppmu.c |    3 +++
>  3 files changed, 7 insertions(+), 1 deletion(-)
