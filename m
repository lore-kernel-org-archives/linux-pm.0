From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v4 6/8] PM / devfreq: Remove unneeded conditional statement
Date: Tue, 17 Oct 2017 23:59:40 +0900
Message-ID: <CAJ0PZbQ8fpTYu9iZ9EBfPhiaVFBPiCQR_XJss4_7=KP6rLak-A@mail.gmail.com>
References: <CGME20171013074835epcas1p378b24f20d4feb973aef5319445b81570@epcas1p3.samsung.com>
 <1507880904-31956-1-git-send-email-cw00.choi@samsung.com> <1507880904-31956-7-git-send-email-cw00.choi@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45709 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932708AbdJQO76 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2017 10:59:58 -0400
In-Reply-To: <1507880904-31956-7-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, chanwoo@kernel.org, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Oct 13, 2017 at 4:48 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> The freq_table array of each devfreq device is always not NULL.
> In result, it is unneeded to check whether profile->freq_table
> is NULL or not.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


> ---
>  drivers/devfreq/devfreq.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
[]


-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
