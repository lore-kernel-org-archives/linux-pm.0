From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v3 1/3] cpufreq: Add boost frequency support in core
Date: Wed, 19 Jun 2013 09:16:12 +0200
Message-ID: <20130619091612.60e4d69d@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <20130617155156.4c729b5a@amdc308.digital.local>
 <CAKohpo=_=u35wTb-ZUXrR2hNno+ryAqq4gSC3EiJr=-bmgb9JQ@mail.gmail.com>
 <3258927.Qds4G9CTyG@vostro.rjw.lan>
 <20130618154456.56d99e18@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <20130618154456.56d99e18@amdc308.digital.local>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Jun 2013 15:44:56 +0200, Lukasz Majewski wrote:

Dear Viesh, Rafael,

> > 
> > I'd recommend you both to read Documentation/cpu-freq/boost.txt
> > now. :-)  
> 
> 
> According to the documentation:
> "Reading the file is always supported, even if the processor does not
> support boosting. In this case the file will be read-only and always
> reads as "0""
> 
> Hmm, in the proposed patch set, the "boost" attribute is only exported
> when cpufreq driver sets boost_supported flag. 

I would like to clarify the above issue. 

When I've discussed with Viresh previous version of this patch, we have
agreed, that "boost" sysfs attribute [*]:
/sys/devices/system/cpu/cpufreq/boost

would be only visible when boost_supported flag is set at cpufreq
driver. 

When acpi-cpufreq driver doesn't support boost, the attribute [*]
won't be exported at all. This contradicts the documentation and legacy
acpi-cpufreq behaviour. 

Since I'm affraid to break API (with all its consequences :-) ), I would
like to be sure that this is OK, and thereof I'm allowed to rewrite
documentation accordingly.

I simply need explicit permission from both maintainers :-).

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
