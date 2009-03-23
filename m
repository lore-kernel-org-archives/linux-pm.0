From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.29-rc8-git5: Reported regressions from 2.6.28
Date: Mon, 23 Mar 2009 09:23:47 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903230922440.3030__40967.3779890456$1237826175$gmane$org@localhost.localdomain>
References: <GPBuLTara4J.A.3kH.TZTxJB@chimera> <20090321200534.GA30238@elte.hu>
	<20090323005738.GB6003@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090323005738.GB6003@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Nick Piggin <npiggin@suse.de>, Adrian Bunk <bunk@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Kernel Testers List <kernel-testers@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 23 Mar 2009, Wu Fengguang wrote:
> > 
> > I think this was tracked back to the effective halving of 
> > dirty_ratio by 1cf6e7d83 ("mm: task dirty accounting fix") and 
> > doubling the ratio fixed the iozone regression.
> 
> Yes, exactly. The patch for fixing this regression is trivial.

I was planning on applying that patch only after 2.6.29 is out, and then 
if there are no surprising side effects and nobody complains, we'd then 
back-port it into stable.

		Linus
