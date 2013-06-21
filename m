From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
Date: Fri, 21 Jun 2013 08:23:34 +0200
Message-ID: <20130621082334.655189ec@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-3-git-send-email-l.majewski@samsung.com>
 <CAKohpo=5ZJp6JBVVA0NinTMO5FUwtfy3QAabcTwVOW6TmEfs9g@mail.gmail.com>
 <5038475.Kzi1Kavss7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <5038475.Kzi1Kavss7@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Jun 2013 22:03:45 +0200, Rafael J. Wysocki wrote:

Hi Rafael,

> On Thursday, June 20, 2013 10:43:08 AM Viresh Kumar wrote:
> > On 19 June 2013 22:42, Lukasz Majewski <l.majewski@samsung.com>
> > wrote:
> > 
> > > Boost sysfs attribute is always exported (to support legacy API).
> > > By default boost is exported as read only. One global attribute
> > > is available at: /sys/devices/system/cpu/cpufreq/boost.
> > 
> > You asked me and Rafael a question and posted your next version
> > without even waiting for our replies? That will waste your time and
> > ours too reviewing it.
> 
> I believe I replied to that (in a different branch of the thread).
> 
> And the reply was: Do not expose if not supported.

Thanks for reply. Understood :-)

> 
> Thanks,
> Rafael
> 
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
