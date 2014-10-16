From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Thu, 16 Oct 2014 16:27:37 +0530
Message-ID: <CAKohpon9Gec8++oKjq7Hcr4rdgQ1=c+qhCB+f5tuz7Ni=aPuWg@mail.gmail.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
	<54353223.7080704@redhat.com>
	<CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com>
	<5437C12D.1070803@redhat.com>
	<CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com>
	<5437C535.3070707@redhat.com>
	<CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com>
	<5437C778.4040108@redhat.com>
	<1412942496.13463.28.camel@x200t>
	<CAKohpomvrKxnk3ZOtZxZEO+fVWSr5gB1AadtFUib8jsqndDgtg@mail.gmail.com>
	<1412947425.13463.37.camel@x200t>
	<CAKohpokag-ppE7WH=jPS6-i_T-5PyaDKyKS8uC+Xt2QGxLHYkw@mail.gmail.com>
	<1412949926.13463.47.camel@x200t>
	<CAKohpokBzXG=zSicg5uMGK7=qTCOObG_r4Z4trkRmQxftv0vyw@mail.gmail.com>
	<543D0C43.3070701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:46393 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbaJPK5i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Oct 2014 06:57:38 -0400
Received: by mail-oi0-f53.google.com with SMTP id v63so2396712oia.26
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2014 03:57:37 -0700 (PDT)
In-Reply-To: <543D0C43.3070701@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

On 14 October 2014 17:12, Prarit Bhargava <prarit@redhat.com> wrote:
> I've been running both my test and Robert's test for about 5 mins.  In Robert's
> case I don't see any problems ... in my case I do occasionally get a system
> panic because of the sysfs access race I described in the other thread (cpu 1
> holds a sysfs file open, while cpu 2 changes the governor ...)

Can you give me the exact script? I wasn't able to reproduce it.

> I do have some concerns about the nature of this patchset; I feel it is more of
> a band-aid approach to the whole cpufreq mechanism.  Having said that, I haven't
> offered an alternative yet so I can't really object too loudly :)

Yes and No. Some part of it is indeed required. For example, checking for
a valid operation must be performed in __cpufreq_governor(). Its not just
called from cpufreq_set_policy() but other places as well.. And so accepting
STOP from one thread and maybe START from other will always be a problem.

About serializing calls to __cpufreq_governor(), yes a lock will be a
better fix.
But we have a long standing issue with that. And I am not able to
generate the lockdep for some reason now.

--
viresh
