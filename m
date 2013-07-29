From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 5/8] cpufreq:boost:Kconfig: Provide support for
 software managed BOOST
Date: Mon, 29 Jul 2013 12:28:02 +0530
Message-ID: <CAKohponvOXuHSS+-+m5PR9tPkAqkrYtjA3FJaNh9NJXrhQ9wmw@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-6-git-send-email-l.majewski@samsung.com>
	<CAKohpokL57mXSQooX=4LZKtjMxJoXAB4uuzj13fgr3Gs7Wcf0A@mail.gmail.com>
	<20130726132120.5b9cf32f@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130726132120.5b9cf32f@amdc308.digital.local>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, durgadoss.r@intel.com
List-Id: linux-pm@vger.kernel.org

On 26 July 2013 16:51, Lukasz Majewski <l.majewski@samsung.com> wrote:
> On Fri, 26 Jul 2013 15:54:56 +0530 Viresh Kumar wrote,
>> On 25 July 2013 22:03, Lukasz Majewski <l.majewski@samsung.com> wrote:

>> > +config CPU_FREQ_BOOST_SW
>> > +       bool
>>
>> Invisible is fine but this must be disabled by default and must
>> depend on thermal, rather than moving dependency on platform's
>> config.
>
> The CPU_FREQ_BOOST_SW [1] is a generic flag (invisible).
>
> I will add "default n" to it.

Leave it.. We don't need it now.. that's how these kind of config options
are defined as they are disabled by default.

> Depending only on [3], results at situation where SW BOOST can be
> enabled at x86 or ARM target with only generic THERMAL support (which
> doesn't protect from overheating).

I had a similar concern.. Currently also we aren't stopping anybody to
enable boost. By selecting thermal from CPU_FREQ_BOOST_SW, atleast
we are communicating this very well to developers that they need
something else as well. And currently we only have thermal as a source
for telling when to block boost but it can be something else too..

I never said, don't use EXYNOS_THERMAL, its good to have a
dependency on it in the Exynos specific config for boost, but I wanted
normal sw boost also to depend on thermal..
