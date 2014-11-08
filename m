From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 0/2] cpufreq: cpufreq-dt: Improvements for set_target()
Date: Sat, 08 Nov 2014 02:40:58 +0100
Message-ID: <1818822.DxWyK5LNBq@vostro.rjw.lan>
References: <1413583789-24294-1-git-send-email-stefan.wahren@i2se.com> <CAKohpokjczrGvZ6e7JOwkPtq1-MC0Cr_s+bp=wwKt4x+FdumWQ@mail.gmail.com> <5449FDE0.9020101@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60544 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752442AbaKHBUI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 20:20:08 -0500
In-Reply-To: <5449FDE0.9020101@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Friday, October 24, 2014 09:21:04 AM Stefan Wahren wrote:
> Am 20.10.2014 um 06:43 schrieb Viresh Kumar:
> > On 18 October 2014 03:39, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >> This patch series contains 2 improvements for set_target().
> >>
> >> changes in V2:
> >>   - rebase because of name change cpufreq-cpu0 to cpufreq-dt
> >>
> >> Stefan Wahren (2):
> >>   cpufreq: cpufreq-dt: Improve debug about matching OPP
> >>   cpufreq: cpufreq-dt: Handle regulator_get_voltage() failure
> >>
> >>  drivers/cpufreq/cpufreq-dt.c |    9 +++++++--
> >>  1 file changed, 7 insertions(+), 2 deletions(-)
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Thanks. But maybe the patch series won't apply anymore.
> 
> Should i rebase again?

No need, it still applies. :-)

Queued up for 3.19-rc1, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
