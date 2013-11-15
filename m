From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 1/2] Tick: Introduce tick_nohz_check() to check nohz
 enable status
Date: Fri, 15 Nov 2013 12:06:24 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1311151200560.30673@ionos.tec.linutronix.de>
References: <1383036537-30362-1-git-send-email-tianyu.lan@intel.com> <1384504535-29987-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1384504535-29987-1-git-send-email-tianyu.lan@intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: dipankar@in.ibm.com, paulmck@linux.vnet.ibm.com, fweisbec@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, rostedt@goodmis.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 15 Nov 2013, Lan Tianyu wrote:

> In some cases, nohz enable status needs to be checked. E.G, in RCU and cpufreq
> ondemand governor. So add tick_nohz_check() to return tick_nohz_enabled value
> And use tick_nohz_check() instead of referencing tick_nohz_enabled in the rcutree_plugin.h.

What's the point of this? 

Checking for tick_nohz_enabled is wrong to begin with.

See https://lkml.org/lkml/2013/11/13/424
