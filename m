From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Thu, 13 Mar 2008 11:42:17 +0100
Message-ID: <20080313104217.GH2522__32382.8267319643$1205404924$gmane$org@one.firstfloor.org>
References: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080310100008.GA9520@elf.ucw.cz>
	<20080310134915.45ae7446@mjolnir.drzeus.cx>
	<200803121511.17389.lenb@kernel.org>
	<20080313081048.GB19808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080313081048.GB19808@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, Pierre Ossman <drzeus-list@drzeus.cx>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 13, 2008 at 09:10:48AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > USB keeps processor out of C3 in many cases.
> > > 
> > > I figured that was the case. But I did not see any difference in powertop.
> > 
> > Modern Intel mobile processors have a feature called "C2 popup"
> > that allows the processor to retire DMA from C3 without
> > breaking into C0.  Instead the processor pops up to C2
> > where the cache snoop can allow the DMA to retire --
> > then it returns to C3, all transparent to software.
> 
> Does that mean we should go to C3 on modern intels, even with
> busmaster going on, so that cpu can keep going C2..C3..C2 as needed?

C3 is still more expensive power wise to enter, so entering C3 just
to let it immediately go back to C2 for bus mastering would be likely
still a loss over staying at C2.

-Andi
