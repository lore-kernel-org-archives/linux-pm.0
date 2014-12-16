From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH] cpufreq-dt: defer probing if OPP table is not ready
Date: Mon, 15 Dec 2014 21:43:11 -0800
Message-ID: <CAE_wzQ8OmWxtZcb5aD8TKkfthkR=N6oYF4a-9fZXcqTyTR=L-w@mail.gmail.com>
References: <20141216001058.GA31286@dtor-ws>
	<CAKohpo=mcG99N5q_CCua8Hdydo=ydHKD-CiTJO9SsAhLvkTJHw@mail.gmail.com>
	<CAE_wzQ_Lz7pv1io6UMAXjesVeurbC=as2BuxBrA+XXkh5b+AWA@mail.gmail.com>
	<CAKohpon_z5duigPptOpT1wrLkWLgDqGQq8+1J7oofujy7Q4MtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:65464 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbaLPFnM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 00:43:12 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so12368113iec.11
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 21:43:12 -0800 (PST)
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com. [209.85.223.179])
        by mx.google.com with ESMTPSA id f1sm2560407iga.1.2014.12.15.21.43.11
        for <linux-pm@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Dec 2014 21:43:11 -0800 (PST)
Received: by mail-ie0-f179.google.com with SMTP id rp18so11814163iec.24
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 21:43:11 -0800 (PST)
In-Reply-To: <CAKohpon_z5duigPptOpT1wrLkWLgDqGQq8+1J7oofujy7Q4MtA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dmitry Torokhov <dtor@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Stefan Wahren <stefan.wahren@i2se.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Dec 15, 2014 at 9:38 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 16 December 2014 at 11:02, Dmitry Torokhov <dtor@chromium.org> wrote:
>> Yes we will. Which simply means that this WARN is stupid. We also will
>> hit it if there is no opp table and the allocation below fails; or if
>> it succeeds then dev_pm_opp_init_cpufreq_table() will fail and we'll
>> hit this code path again.
>>
>> We should either drop that WARN() or handle -ENODEV there properly.
>
> Yeah, we should drop it. Its just too hard for such cases. You will take care
> of that in your series?
>

Yes, I'll address other comments and resubmit.

> For your patch:
>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

-- 
Dmitry
