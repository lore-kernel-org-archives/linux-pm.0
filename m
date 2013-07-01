From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 5/7] cpufreq: Calculate number of busy CPUs
Date: Mon, 01 Jul 2013 10:15:16 +0200
Message-ID: <20130701101516.7945e387@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-6-git-send-email-l.majewski@samsung.com>
 <CAKohpo=EwapTp8epok30=_ZYLPeCR8_LhpBF5H724dE=+SwMLg@mail.gmail.com>
 <20130627125819.5c90da30@amdc308.digital.local>
 <CAKohpo=JKg17YWjTrOh25hHW=sXn8-TW=D8rhrovonwZBDarBg@mail.gmail.com>
 <20130627164204.370dc4a6@amdc308.digital.local>
 <CAKohpomrPP9Lzk+fMn+Ba+J+2N740LR5NurVMomx8zww3AWLww@mail.gmail.com>
 <20130628085457.05d64878@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <20130628085457.05d64878@amdc308.digital.local>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>
Cc: Lukasz Majewski <l.majewski@samsung.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 Jun 2013 08:54:57 +0200, Lukasz Majewski wrote:
> > > So thermal or "other solution" [*] shall disable boost when
> > > overheated and enable it back when things cool down.  
> > 
> > yeah..  
> 
> For me thermal is a good candidate to enable boost again. I only need
> to find a proper place for it.

Unfortunately, after careful investigation it turned out, that thermal
is suited to disable boost when overheating is detected. (since it uses
thermal subsystem interrupt to take action).

The problem is with enabling boost again, since thermal (at least at my
board) only reacts on TMU (thermal) interrupt. Thermal thread may be
started, but I don't regard this as a good solution (to extra bloat
thermal).

> 
> >   
> > > [*] @ Viresh & Rafael do you have any idea about the "other
> > > solution" here?  
> > 
> > Not really sure :)  
> 
> Not any single one? Then I would like to propose thermal.
> 

Does anybody have any idea here? As written above, thermal is suitable
to disable boost.

I'd like to bring those three options under discussion:

1. boost attr is always exported -> do not enable boost automatically
   when disabled by thermal (as it was proposed at v4).

2. boost attr is always exported -> find a way to enable boost after
   emergency disablement when thermal detects overheating (newest
   proposition). 

3. boost attr only exported at x86 (when supported)
   boost attr NOT exported via sysfs for SW controlled boost (e.g.
   Exynos ARM).

   Then we only enable/disable boost at kernel and don't need to take
   care of the user space interaction. This scenario is my use case. I
   hadn't planned to expose boost to userspace and use it with LAB as a
   kernel API.


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
