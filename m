From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Remove unused member name of cpudata
Date: Wed, 21 May 2014 10:05:55 +0530
Message-ID: <CAKohpo=MtRn_hb2WK0kRK3wJHt7_JrQvz=GRR4RpKZ_GJVOiGg@mail.gmail.com>
References: <537B9B0B.1020404@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:39829 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbaEUEf4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 00:35:56 -0400
Received: by mail-ob0-f180.google.com with SMTP id va2so1583592obc.11
        for <linux-pm@vger.kernel.org>; Tue, 20 May 2014 21:35:55 -0700 (PDT)
In-Reply-To: <537B9B0B.1020404@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org >> LKML" <linux-kernel@vger.kernel.org>

On 20 May 2014 23:42, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> Although, a value is assigned to member name of struct cpudata,
> it is never used.
>
> We can safely remove it.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/intel_pstate.c | 4 ----
>  1 file changed, 4 deletions(-)

Looks fine to me atleast, lets see what Dirk will say :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
