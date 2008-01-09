From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Analysis of sched_mc_power_savings
Date: Wed, 9 Jan 2008 14:20:14 +0100
Message-ID: <20080109132014.GF27196@elte.hu>
References: <20080108173815.GA7793@dirshya.in.ibm.com>
	<20080108212400.GA8903@linux-os.sc.intel.com>
	<20080109111302.GC7793@dirshya.in.ibm.com>
	<20080109113507.GA29721@elte.hu>
	<20080109122847.GA28955@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080109122847.GA28955@dirshya.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, discuss@LessWatts.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel>
List-Id: linux-pm@vger.kernel.org


* Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:

> I will watch this during the experiments.  I have been using klog 
> application to dump relayfs data.  I did run powertop and top as well, 
> I will bind them to certain CPUs and isolate their impact.
> 
> I believe the margin of error would be less since all the measurement 
> tasks sleep for long duration.

ok, long duration ought to be enough.

i think a possible explanation of your observtions would be this: sleepy 
workloads are affected more by the wakeup logic, and most of the 
power-savings works via runtime balancing.

So perhaps try to add some SD_POWERSAVINGS_BALANCE logic to 
try_to_wake_up()? I think waking up on the same CPU where it went to 
sleep is the most power-efficient approach in general. (or always waking 
up where the wakee runs - this should be measured.) Right now 
try_to_wake_up() tries to spread out load opportunistically, which is 
throughput-maximizing but it's arguably not very power conscious.

	Ingo
