From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v2 0/3] PM / devfreq: Fix the bug and add reviewer for
 devfreq support
Date: Tue, 3 Jan 2017 20:54:49 +0900
Message-ID: <CAGTfZH14OyJGwfSVoSuF2C0k9WGrDJAm4ks=3Se+4i-V1yXrHA@mail.gmail.com>
References: <CGME20161228115241epcas5p4f9f5a1f76e262f9dff92a59bdbec30d7@epcas5p4.samsung.com>
 <1482925956-19044-1-git-send-email-cw00.choi@samsung.com>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:32775 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdACLzL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2017 06:55:11 -0500
In-Reply-To: <1482925956-19044-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Dear Myungjoo,

Thanks for your review for patch1.
But, patch2/3 is not yet reviewed. Could you please review these patches?

2016-12-28 20:52 GMT+09:00 Chanwoo Choi <cw00.choi@samsung.com>:
> This patches fix the bug of devfreq_add_device() when governor name is wrong
> and the wrong return value of probe() function for exynos_bus.c driver.
>
> And I've been helping reviewing and tesing the devfreq support patches
> for the couple of years. Also, I'm going to contribute the improvement
> for devfreq subsystem. It would be easier for me for review if I'm cc'ed
> for patches. So, patch1 adds myself as a reviewer for devfreq support.
>
> Changes from v1:
> (https://lkml.org/lkml/2016/12/15/122)
> - Rebase these patches on v4.10-rc1.
>
> Chanwoo Choi (3):
>   MAINTAINERS: Add myself as reviewer for DEVFREQ subsystem support
>   PM / devfreq: Fix the bug of devfreq_add_device when governor is NULL
>   PM / devfreq: exynos-bus: Fix the wrong return value
>
>  MAINTAINERS                  |  1 +
>  drivers/devfreq/devfreq.c    | 15 ++++++++++-----
>  drivers/devfreq/exynos-bus.c |  2 +-
>  3 files changed, 12 insertions(+), 6 deletions(-)
>
> --
> 1.9.1
>



-- 
Best Regards,
Chanwoo Choi
