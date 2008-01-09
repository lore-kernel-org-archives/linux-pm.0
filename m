From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Analysis of sched_mc_power_savings
Date: Wed, 9 Jan 2008 12:35:07 +0100
Message-ID: <20080109113507.GA29721__22630.3355223083$1199878716$gmane$org@elte.hu>
References: <20080108173815.GA7793@dirshya.in.ibm.com>
	<20080108212400.GA8903@linux-os.sc.intel.com>
	<20080109111302.GC7793@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080109111302.GC7793@dirshya.in.ibm.com>
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

> How do we take this technique to the next step where we can 
> consolidate short running jobs as well?  Did you face any difficulty 
> biasing the CPU for short running jobs?

are you sure your measurement tasks do not impact the measurement 
workload? If you use something like 'top' then try running it reniced to 
+19. (or perhaps even bound to a particular CPU, say #3, to make its 
impact isolated)

	Ingo
