From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Fri, 14 Mar 2008 00:13:58 -0400
Message-ID: <200803140013.59146.lenb__48543.1652552963$1205468263$gmane$org@kernel.org>
References: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080313081048.GB19808@elf.ucw.cz>
	<20080313104217.GH2522@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080313104217.GH2522@one.firstfloor.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Lee Revell <rlrevell@joe-job.com>, Pierre Ossman <drzeus-list@drzeus.cx>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 13 March 2008, Andi Kleen wrote:
> On Thu, Mar 13, 2008 at 09:10:48AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > > USB keeps processor out of C3 in many cases.
> > > > 
> > > > I figured that was the case. But I did not see any difference in powertop.
> > > 
> > > Modern Intel mobile processors have a feature called "C2 popup"
> > > that allows the processor to retire DMA from C3 without
> > > breaking into C0.  Instead the processor pops up to C2
> > > where the cache snoop can allow the DMA to retire --
> > > then it returns to C3, all transparent to software.
> > 
> > Does that mean we should go to C3 on modern intels, even with
> > busmaster going on, so that cpu can keep going C2..C3..C2 as needed?

That decision has already been made for us.
BM_STS has been made a no-op on recent processors.
It reports bus activity only for a small sub-set of
south-bridge devices.  Otherwise it tells us there
is none and that we should proceed into C3.

> C3 is still more expensive power wise to enter, so entering C3 just
> to let it immediately go back to C2 for bus mastering would be likely
> still a loss over staying at C2.

The newer the processor, the less exposed we area to this scenario.

cheers,
-Len
