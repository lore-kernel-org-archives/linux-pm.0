From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [v3.10 regression] deadlock on cpu hotplug
Date: Wed, 10 Jul 2013 11:09:53 +0530
Message-ID: <CAKohpokbo+X5bEYweBuSqr5bkdRsb-XHT7SrMWybwAvkfDsGBQ@mail.gmail.com>
References: <1443144.WnBWEpaopK@amdc1032>
	<51DB724F.9050708@linux.vnet.ibm.com>
	<1754044.EVIH1UZj6p@amdc1032>
	<51DC0B0D.9070201@linux.vnet.ibm.com>
	<51DCDF1C.1000208@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51DCDF1C.1000208@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Wang <wangyun@linux.vnet.ibm.com>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>, Tomasz Figa <t.figa@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10 July 2013 09:42, Michael Wang <wangyun@linux.vnet.ibm.com> wrote:
> I'm not sure what is supposed after notify CPUFREQ_GOV_STOP event, if it
> is in order to stop queued work and prevent follow work happen again,
> then it failed to, and we need some method to stop queue work again when
> CPUFREQ_GOV_STOP notified, like some flag in policy which will be
> checked before re-queue work in work.
>
> But if the event is just to sync the queued work but not prevent follow
> work happen, then things will become tough...we need confirm.

After GOV_STOP, until the time GOV_START is called, we shouldn't be
queuing any work.
