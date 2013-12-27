From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: intel_pstate divide error with v3.13-rc4-256-gb7000ad
Date: Fri, 27 Dec 2013 15:35:29 +0100
Message-ID: <2312220.jMindkoXyA@vostro.rjw.lan>
References: <CA+5PVA6YpKc6kYK5UiTnGLZpB8uts=-QPtyhotAyZ2kuoG8PPQ@mail.gmail.com> <CAKohpomqHApogDEXA5LyWk-+B-Y1mwNQ63-wL3PPGz64s_3Dmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomqHApogDEXA5LyWk-+B-Y1mwNQ63-wL3PPGz64s_3Dmw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Josh Boyer <jwboyer@fedoraproject.org>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, December 24, 2013 09:36:01 PM Viresh Kumar wrote:
> Adding Dirk..
> 
> On 24 December 2013 20:06, Josh Boyer <jwboyer@fedoraproject.org> wrote:
> > Hi All,
> >
> > We've had a report [1] that the pstate driver causes KVM guests to
> > fail to boot because of a divide error.  See the backtrace below.
> >
> >     4.839784] Intel P-state driver initializing.
> > [    4.859972] Intel pstate controlling: cpu 0
> > [    4.867653] cpufreq: __cpufreq_add_dev: ->get() failed
> 
> After a call to ->init(), ->get() is supposed to work.
> @Dirk: Any idea why it failed?

Well, it looks like sample->freq is 0 in intel_pstate_get().

> And then I don't know what made this divide by zero to happen :)

>From code inspection it looks like that is caused by the
intel_pstate_get_scaled_busy() called from intel_pstate_adjust_busy_pstate(),
so it appears that cpu->pstate.current_state is 0 at that point.

I'm wondering if something like the (untested) patch below helps, then?

Rafael


---
 drivers/cpufreq/intel_pstate.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -652,6 +652,11 @@ static int intel_pstate_init_cpu(unsigne
 	cpu = all_cpu_data[cpunum];
 
 	intel_pstate_get_cpu_pstates(cpu);
+	if (!cpu->pstate.current_state) {
+		all_cpu_data[cpunum] = NULL;
+		kfree(cpu);
+		return -ENODATA;
+	}
 
 	cpu->cpu = cpunum;
 

