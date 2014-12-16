From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq-dt: defer probing if OPP table is not ready
Date: Tue, 16 Dec 2014 11:08:27 +0530
Message-ID: <CAKohpon_z5duigPptOpT1wrLkWLgDqGQq8+1J7oofujy7Q4MtA@mail.gmail.com>
References: <20141216001058.GA31286@dtor-ws>
	<CAKohpo=mcG99N5q_CCua8Hdydo=ydHKD-CiTJO9SsAhLvkTJHw@mail.gmail.com>
	<CAE_wzQ_Lz7pv1io6UMAXjesVeurbC=as2BuxBrA+XXkh5b+AWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:45383 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbaLPFi2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 00:38:28 -0500
Received: by mail-ob0-f169.google.com with SMTP id vb8so21378027obc.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 21:38:27 -0800 (PST)
In-Reply-To: <CAE_wzQ_Lz7pv1io6UMAXjesVeurbC=as2BuxBrA+XXkh5b+AWA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Stefan Wahren <stefan.wahren@i2se.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 16 December 2014 at 11:02, Dmitry Torokhov <dtor@chromium.org> wrote:
> Yes we will. Which simply means that this WARN is stupid. We also will
> hit it if there is no opp table and the allocation below fails; or if
> it succeeds then dev_pm_opp_init_cpufreq_table() will fail and we'll
> hit this code path again.
>
> We should either drop that WARN() or handle -ENODEV there properly.

Yeah, we should drop it. Its just too hard for such cases. You will take care
of that in your series?

For your patch:

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

--
viresh
