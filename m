From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Report if CPU doesn't report boost technologies
Date: Wed, 20 Feb 2019 12:16:37 +0100
Message-ID: <CAJZ5v0iHh2VC1b90G+bXP0WpBmJ__Ba=yAjjCifkMRmd5xrmuw@mail.gmail.com>
References: <20190220101017.19587-1-e.velu@criteo.com> <CAJZ5v0i5BVFRKsCVxDwG90vBAuS3QYB=-GkC0pbGLy5DWDXuMg@mail.gmail.com>
 <1d9ff7a8-5f05-6554-d019-9665536aea84@criteo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1d9ff7a8-5f05-6554-d019-9665536aea84@criteo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Erwan Velu <e.velu@criteo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Erwan Velu <erwanaliasr1@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 20, 2019 at 11:52 AM Erwan Velu <e.velu@criteo.com> wrote:
>
>
> Le 20/02/2019 à 11:41, Rafael J. Wysocki a écrit :
> > On Wed, Feb 20, 2019 at 11:11 AM Erwan Velu <erwanaliasr1@gmail.com> wrote:
> >> There is some rare cases where CPB (and possibly IDA) are missing on processors.
> >> This is the case fixed by commit f7f3dc00f612 ("x86/cpu/AMD: Fix erratum 1076 (CPB bit)") and following.
> >>
> >> In such context, the boost status isn't reported by /sys/devices/system/cpu/cpufreq/boost.
> > So I'm not really sure why the extra message is needed.  It looks like
> > this message will always be printed (with debug output enabled) if the
> > current cpufreq driver is acpi-cpufreq and the boost attribute is not
> > present in sysfs, which only is the case if CPB/IDA aren't there.
> >
> > Does it provide any additional information, then?
>
> When you know and read the code, yes this patch is too obvious.
>
> As a user when I was troubleshooting why the boost entry was _not_
> populated on one CPU and was populated on another.
>
> Running acpi-cpufreq with dyndbg, I would have found useful to get that
> hint.
>
> So that could helps users that never read that part of the code and
> which are tricked into that configuration.

OK, I see your point.

I'll queue up the patch, but I guess I'll change the message.
