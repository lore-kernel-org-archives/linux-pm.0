From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"
 again
Date: Fri, 10 Nov 2017 08:25:13 +0100
Message-ID: <20171110072513.mp5p7o7pledumoyi@gmail.com>
References: <20171109103814.70688-1-chao.wang@ucloud.cn>
 <6583ed1f-3ea3-c7fd-7e69-1430c8387e54@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:52761 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdKJHZS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Nov 2017 02:25:18 -0500
Content-Disposition: inline
In-Reply-To: <6583ed1f-3ea3-c7fd-7e69-1430c8387e54@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: WANG Chao <chao.wang@ucloud.cn>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>


* Rafael J. Wysocki <rafael.j.wysocki@intel.com> wrote:

> Hi Linus,
> 
> On 11/9/2017 11:38 AM, WANG Chao wrote:
> > Commit 941f5f0f6ef5 (x86: CPU: Fix up "cpu MHz" in /proc/cpuinfo) caused
> > a serious performance issue when reading from /proc/cpuinfo on system
> > with aperfmperf.
> > 
> > For each cpu, arch_freq_get_on_cpu() sleeps 20ms to get its frequency.
> > On a system with 64 cpus, it takes 1.5s to finish running `cat
> > /proc/cpuinfo`, while it previously was done in 15ms.
> 
> Honestly, I'm not sure what to do to address this ATM.
> 
> The last requested frequency is only available in the non-HWP case, so it
> cannot be used universally.

This is a serious regression that needs to be fixed ASAP, because the slowdown is 
utterly ridiculous on a 120 CPU system:

  fomalhaut:~> time cat /proc/cpuinfo  >/dev/null

  real    0m2.689s
  user    0m0.001s
  sys     0m0.007s

Thanks,

	Ingo
