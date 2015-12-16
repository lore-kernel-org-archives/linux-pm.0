From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 1/2] ARM: cpuidle: remove cpu parameter from the
 cpuidle_ops suspend hook
Date: Wed, 16 Dec 2015 21:58:09 +0100
Message-ID: <5671D061.6060008@linaro.org>
References: <1445011379-8787-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1445011379-8787-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33659 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934216AbbLPU6I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 15:58:08 -0500
Received: by mail-wm0-f53.google.com with SMTP id p187so19066767wmp.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2015 12:58:06 -0800 (PST)
In-Reply-To: <1445011379-8787-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lina Iyer <lina.iyer@linaro.org>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Jisheng Zhang <jszhang@marvell.com>

On 10/16/2015 06:02 PM, Lorenzo Pieralisi wrote:
> The suspend() hook in the cpuidle_ops struct is always called on
> the cpu entering idle, which means that the cpu parameter passed
> to the suspend hook always corresponds to the local cpu, making
> it somewhat redundant.
>
> This patch removes the logical cpu parameter from the ARM
> cpuidle_ops.suspend hook and updates all the existing kernel
> implementations to reflect this change.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Lina Iyer <lina.iyer@linaro.org>
> Tested-by: Lina Iyer <lina.iyer@linaro.org>
> Tested-by: Jisheng Zhang <jszhang@marvell.com> [psci]
> Cc: Lina Iyer <lina.iyer@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

