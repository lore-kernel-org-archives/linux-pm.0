From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] devfreq_cooling: pass a pointer to devfreq in the power model callbacks
Date: Mon, 21 Dec 2015 11:37:39 +0000
Message-ID: <874mfc3ud8.fsf@e105922-lin.cambridge.arm.com>
References: <1449240274-17544-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:53324 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751081AbbLULht (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2015 06:37:49 -0500
In-Reply-To: <1449240274-17544-1-git-send-email-javi.merino@arm.com> (Javi
	Merino's message of "Fri, 4 Dec 2015 14:44:34 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Javi Merino <javi.merino@arm.com> writes:

> It's useful for a driver to know which device it's referring to when
> calculating its dynamic or static power.  Pass a pointer to devfreq
> in the callbacks to let the driver know which device it refers to.
>
> This is similar to what we do for the cpu cooling device power model.
> For that, we pass a cpumask of the affected cpus.
>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>  drivers/thermal/devfreq_cooling.c | 5 +++--
>  include/linux/devfreq_cooling.h   | 6 ++++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
>

Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>

Thanks!
