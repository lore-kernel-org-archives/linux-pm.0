From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: powersave governor runs programs faster and uses more power than
 performance governor
Date: Fri, 25 Oct 2013 07:40:12 -0700
Message-ID: <526A82CC.1040709@gmail.com>
References: <CAMeUXYuuM4LS2qAhhvQi8VG1bK4eiZjjTikchgHzeqi2EX6=bw@mail.gmail.com>	<CAOh2x==D_niGhi-fSSW18WQZjEQU+FngvVCB_K+y+3BRfaz96A@mail.gmail.com> <CAMeUXYuQobSo7Au07V2KBE6=mAqXW1Hj--G92FP0X1H97Kv8OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAMeUXYuQobSo7Au07V2KBE6=mAqXW1Hj--G92FP0X1H97Kv8OA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Melanie Kambadur <melanie@cs.columbia.edu>, Viresh Kumar <viresh.kumar@linaro.org>, David C Niemi <dniemi@verisign.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10/24/2013 12:42 PM, Melanie Kambadur wrote:
>
>  From /sys/devices/system/cpu/cpuN/cpufreq/scaling_driver I get that
> the current p-state driver is called "intel_pstate". David, you
> mention that the firmware governors are not very efficient, do you
> suggest replacing the intel_pstate driver with a different driver?

I will need to look and see why changing to performance isn't working
correctly.

To get the behavior of the performance governor you can use

    echo 100 > /sys/devices/system/cpu/intel_pstate/min_perf_pct

This will force intel_pstate to select the highest P state and
leave it there.

Turbostat is useful for collecting frequency (P state) and idle (C state)
information.

--Dirk


