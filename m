From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 0/3] cpufreq:boost: CPU Boost mode support
Date: Wed, 12 Jun 2013 08:00:02 +0200
Message-ID: <20130612080002.3f382ee1@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1370941408-29304-1-git-send-email-l.majewski@samsung.com>
 <CAKohpo=VpMvxMb-r4Hgga1ZM9m9egyUH_Ee+S=q25RdT7DAE-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpo=VpMvxMb-r4Hgga1ZM9m9egyUH_Ee+S=q25RdT7DAE-Q@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

> On 11 June 2013 14:33, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > This patch series introduces support for CPU overclocking technique
> > called Boost.
> >
> > It is a follow up of a LAB governor proposal. Boost is a LAB
> > component:
> > http://thread.gmane.org/gmane.linux.kernel/1484746/match=cpufreq
> >
> > Boost unifies hardware based solution (e.g. Intel Nehalem) with
> > software oriented one (like the one done at Exynos).
> > For this reason cpufreq/freq_table code has been reorganized to
> > include common code.
> 
> To be honest, I haven't given a review to patches 2/3 and 3/3 as I am
> concerned more about 1/3.

As you pointed out in the other mail 1/3 has its own issues, but I
think that patches 2/3 and 3/3 are an integral part of the boost
support and bring better overall overview to the design.

> 
> Maybe you can just send v3 of 1/3. 2/3 and 3/3 can be sent when we
> have finalized 2/3 and 3/3 's version.

I'd opt for sending the whole patchset (it shouldn't be so difficult to
adjust those patches), since it is easier for me to test.



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
