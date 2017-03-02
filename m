From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 1/2] cpufreq: mt8173: Mark mt8173_cpufreq_driver_init as __init
Date: Thu, 2 Mar 2017 19:30:11 +0800
Message-ID: <CAGS+omC34Ua8KvzzQ6XMTOVS3M_SiVrSKfFdRXEqEpgC43ejrw@mail.gmail.com>
References: <20170302110345.184924-1-djkurtz@chromium.org> <20170302110651.GC13760@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36465 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdCBMYS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Mar 2017 07:24:18 -0500
Received: by mail-io0-f169.google.com with SMTP id l7so51758055ioe.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Mar 2017 04:22:46 -0800 (PST)
In-Reply-To: <20170302110651.GC13760@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Yidi Lin <yidi.lin@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Mar 2, 2017 at 7:06 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 02-03-17, 19:03, Daniel Kurtz wrote:
> > This function is only called once at boot by device_initcall(), so mark
> > it as __init.
> >
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > ---
> >  drivers/cpufreq/mt8173-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Its very strange.  The patch itself does not appear to have made it to the list.

But, I do see your Ack:
https://www.spinics.net/lists/kernel/msg2455271.html


>
> --
> viresh
