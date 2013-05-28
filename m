From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH][V2] cpuidle: simplify multiple driver support
Date: Tue, 28 May 2013 23:08:13 +0200
Message-ID: <51A51CBD.5060301@linaro.org>
References: <1369227904-16234-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:49948 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044Ab3E1VIR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2013 17:08:17 -0400
Received: by mail-wg0-f43.google.com with SMTP id x12so3566890wgg.10
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2013 14:08:16 -0700 (PDT)
In-Reply-To: <1369227904-16234-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Francesco Lavra <francescolavra.fl@gmail.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>

On 05/22/2013 03:05 PM, Daniel Lezcano wrote:
> Commit bf4d1b5ddb78f86078ac6ae0415802d5f0c68f92 brought the multiple =
driver
> support. The code added a couple of new API to register the driver pe=
r cpu.
> That led to some code complexity to handle the kernel config options =
when
> the multiple driver support is enabled or not, which is not really ne=
cessary.
> The code has to be compatible when the multiple driver support is not=
 enabled,
> and the multiple driver support has to be compatible with the old api=
=2E
>
> This patch removes this API, which is not yet used by any driver but =
needed
> for the HMP cpuidle drivers which will come soon, and replaces its us=
age
> by a cpumask pointer in the cpuidle driver structure telling what cpu=
s are
> handled by the driver. That let the API cpuidle_[un]register_driver t=
o be used
> for the multipled driver support and also the cpuidle_[un]register fu=
nctions,
> added recently in the cpuidle framework.
>
> The current code, a bit poor in comments, has been commented and simp=
lified.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>
> [V2]:
>  - fixed bad refcount check
>  - inverted clockevent notify off order at unregister time

Hi Rafael,

could you consider this patch for merging ? I took into account
=46rancesco's comments.

Thanks
-- Daniel

-- <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM
SoCs Follow Linaro: <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
