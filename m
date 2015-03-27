From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: powernv: Add checks to report cpu frequency
 throttling conditions
Date: Fri, 27 Mar 2015 12:14:45 +0530
Message-ID: <CAKohpo=YN=M3QDLkLAS_UwbtpHDjeseQYkj1M8V0myEiHOaPcQ@mail.gmail.com>
References: <1427395282-31875-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
	<CAKohpokXx+PfBo7vDVcfLS1R1+5j7MaDHxK6QG+vtaG9LgSS4w@mail.gmail.com>
	<5514F97A.4000302@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5514F97A.4000302@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27 March 2015 at 12:02, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
> The power and thermal safety of the system is taken care by an
> On-Chip-Controller (OCC) which is real-time subsystem embedded within the POWER8
> processor. OCC continuously monitors the memory and core temperature, the total
> system power, state of power supply and fan.
>
> The cpu frequency can be throttled for the following reason:
> 1)If a processor crosses its power and temperature limit then OCC will lower its
> Pmax to reduce the frequency and voltage.
> 2)If OCC crashes then the system is forced to Psafe frequency.
> 3)If OCC fails to recover then the kernel is not allowed to do any further
> frequency changes and the chip will remain in Psafe.
>
> The user can see a drop in performance when frequency is throttled and is
> unaware of throttling. So we want to report such a condition so that user can
> check the OCC status to reboot the system or check for power supply or fan failures.

All these details are required to be part of the commit, so that reviewers can
understand it better.
