From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [LOCKDEP] cpufreq: possible circular locking dependency detected
Date: Fri, 28 Jun 2013 10:13:14 +0530
Message-ID: <CAKohpo=ij+LTB80FtVFQZa_4uh-fceG80GBhGnhbxKio7N-Zuw@mail.gmail.com>
References: <20130625211544.GA2270@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130625211544.GA2270@swordfish>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Michael Wang <wangyun@linux.vnet.ibm.com>, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 26 June 2013 02:45, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>
> [   60.277396] ======================================================
> [   60.277400] [ INFO: possible circular locking dependency detected ]
> [   60.277407] 3.10.0-rc7-dbg-01385-g241fd04-dirty #1744 Not tainted
> [   60.277411] -------------------------------------------------------
> [   60.277417] bash/2225 is trying to acquire lock:
> [   60.277422]  ((&(&j_cdbs->work)->work)){+.+...}, at: [<ffffffff810621b5>] flush_work+0x5/0x280
> [   60.277444]
> but task is already holding lock:
> [   60.277449]  (cpu_hotplug.lock){+.+.+.}, at: [<ffffffff81042d8b>] cpu_hotplug_begin+0x2b/0x60
> [   60.277465]
> which lock already depends on the new lock.

Hi Sergey,

Can you try reverting this patch?

commit 2f7021a815f20f3481c10884fe9735ce2a56db35
Author: Michael Wang <wangyun@linux.vnet.ibm.com>
Date:   Wed Jun 5 08:49:37 2013 +0000

    cpufreq: protect 'policy->cpus' from offlining during __gov_queue_work()
