From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 4/4] cpuidle/menu: add per cpu pm_qos_resume_latency consideration
Date: Wed, 14 Sep 2016 10:28:10 +0200
Message-ID: <CAKfTPtDWq1ju2O8TSDGEJh0S_LdPw9CgjnzE5m0P8aOg3iDYuA@mail.gmail.com>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
 <1472114562-2736-4-git-send-email-alex.shi@linaro.org> <57D80709.4040500@linaro.org>
 <3288596.DV966QMpDZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36479 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760757AbcINI2h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Sep 2016 04:28:37 -0400
Received: by mail-lf0-f42.google.com with SMTP id g62so4637910lfe.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Sep 2016 01:28:36 -0700 (PDT)
In-Reply-To: <3288596.DV966QMpDZ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alex Shi <alex.shi@linaro.org>, open list <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Hi Rafael,

On 14 September 2016 at 00:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, September 13, 2016 10:02:49 PM Alex Shi wrote:
>> Hi Daniel & Rafael,
>>
>> Any comments on this patch?
>
> I actually am not sure about the whole series.
>
> I know your motivation, but honestly the changes here may not be the best way
> to achieve what you need.
>
> You may think that the changes are trivial, but in fact they are not.  There
> are side effects and I'm not sure about the resulting user space interface
> at all.

This patchset has got 2 parts:
- one part is about taking into account per-device resume latency
constraint when selecting the idle state of a CPU. This value can
already be set by kernel (even if it's probably not done yet) but this
constraint is never taken into account
- the other part is about exposing the resume latency to userspace.
This part might raise more discussion but I see one example that could
take advantage of this. When you have several clusters of CPUs and you
want to dedicate some CPUs  to latency sensitive activity and prevent
deep sleep  state on these CPUs but you want to let the other CPUs
using all C-state

Regards,
Vincent


>
> Thanks,
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
