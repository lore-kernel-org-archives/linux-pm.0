From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [REGRESSION] Commit a66b2e50 "Preserve sysfs files across suspend/resume" causes a regression in intel_pstate
Date: Thu, 11 Jul 2013 00:04:05 +0200
Message-ID: <20529831.Jz4xYMjFtS@vostro.rjw.lan>
References: <51DD8890.8040008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51DD8890.8040008@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: cpufreq <cpufreq@vger.kernel.org>, srivatsa.bhat@linux.vnet.ibm.com, durgadoss.r@intel.com, "Jarzmik, Robert" <robert.jarzmik@intel.com>, tianyu.lan@intel.com, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 10, 2013 09:15:12 AM Dirk Brandewie wrote:
> Hi All,

Hi,

> Tianyu debugged into https://bugzilla.kernel.org/show_bug.cgi?id=59781 and found
> that commit a66b2e50 is causing the regression.
> 
> Tianyu has proposed a fix (patch attached to bugzilla) but having scaling
> drivers receive hotplug notifications through two paths seems weird.
> 
> Looking at the core code and some of the other scaling drivers
> I don't see an obvious fix.  Maybe adding optional suspend/resume callbacks
> to the scaling driver interface?
> 
> All the scaling drivers that need to do stateful  work in the init/exit
> callbacks are being affected by this change so I think there are other
> subtle side-effects out there that haven't been noticed yet.
> 
> I am not sure how we should proceed here?

Well, first off, I'll queue up a revert of commit a66b2e50, as this was really
about being nice to user space than anything else.  And it has caused subtle
problems to happen already elsewhere.

Then we can figure out how to address the original issue.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
