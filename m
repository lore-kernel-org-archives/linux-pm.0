From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Mon, 07 Sep 2015 15:07:05 +0200
Message-ID: <15201917.ny03gYuJf6@vostro.rjw.lan>
References: <001401d0e691$302127b0$90637710$@net> <000f01d0e783$6fe75cf0$4fb616d0$@net> <001601d0e7af$01a22140$04e663c0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61189 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752048AbbIGMjQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 08:39:16 -0400
In-Reply-To: <001601d0e7af$01a22140$04e663c0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Saravana Kannan' <skannan@codeaurora.org>, linux-pm@vger.kernel.org

On Saturday, September 05, 2015 12:46:40 AM Doug Smythies wrote:
> On 2015.09.05 19:35 Doug Smythies wrote:
> > On 2015.09.04 17:23 Rafael J. Wysocki wrote:
> >> On Sat, Sep 5, 2015 at 1:05 AM, Doug Smythies <dsmythies@telus.net> wrote:
> >>> On 2015.09.04 15:26 Rafael J. Wysocki wrote:
> >>>> On Fri, Sep 4, 2015 at 8:41 PM, Doug Smythies <dsmythies@telus.net> wrote:
> >>>>> On 2015.09.04 07:43 Viresh Kumar wrote:
> >>>>>> On 04-09-15, 16:59, Rafael J. Wysocki wrote:
> >>>>>>> On Thursday, September 03, 2015 02:40:43 PM Doug Smythies wrote:
> >>>>>>>> As of, or about, Kernel 4.2RC1 if I take my highest numbered
> >>>>>>>> CPU offline (7 in my case), the system will not suspend.
> 
> >>>> Hmm.
> >>>> I suspect that your user space does something that fails during the pm-suspend.
> >>>
> >>> Are you saying that the patch might be O.K., but reveals
> >>> and issue with pm-suspend that was always there?
> >>
> >> Or it breaks something that pm-suspend does before suspending.
> >>
> >> It would be good to know what it is. :-)
> 
> > While researching pm-utils bugs, I found reference to
> > /var/log/pm-suspend.log, which I had not noticed before.
> > Relevant extract attached.
> 
> > It is not clear to me why that echo line (there is only one)
> > would fail.
> 
> The echo line fails because the related CPU is offline.
> If the failed echo is the last pass through the loop,
> then the script interprets the overall execution of
> 94cpufreq as a failure and aborts the suspend.

That's correct AFAICS.

> If the failed echo is not the last pass through the loop, then
> the bad exit code gets overwritten with a good one before
> the loop exits.

Right.

> Since the loop is merely setting a temporary governor,
> to test I just used performance mode anyway, and commented
> out the echo. pm-suspend with CPU 7 offline then worked fine.
> 
> I have not yet gone back to any before the patch kernel
> to determine why it used to work (it is late in my time zone).
> However, I would have to assume that before the commit in
> question, the echo worked even if the CPU was offline.

It didn't have to, because the cpudreq directory was not present,
so the

[ -L "$x/cpufreq" ] && continue

line would trigger.

> Could someone please confirm or deny the above conclusion.
> 
> The relevant code segment, with some added debug
> echo stuff, from /usr/lib/pm-utils/sleep.d/94cpufreq 
> 
> hibernate_cpufreq()
> {
>   ( cd /sys/devices/system/cpu/
>   for x in cpu[0-9]*; do
>      # if cpufreq is a symlink, it is handled by another cpu. Skip.
>      [ -L "$x/cpufreq" ] && continue
>      gov="$x/cpufreq/scaling_governor"
>      # if we do not have a scaling_governor file, skip.
>      [ -f "$gov" ] || continue
>      # if our temporary governor is not available, skip.
>      grep -q "$TEMPORARY_CPUFREQ_GOVERNOR" \
>      "$x/cpufreq/scaling_available_governors" || continue
>      savestate "${x}_governor" < "$gov"
> # I added the next 3 lines
>      echo "$x"
>      echo "$TEMPORARY_CPUFREQ_GOVERNOR"
>      echo "$gov"
> # For a test, do not do the echo, as I already set performance mode
> #    echo "$TEMPORARY_CPUFREQ_GOVERNOR" > "$gov"
>   done )
> }

Thanks,
Rafael

