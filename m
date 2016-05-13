From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH-next v2 0/2] cpufreq: powernv: Fixes for Global pstate management
Date: Sat, 14 May 2016 00:08:53 +0200
Message-ID: <2343292.GUrEpiMUq0@vostro.rjw.lan>
References: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com> <20160509153204.GA21661@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53319 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753440AbcEMWF3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2016 18:05:29 -0400
In-Reply-To: <20160509153204.GA21661@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Monday, May 09, 2016 09:02:04 PM Viresh Kumar wrote:
> On 03-05-16, 20:49, Akshay Adiga wrote:
> > Fixes are based on patch https://patchwork.ozlabs.org/patch/612058/ which
> > is in Rafael's linux-next.
> > 
> > - Patch [1] fixes WARN_ON in powernv_target_index()
> > - Patch [2] Deleting any pending timer to saves an unnecessary irq call
> >  in powernv_target_index()
> > 
> > Akshay Adiga (2):
> >   cpufreq: powernv: Move smp_call_function_any() out of irq safe block
> >   cpufreq: powernv: del_timer_sync when global and local pstate are
> >     equal
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Both [1-2/2] applied, thanks!

