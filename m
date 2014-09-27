From: Mike Turquette <mike.turquette@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: allow driver-specific flags
Date: Sat, 27 Sep 2014 15:44:34 -0700
Message-ID: <20140927224434.19023.35708@quantum>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
 <1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1410342112-13264-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAKohpom4=nbg510bUb20C6rsG8r184YQ0SiPmPkxj8_8Y04+Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:51829 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbaI0Wo5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Sep 2014 18:44:57 -0400
Received: by mail-pd0-f174.google.com with SMTP id g10so14303760pdj.19
        for <linux-pm@vger.kernel.org>; Sat, 27 Sep 2014 15:44:57 -0700 (PDT)
In-Reply-To: <CAKohpom4=nbg510bUb20C6rsG8r184YQ0SiPmPkxj8_8Y04+Bg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>

Quoting Viresh Kumar (2014-09-10 03:49:25)
> On 10 September 2014 15:11, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 138336b..fa35601 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -218,7 +218,7 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
> >
> >  struct cpufreq_driver {
> >         char                    name[CPUFREQ_NAME_LEN];
> > -       u8                      flags;
> > +       unsigned int            flags;
> >
> >         /* needed by all drivers */
> >         int     (*init)         (struct cpufreq_policy *policy);
> > @@ -308,10 +308,13 @@ struct cpufreq_driver {
> >   */
> >  #define CPUFREQ_NEED_INITIAL_FREQ_CHECK        (1 << 5)
> >
> > +#define CPUFREQ_DRIVER_FLAGS_MASK (0xFFFF0000)
> 
> The flags field is used today to pass on information to cpufreq core and
> I believe it better stays that way only. Also all these changes might later
> be reverted and so we better don't change usage of variables..

I have another use case for exposing driver flags and I have created a
similar patch to this locally in my git tree.

Basically some cpufreq drivers may block or sleep during their
.set_target callback, and others will not. E.g. the former case is the
common pattern to use the clock framework and the regulator framework,
both of which hold mutexes and may have slow operations and the latter
case is more like the Intel P-state driver with just some register
writes.

For the energy-aware scheduling work it is desirable to know if the
cpufreq driver can do a "fast" transition of it might sleep, since that
affects whether we adjust the cpu frequency from the scheduler context
of whether need to put new work on the workqueue (e.g. waking up a
kthread dedicated to calling .set_target).

Regards,
Mike

> 
> Instead of this add a "void *driver_data" field in this structure and fill that
> with your structure. This can be later used for other purposes as well..
> 
> Also this will just add few more bytes to the cpufreq-driver structure which
> wouldn't have many instances in a compiled kernel, and so space isn't a
> problem..
> 
> Otherwise things looked good to me in your complete series..
