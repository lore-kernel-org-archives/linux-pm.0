From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / devfreq: rk3399_dmc: Remove explictly regulator_put
 call in .remove
Date: Mon, 19 Sep 2016 13:08:59 +0200
Message-ID: <CAJZ5v0iJ=EoVD=V1QiX5AsR=fYC14xhgG0aVNZaZeASAU4_=Vw@mail.gmail.com>
References: <CGME20160918024124epcas1p26e45dd69c71bdcded5b336c87f1b246b@epcas1p2.samsung.com>
 <1951060944.1420539.1474271094626.JavaMail.weblogic@ep1ml103c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35549 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760326AbcISLJB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2016 07:09:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id 133so14331292wmq.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2016 04:09:00 -0700 (PDT)
In-Reply-To: <1951060944.1420539.1474271094626.JavaMail.weblogic@ep1ml103c>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Axel Lin <axel.lin@ingics.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lin Huang <hl@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Sep 19, 2016 at 9:44 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> Current code uses devm_regulator_get() in .probe so a regulator_put() will
>> be automatically called when unload the module. Remove the explictly
>> regulator_put() call and then we can also remove rk3399_dmcfreq_remove().
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>>  drivers/devfreq/rk3399_dmc.c | 10 ----------
>>  1 file changed, 10 deletions(-)
>
> Thank you.
>
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Sign-off-by is for three cases:
(1) You send a patch you created.
(2) You send a patch from someone else (ie. you're not the author of it).
(3) You apply a patch.

Otherwise, please use Acked-by (and I'm going to add that to this
patch and to the other one you responded to with an S-o-b).

Thanks,
Rafael
