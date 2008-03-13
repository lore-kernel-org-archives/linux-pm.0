From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Thu, 13 Mar 2008 09:10:48 +0100
Message-ID: <20080313081048.GB19808__47558.343402534$1205403473$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080310100008.GA9520@elf.ucw.cz>
	<20080310134915.45ae7446@mjolnir.drzeus.cx>
	<200803121511.17389.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803121511.17389.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, Pierre Ossman <drzeus-list@drzeus.cx>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > USB keeps processor out of C3 in many cases.
> > 
> > I figured that was the case. But I did not see any difference in powertop.
> 
> Modern Intel mobile processors have a feature called "C2 popup"
> that allows the processor to retire DMA from C3 without
> breaking into C0.  Instead the processor pops up to C2
> where the cache snoop can allow the DMA to retire --
> then it returns to C3, all transparent to software.

Does that mean we should go to C3 on modern intels, even with
busmaster going on, so that cpu can keep going C2..C3..C2 as needed?

> if you disable it at run-time, Linux puts it in C1.  If you never
> boot it in the first place (eg. maxcpusp=1), the BIOS leaves it in
> the deepest available C-sate.

It would be nice to fix this BTW. offlined cpu in C1 eats too much
power, and makes measurements on the second core impossible...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
