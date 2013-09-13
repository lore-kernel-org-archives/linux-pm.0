From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2] drivers: cpuidle: rename ARM big.LITTLE driver config and makefile entries
Date: Fri, 13 Sep 2013 14:16:06 -0700
Message-ID: <878uz0e82x.fsf@linaro.org>
References: <1379086721-5242-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:42797 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406Ab3IMVQJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 17:16:09 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so1727562pbc.37
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 14:16:09 -0700 (PDT)
In-Reply-To: <1379086721-5242-1-git-send-email-lorenzo.pieralisi@arm.com>
	(Lorenzo Pieralisi's message of "Fri, 13 Sep 2013 16:38:41 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

Daniel,

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> Following the reorganization of CPU idle drivers configurations into an ARM
> specific Kconfig, the existing idle drivers Kconfig entries were renamed and
> moved to the Kconfig.arm file. Makefile entries were updated accordingly.
>
> This patch renames the entries in Kconfig.arm and makefile to make the newly
> added big.LITTLE CPUidle driver compliant with the new naming convention.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Kevin Hilman <khilman@linaro.org>

We picked up this driver originally through arm-soc (with your signoff)
because of arch/arm dependencies, but you might as well take this one
directly since it's isolated to drivers/cpuidle.

Can you queue this up for v3.12-rc please?

Thanks,

Kevin
