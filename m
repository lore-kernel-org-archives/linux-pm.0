From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC,5/7] NUMA hotplug emulator
Date: Mon, 17 May 2010 11:39:48 +0200
Message-ID: <4BF10EE4.7020906__6210.27549864284$1274109398$gmane$org@linux.intel.com>
References: <20100513115625.GF2169@shaohui> <20100507141142.GA8696@ucw.cz>
	<20100517033712.GA3075@shaohui>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100517033712.GA3075@shaohui>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>, lethal@linux-sh.org, Nathan Fontenot <nfont@austin.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, akpm@linux-foundation.o
List-Id: linux-pm@vger.kernel.org


> 	
> PowerPC supporting
> 	For ppc, it was added about half year ago by Nathan Fontenot, but x86 does not has such feature.
> Thanks for lethal to mention it, we already did some researching about it,  I will reply it in another
> thread.

Again the probe interface only covers part of the code, not ACPI for example.

-Andi
