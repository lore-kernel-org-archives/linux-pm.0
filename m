From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v3 1/3] cpufreq: Add boost frequency support in core
Date: Thu, 20 Jun 2013 12:04:58 +0200
Message-ID: <20130620120458.4f2230f1@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <20130617155156.4c729b5a@amdc308.digital.local>
 <CAKohpo=_=u35wTb-ZUXrR2hNno+ryAqq4gSC3EiJr=-bmgb9JQ@mail.gmail.com>
 <3258927.Qds4G9CTyG@vostro.rjw.lan>
 <CAKohponVBjvQf-5BibzDUko=fVtzPYWMOr2xywp=r0TTB_t6Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohponVBjvQf-5BibzDUko=fVtzPYWMOr2xywp=r0TTB_t6Bw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Jun 2013 10:31:30 +0530, Viresh Kumar wrote:
> > I'd say there needs to be a separate controller/monitor for that
> > that will know what the chip's thermal limit is and how that
> > relates to how fast the CPU core(s) may run and for how much time.
> > I'm not sure it is sufficient to "wait for thermal to kick in"
> > here, because you may need to slow down things in advance (i.e.
> > before thermal sensors tell you there's too much heat, because that
> > may be too late already).  
> 
> That's why I wasn't sure about software boosting initially. But at
> the same time a thermal sensor might be good enough. They just have
> to be programmed accordingly, so that they fire a bit in advance
> before things are out of control. :)

I think that thermal subsystem shall disable boost when SoC is heated
up.

The problem is to guarantee, that thermal will be always enabled and
correctly configured when software based boost is ready to run.


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
