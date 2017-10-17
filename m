From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v4 4/8] PM / devfreq: Change return type of devfreq_set_freq_table()
Date: Tue, 17 Oct 2017 23:45:03 +0900
Message-ID: <CAJ0PZbSFkbRf5Y1aUt=d7n1Vrf13qyaetbYXLv5zJc2nL+QUKw@mail.gmail.com>
References: <CGME20171013074833epcas1p24b7e56770d8199dd12972de1c8447007@epcas1p2.samsung.com>
 <1507880904-31956-1-git-send-email-cw00.choi@samsung.com> <1507880904-31956-5-git-send-email-cw00.choi@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:54172 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932493AbdJQOpT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2017 10:45:19 -0400
In-Reply-To: <1507880904-31956-5-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, chanwoo@kernel.org, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Oct 13, 2017 at 4:48 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch changes the return type of devfreq_set_freq_table()
> from 'void' to 'int' in order to check whether it fails or not.
>
> And This patch just removes the 'devfreq' prefix and the description
> of function. Because the helper functions are only used by the devfreq.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

> ---
>  drivers/devfreq/devfreq.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
[]

-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
