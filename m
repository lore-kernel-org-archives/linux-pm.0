From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: Analysis of sched_mc_power_savings
Date: Wed, 9 Jan 2008 17:58:47 +0530
Message-ID: <20080109122847.GA28955__12575.8159127601$1199881864$gmane$org@dirshya.in.ibm.com>
References: <20080108173815.GA7793@dirshya.in.ibm.com>
	<20080108212400.GA8903@linux-os.sc.intel.com>
	<20080109111302.GC7793@dirshya.in.ibm.com>
	<20080109113507.GA29721@elte.hu>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080109113507.GA29721@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Chanda Sethia <chanda.sethia@in.ibm.com>, "Siddha,
	Suresh B" <suresh.b.siddha@intel.com>, Linux Kernel <linux-kernel@vger.kernel.org>, discuss@LessWatts.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, tglx@linutronix.de, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

* Ingo Molnar <mingo@elte.hu> [2008-01-09 12:35:07]:

> 
> * Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:
> 
> > How do we take this technique to the next step where we can 
> > consolidate short running jobs as well?  Did you face any difficulty 
> > biasing the CPU for short running jobs?
> 
> are you sure your measurement tasks do not impact the measurement 
> workload? If you use something like 'top' then try running it reniced to 
> +19. (or perhaps even bound to a particular CPU, say #3, to make its 
> impact isolated)

Hi Ingo,

I will watch this during the experiments.  I have been using klog
application to dump relayfs data.  I did run powertop and top as well,
I will bind them to certain CPUs and isolate their impact.

I believe the margin of error would be less since all the measurement
tasks sleep for long duration.

Thanks,
Vaidy
