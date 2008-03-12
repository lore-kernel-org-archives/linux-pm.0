From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Wed, 12 Mar 2008 15:17:52 -0400
Message-ID: <200803121517.52801.lenb__21556.9929373034$1205349628$gmane$org@kernel.org>
References: <20080303231033.GB15255@one.firstfloor.org>
	<20080311085145.5fcf3186@mjolnir.drzeus.cx>
	<20080311104822.GC18917@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080311104822.GC18917@one.firstfloor.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, LKML <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-list@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Tuesday 11 March 2008, Andi Kleen wrote:
> > I have now found a very hacky workaround that is slightly better than
> > disabling C3 altogether; making C3 exclusive to one core at a time. It
> > seems to kill the noise and the system now spends 50% in C3, instead of
> > 0%.
> 
> I suspect it won't do much of C3 if only one core is idle this way.
> Most likely you just disabled C3 this way in a way invisible to software.

Andi is correct.
C-states are coordinated in hardware.
ie. if both cores enter core-C3, then the hardware allows the package
to enter package C3.

Package C-states are a big deal -- that is where most of the power savings is.

So preventing all the cores from entering C3 at the same time is
the opposite of what we want to be doing.

-Len
