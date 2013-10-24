From: Melanie Kambadur <melanie@cs.columbia.edu>
Subject: Re: powersave governor runs programs faster and uses more power than
 performance governor
Date: Thu, 24 Oct 2013 15:42:17 -0400
Message-ID: <CAMeUXYuQobSo7Au07V2KBE6=mAqXW1Hj--G92FP0X1H97Kv8OA@mail.gmail.com>
References: <CAMeUXYuuM4LS2qAhhvQi8VG1bK4eiZjjTikchgHzeqi2EX6=bw@mail.gmail.com>
	<CAOh2x==D_niGhi-fSSW18WQZjEQU+FngvVCB_K+y+3BRfaz96A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:38374 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156Ab3JXTmS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2013 15:42:18 -0400
In-Reply-To: <CAOh2x==D_niGhi-fSSW18WQZjEQU+FngvVCB_K+y+3BRfaz96A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, David C Niemi <dniemi@verisign.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Thank you for your quick and very helpful responses.

A couple of updates. I neglected to RTFM for the cpufreq setter I was
using :)  When I started to print out the values for all the CPUs
rather than just the averages as Viresh suggested, I realized that my
governor settings were only applying to one of the cores at a time. My
apologies for the silly mistake, I thought I had verified that the
changes were applied to all of the cores.

After actually applying the frequency governor updates to all of the
cores (and triple-checking this time), the new results for my
mini-experiment are still odd. I don't know a good way to share data
on this forum, please see a snippet of the data at the end of this
note and let me know if there is a better way to share the complete
data set. As a summary, the new average frequencies across all the
cores were:
performance w/ no apps running =3D 1.13 * 10 ^ 6
performance w/ apps running =3D 1.33 * 10 ^ 6
powersave w/ no apps running =3D 1.38 * 10 ^ 6
powersave w/ apps running =3D 1.95 * 10 ^ 6

I compared these numbers (from cpufreq/cpuinfo_cur_freq) to i7z
reports and they seem to be reasonable. It's hard to compare
perfectly, because I can't get i7z to print the frequency values in
plain text as I would like, but they are definitely in the same
ballpark (look to be within 100 Mhz).

Obviously, these still aren't the frequency values we'd expect.  I
think David may be correct that the Dell firmware is somehow
overriding the linux governors. Here are some more details about my
server:
Dell Power Edge R420 with 2 sockets, both:
Intel=AE Xeon=AE E5-2430 2.20GHz, 15M Cache, 7.2GT/s
QPI, Turbo, 6C, 95W, Max Mem 1333MHz E52430
Each socket actually has 6 cores, with dual SMT to make 12 logical
cores per socket, or 24 total logical cores.

=46rom /sys/devices/system/cpu/cpuN/cpufreq/scaling_driver I get that
the current p-state driver is called "intel_pstate". David, you
mention that the firmware governors are not very efficient, do you
suggest replacing the intel_pstate driver with a different driver? Of
the drivers listed here:
https://wiki.archlinux.org/index.php/CPU_Frequency_Scaling#CPU_frequenc=
y_driver
, I apparently only have available speedstep and p4-clockmod in my
current kernel. Is one of those better than intel_pstate or will I
need to download a new driver or even update the kernel to get another
one?

