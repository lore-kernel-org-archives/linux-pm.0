From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: move policy kobj to policy->cpu at resume
Date: Thu, 17 Jul 2014 09:51:46 +0530
Message-ID: <CAKohponqQ2SNNO64SuBxPwCXU6BNa4QNhDzUaSAhnwAN3iy-Kg@mail.gmail.com>
References: <1eff59d9b51f8ade67bc1cf9f10683f9463ec9f6.1404996041.git.viresh.kumar@linaro.org>
	<9320264.Zgy80Rpl1d@vostro.rjw.lan>
	<CAKohpo=Wx-wr0RT6GWoxcmuFyrTr+jKUN2q2bmqda7vMsL5ETg@mail.gmail.com>
	<CAJZ5v0jOB-s0qNx+Uh5ihyAAvryOt+QM9=Gy09LEWPK-=ckx6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:42458 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbaGQEVr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jul 2014 00:21:47 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn18so5297312igb.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2014 21:21:46 -0700 (PDT)
In-Reply-To: <CAJZ5v0jOB-s0qNx+Uh5ihyAAvryOt+QM9=Gy09LEWPK-=ckx6g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Saravana Kannan <skannan@codeaurora.org>, "Bu, Yitian" <ybu@qti.qualcomm.com>, Stable <stable@vger.kernel.org>

On 17 July 2014 06:19, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Quite frankly, to me this patch just does too much in one go without
> describing about a half of things it is doing.
>
> I would just add the kobject_move() call to __cpufreq_add_dev() to
> start with (because that's what you really want if I'm not mistaken)
> and do the cleanups separately, later.

I understand that as I had similar feelings about it. See what I sent
during V1: http://www.spinics.net/lists/stable/msg54338.html

Only when Srivatsa asked me to do the cleanups with it, I went for
V2. And still wasn't really sure about getting that as a bug fix. And
so had a chat with him again and asked you to push V1, and we
will do cleanups later.

So, I don't see V1 in patchworks anymore and I must resend?
I will make out a series out of V2, first patch would be a fix for
3.16 & stable, and others would be for 3.17. Hope that works.

--
viresh
