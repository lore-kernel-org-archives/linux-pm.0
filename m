From: "Li, Zhuangzhi" <zhuangzhi.li@intel.com>
Subject: RE: [PATCH] cpufreq: Align all CPUs to the same frequency if using
 shared clock
Date: Sun, 26 Jan 2014 03:18:01 +0000
Message-ID: <630F9443351D2B4BB7EC6BAE6B6B08342549EE97@SHSMSX104.ccr.corp.intel.com>
References: <1390273543-18032-1-git-send-email-zhuangzhi.li@intel.com>
	<CAKohponL_R8M40BJa3X+++1yDtw5KRvk88w8kVfA+_D+poK08A@mail.gmail.com>
	<630F9443351D2B4BB7EC6BAE6B6B08342549C5DC@SHSMSX104.ccr.corp.intel.com>
	<CAKohpo=ng-B6kLdWxBn_cNsWNVsYaNAD-ZzQLLOfkbj+FDg_fg@mail.gmail.com>
	<CAKohpokHi=yuGJm2Nf-TAMVhGQ8Do02j+s6z3eenKRzoW8pv7g@mail.gmail.com>
	<630F9443351D2B4BB7EC6BAE6B6B08342549CF6A@SHSMSX104.ccr.corp.intel.com>
 <CAKohpokMFwvY-SMcuJf_C_gASQT-8tT8wRrQ6=YX7QQ0YwcgNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47949 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346AbaAZDSE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jan 2014 22:18:04 -0500
In-Reply-To: <CAKohpokMFwvY-SMcuJf_C_gASQT-8tT8wRrQ6=YX7QQ0YwcgNg@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Liu, Chuansheng" <chuansheng.liu@intel.com>



> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Wednesday, January 22, 2014 2:43 PM
> To: Li, Zhuangzhi
> Cc: Rafael J. Wysocki; cpufreq@vger.kernel.org; linux-pm@vger.kernel.org;
> Linux Kernel Mailing List; Liu, Chuansheng
> Subject: Re: [PATCH] cpufreq: Align all CPUs to the same frequency if using
> shared clock
> 
> On 22 January 2014 11:56, Li, Zhuangzhi <zhuangzhi.li@intel.com> wrote:
> > I don't think it's a real bug in bootloader, the bootloader can set
> > CPUs to different frequencies according to actually requirements(Power
> > saving first or Performance first), the CPUs freq policy are initialized in kernel,
> if the kernel want to share one CPU policy(using CPUFREQ_SHARED_TYPE_ALL
> type), it should ensure all CPUs frequencies aligned first, don't depend on the
> bootloader CPUs Pre-states, then the kernel can have better compatibility.
> >
> > If the kernel uses CPUFREQ_SHARED_TYPE_ALL policy, the patch can ensure
> these:
> > 1. If all CPUs are in the same P-state, it does nothing when cpufreq
> > registering 2. If the CPUs are in different P-states, all the other CPUs are
> aligned once to current frequency of CPU0 according to the present policy.
> 
> I thought, as you are asking kernel to keep same freq on all of them, then same
> should be true for bootloaders.
> 
> Otherwise it was okay.
Yes, but most of the platforms(ARM&x86) only enable one CPU Core in bootloader or Bios because of multiple threads(SMP) are not supported, 
and the other Cores stay in default configuration for saving power in bootloader, kernel is responsible for booting up the other Cores from default frequencies for SMP.
Cpufreq driver need to init them to required P-state before governor active when using CPUFREQ_SHARED_TYPE_ALL policy.
