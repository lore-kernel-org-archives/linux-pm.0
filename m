From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
Date: Wed, 17 Jul 2013 16:59:43 +0200
Message-ID: <20130717165943.7f06acd9@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <6633375.dICiDrHJgK@vostro.rjw.lan>
 <CAKohpokw-bSWEgKvx0jd2QZ0RCz5dORHM9z+VYbTdKoCmKFvsg@mail.gmail.com>
 <2509113.ybUsa2l9tg@vostro.rjw.lan>
 <CAKohpo=1Qov8p3f2xZkfOqaFRNJPJN60KeK4SOXcL9Hw82MkAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpo=1Qov8p3f2xZkfOqaFRNJPJN60KeK4SOXcL9Hw82MkAg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lukasz Majewski <l.majewski@majess.pl>, Dirk Brandewie <dirk.brandewie@gmail.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 17 Jul 2013 18:31:19 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 17 July 2013 17:01, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > First off, I'm not sure how many applications actually use it and I
> > think, if any, they should be able cope with the attribute not
> > being present.
> >
> > Of course, if it turns out that yes, there are applications using
> > it and no, they cannot cope with the missing attribute, we'll need
> > to address this. That said such applications wouldn't work with
> > earlier kernels in which that attribute wasn't present at all, so I
> > suppose this is really unlikely.
> >
> > So, do whichever makes more sense to you: Design things to preserve
> > the old behavior (which is sightly confusing) or design them to
> > expose the attribute if the feature is actually supported and be
> > prepared to address the (unlikely) case when some hypothetical
> > applications break because of that.
> 
> Okay. Its better to keep it the way Lukasz designed it in his last
> patchset.

To be 100% sure - we export boost only when supported (as proposed at v5).


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
