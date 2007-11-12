From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [RFC] powermac: proper sleep management
Date: Mon, 12 Nov 2007 15:40:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711121534070.3128-100000__20540.1510153481$1194900121$gmane$org@netrider.rowland.org>
References: <1194899041.18185.55.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194899041.18185.55.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Johannes Berg <johannes@sipsolutions.net>, David Woodhouse <dwmw2@infradead.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 13 Nov 2007, Benjamin Herrenschmidt wrote:

> 
> On Mon, 2007-11-12 at 17:32 +0100, Johannes Berg wrote:
> > > Looks good to me, +/- a couple of things:
> > > 
> > >  - We _REALLY_ want the freezer to be optional and not enabled by
> > > default on PowerPC. Maybe make it a compile option ?
> > 
> > Well, Alan is going to tell you that USB will break. If we need
> > confirmation for that I can do the test he suggested to you or Paul a
> > while ago.
> 
> Then USB is broken today on powermacs and need to be fixed. We had a
> clear agreement at KS this year that the freezer was at best a band-aid
> and that drivers -had- to be fixed to cope regardless.

More accurately, freezing user tasks is at best a band-aid.  However 
some kernel threads do need to be frozen, and keeping the freezer 
around for their use makes sense.  It has less overhead -- I think 
-- than adding new code to do the freezing in each of these threads.

(It's true that USB drivers in general aren't written to operate in a
freezerless system-suspend environment.  That's a harder problem and
it will have to be fixed driver-by-driver, over time.  The same may be
true for lots of non-USB char device drivers as well.  Pick your 
favorite char device driver: How will it behave if a user task submits 
an I/O request after the device has been suspended?)

Alan Stern
