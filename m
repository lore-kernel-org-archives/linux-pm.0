From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC PATCH 0/1]: timers: Timer Migration
Date: Tue, 16 Sep 2008 06:53:45 -0700
Message-ID: <20080916065345.76d052e1__3926.89780933342$1221573473$gmane$org@infradead.org>
References: <20080916091219.GA1068@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080916091219.GA1068@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: arun@linux.vnet.ibm.com
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, tglx@linutronix.de, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Sep 2008 14:42:31 +0530
Arun R Bharadwaj <arun@linux.vnet.ibm.com> wrote:

> Hi,
> 
> An idle cpu on which device drivers have initialized timers, has to
> be frequently woken up to service the timers. So, consolidation of
> timers onto a fewer number of cpus is important. Migration of timers
> from idle cpus onto lesser idle cpus is necessary. Currently, timers
> are migrated during the cpu offline operation. However cpu-hotplug
> for the sake of idle system power management is too heavy. So, this
> patch implements a lightweight timer migration framework.

while I absolutely like reducing power consumption... I'm not sure this
helps or is the right approach.

First of all, it's of course absolutely better to fix timers and apps
that cause them (and with PowerTOP we fixed basically all the bad
stuff).

Second, in terms of power; a wake up is a wake up, it doesn't really
matter where it happens. 

Now we could do some consolidation (which realistically needs the range
timer feature that's aimed for 2.6.28), but I would much rather do that
in a different way: rather than actively moving stuff, I would instead
suggest sharing the timer queues between logical cpus that share the
same cache. (Now its an admin choice if he wants this on a "shared L1",
"shared L2" or "shared L3" basis). 

Or if you want to forcefully migrate timers, don't move existing ones,
just on queue/requeue put the on not-the-local-cpu. Sure they'll fire
once on the "wrong" cpu, but that's a very short term problem!

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
