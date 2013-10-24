From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: powersave governor runs programs faster and uses more power than
 performance governor
Date: Thu, 24 Oct 2013 10:58:52 +0530
Message-ID: <CAOh2x==D_niGhi-fSSW18WQZjEQU+FngvVCB_K+y+3BRfaz96A@mail.gmail.com>
References: <CAMeUXYuuM4LS2qAhhvQi8VG1bK4eiZjjTikchgHzeqi2EX6=bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAMeUXYuuM4LS2qAhhvQi8VG1bK4eiZjjTikchgHzeqi2EX6=bw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Melanie Kambadur <melanie@cs.columbia.edu>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 24, 2013 at 4:47 AM, Melanie Kambadur
<melanie@cs.columbia.edu> wrote:
> I am trying to understand some strange results I've observed using the
> 3.9.11 kernel version of the powersave cpufreq governor on a Intel
> Xeon machine, and hoping you all can help.
>
> More specifically, I am using a 24 core Intel Xeon 2430 machine
> running Ubuntu 12.04 and v 3.9.11 of the kernel. As I understand it,
> this configuration affords me two cpufreq scaling governors, powersave
> and performance. At least these are the options I get by running:
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
>
> Here's the issue. When I turn on the powersave governor, I have
> measured the power consumed to INCREASE relative to the performance
> governor. More surprisingly, I consistently see BETTER performance
> (i.e., shorter runtimes) with the powersave governor than with the
> performance governor for many applications out of a few sets of
> commonly used benchmark applications.  I repeated my experiments
> several times, even trying different cpuidle governors, and observed
> the same trends. To toggle between governors, I have been using the
> cpufreq-set -g command and confirming the updates by checking
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor.
>
> From what I've read (e.g., here:
> www.kernel.org/doc/Documentation/cpu-freq/governors.txt), the
> powersave governor's policy is to statically set the cpu frequency at
> the system minimum, whereas the performance governor aims to set the
> cpu frequency higher (or, depending on the documentation, at maximum).
> However, the fact that applications sped up for the powersave vs. the
> performance governor with these policies seemed incorrect to me, so I
> investigated further...
>
> I profiled the current system frequency by periodically polling
> /sys/devices/system/cpu/cpu${N}/cpufreq/cpuinfo_cur_freq
> for all the available "N" values (0-23) on my machine.  I found that
> not only does the powersave governor not seem to be running at the
> system minimum, it actually seems to be running at a frequency higher
> than the performance governor. This would explain why I am seeing
> better performance and higher power for the powersave governor, but it
> certainly doesn't fit the policy descriptions in the documentation.
> Here are the results of my mini experiment:
>
> -Minimum system frequency=1.20 * 10^6
> -Maximum system frequency=2.70 * 10^6
>
> Avg. cpu frequency across all CPUs for 30 seconds of...
> -Powersave governor with no applications running = 1.77 * 10^6
> -Powersave governor with a benchmark app running = 2.23 * 10^6
> -Performance governor with no apps running = 1.23 * 10^6
> -Performance governor with a benchmark app running = 1.34 * 10^6
>
> Am I misunderstanding the policies of the powersave vs. performance
> governor, or is this possibly a system bug?

There is something really long in your machine.. Any chance you can
try latest v3.12-rc kernel?

Also, please provide values of related and affected CPUs, for all CPUs..
Also, just to confirm, you are changing governor to powersave or
performance for all the CPUs??

Otherwise there is no valid reason why this should happen :)