Also, by C1E do you mean idle state management? I should have given
some context for my adjustments to the power management policies,
which is that I am a grad student trying to research how system level
energy management policies compare to some specific application level
energy management policies. I would actually like to test a range of
system level policies, including different kinds of frequency and idle
state managers. The original goal was to compare a power-optimized
system version with a performance-optimized version (or a few such
versions), but I am learning that the options are not so simple. I
initially thought that on-demand would be the most power-efficient
frequency governor, but when I noticed that the on-demand governor was
missing in my available governors list, I did some digging and
discovered people writing that on-demand was deprecated for
Sandy-Bridge (e.g.,
http://www.phoronix.com/scan.php?page=3Dnews_item&px=3DMTM3NDQ) Is this
true? On a more general note, does anyone know what the theoretically
most power- and performance-optimized frequency governors/drivers
would be for my system setup?

Thanks again,

Melanie

P.S. I haven't yet tried the latest v3.12-rc kernel, and while it is
an option, I would prefer to get the frequency tuning working on my
existing kernel to avoid having to re-run some other relevant
experiments.
----------------
Some data snippets (I am giving 4 half-second interval samples for
each of the 24 cores/HW threads, for each of the 4 configs mentioned
above).

performance w/ no apps running
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
20, 21, 22, 23
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000

1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000

1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000

1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000

performance w/ apps running
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
20, 21, 22, 23
1188000, 1188000, 1188000, 1650000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1958000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000

1826000, 1188000, 2486000, 1254000, 2486000, 1188000, 2486000,
1188000, 2486000, 1188000, 2486000, 1188000, 2486000, 1188000,
2486000, 1188000, 2486000, 1188000, 2486000, 1188000, 1188000,
1188000, 1188000, 1188000

1298000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000

1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000, 1188000, 1188000, 1188000, 1188000,
1188000, 1188000, 1188000

powersave w/ no apps running
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
20, 21, 22, 23
1320000, 1518000, 1232000, 1738000, 1386000, 2354000, 1210000,
2486000, 1298000, 2486000, 1958000, 2464000, 1342000, 2332000,
2310000, 2442000, 2068000, 2486000, 1474000, 2486000, 1562000,
2486000, 1452000, 2486000

1320000, 1782000, 1958000, 2486000, 1672000, 2486000, 1694000,
2486000, 1298000, 2486000, 1958000, 2354000, 1232000, 2486000,
2332000, 2420000, 2442000, 2486000, 2244000, 2486000, 1562000,
2486000, 1408000, 2486000

1914000, 2090000, 1782000, 2464000, 1914000, 2486000, 1694000,
2486000, 1826000, 2486000, 1958000, 2332000, 1232000, 2310000,
1914000, 1980000, 2332000, 2354000, 2244000, 2354000, 1562000,
2002000, 1408000, 2486000

1914000, 1606000, 1716000, 2354000, 1936000, 2420000, 1562000,
2420000, 1584000, 2486000, 1958000, 2486000, 1232000, 2486000,
2332000, 2464000, 2442000, 2442000, 2244000, 2486000, 1496000,
2486000, 1320000, 2486000

powersave w/ apps running
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
20, 21, 22, 23
2178000, 1694000, 1738000, 1628000, 2178000, 1870000, 2200000,
1298000, 2178000, 1474000, 2200000, 1606000, 2112000, 2200000,
2200000, 2002000, 2178000, 2112000, 2178000, 2046000, 2024000,
1936000, 1848000, 1188000

2178000, 1694000, 1738000, 1452000, 2486000, 1188000, 2486000,
1826000, 2486000, 1188000, 2486000, 1848000, 2112000, 2200000,
2486000, 1980000, 2486000, 1782000, 2200000, 2046000, 2024000,
1936000, 1848000, 1188000

1430000, 1694000, 2354000, 1452000, 2156000, 1826000, 2156000,
1738000, 2046000, 1826000, 2090000, 1562000, 2200000, 2046000,
2156000, 2178000, 2200000, 2134000, 2046000, 2178000, 2112000,
2178000, 2200000, 2178000

2046000, 1738000, 2200000, 1826000, 2200000, 1694000, 2200000,
1716000, 2178000, 2134000, 2178000, 1760000, 2200000, 1914000,
2178000, 2178000, 2178000, 2178000, 2178000, 2200000, 2178000,
2200000, 2200000, 1782000

On Thu, Oct 24, 2013 at 1:28 AM, Viresh Kumar <viresh.kumar@linaro.org>=
 wrote:
>
> On Thu, Oct 24, 2013 at 4:47 AM, Melanie Kambadur
> <melanie@cs.columbia.edu> wrote:
> > I am trying to understand some strange results I've observed using =
the
> > 3.9.11 kernel version of the powersave cpufreq governor on a Intel
> > Xeon machine, and hoping you all can help.
> >
> > More specifically, I am using a 24 core Intel Xeon 2430 machine
> > running Ubuntu 12.04 and v 3.9.11 of the kernel. As I understand it=
,
> > this configuration affords me two cpufreq scaling governors, powers=
ave
> > and performance. At least these are the options I get by running:
> > /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
> >
> > Here's the issue. When I turn on the powersave governor, I have
> > measured the power consumed to INCREASE relative to the performance
> > governor. More surprisingly, I consistently see BETTER performance
> > (i.e., shorter runtimes) with the powersave governor than with the
> > performance governor for many applications out of a few sets of
> > commonly used benchmark applications.  I repeated my experiments
> > several times, even trying different cpuidle governors, and observe=
d
> > the same trends. To toggle between governors, I have been using the
> > cpufreq-set -g command and confirming the updates by checking
> > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor.
> >
> > From what I've read (e.g., here:
> > www.kernel.org/doc/Documentation/cpu-freq/governors.txt), the
> > powersave governor's policy is to statically set the cpu frequency =
at
> > the system minimum, whereas the performance governor aims to set th=
e
> > cpu frequency higher (or, depending on the documentation, at maximu=
m).
> > However, the fact that applications sped up for the powersave vs. t=
he
> > performance governor with these policies seemed incorrect to me, so=
 I
> > investigated further...
> >
> > I profiled the current system frequency by periodically polling
> > /sys/devices/system/cpu/cpu${N}/cpufreq/cpuinfo_cur_freq
> > for all the available "N" values (0-23) on my machine.  I found tha=
t
> > not only does the powersave governor not seem to be running at the
> > system minimum, it actually seems to be running at a frequency high=
er
> > than the performance governor. This would explain why I am seeing
> > better performance and higher power for the powersave governor, but=
 it
> > certainly doesn't fit the policy descriptions in the documentation.
> > Here are the results of my mini experiment:
> >
> > -Minimum system frequency=3D1.20 * 10^6
> > -Maximum system frequency=3D2.70 * 10^6
> >
> > Avg. cpu frequency across all CPUs for 30 seconds of...
> > -Powersave governor with no applications running =3D 1.77 * 10^6
> > -Powersave governor with a benchmark app running =3D 2.23 * 10^6
> > -Performance governor with no apps running =3D 1.23 * 10^6
> > -Performance governor with a benchmark app running =3D 1.34 * 10^6
> >
> > Am I misunderstanding the policies of the powersave vs. performance
> > governor, or is this possibly a system bug?
>
> There is something really long in your machine.. Any chance you can
> try latest v3.12-rc kernel?
>
> Also, please provide values of related and affected CPUs, for all CPU=
s..
> Also, just to confirm, you are changing governor to powersave or
> performance for all the CPUs??
>
> Otherwise there is no valid reason why this should happen :)
