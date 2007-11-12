From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [RFC] powermac: proper sleep management
Date: Tue, 13 Nov 2007 07:56:38 +1100
Message-ID: <1194900998.18185.57.camel__8867.04324880174$1194901138$gmane$org@pasglop>
References: <Pine.LNX.4.44L0.0711121534070.3128-100000@netrider.rowland.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0711121534070.3128-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Johannes Berg <johannes@sipsolutions.net>, David Woodhouse <dwmw2@infradead.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


On Mon, 2007-11-12 at 15:40 -0500, Alan Stern wrote:
> On Tue, 13 Nov 2007, Benjamin Herrenschmidt wrote:
> 
> > 
> > On Mon, 2007-11-12 at 17:32 +0100, Johannes Berg wrote:
> > > > Looks good to me, +/- a couple of things:
> > > > 
> > > >  - We _REALLY_ want the freezer to be optional and not enabled by
> > > > default on PowerPC. Maybe make it a compile option ?
> > > 
> > > Well, Alan is going to tell you that USB will break. If we need
> > > confirmation for that I can do the test he suggested to you or Paul a
> > > while ago.
> > 
> > Then USB is broken today on powermacs and need to be fixed. We had a
> > clear agreement at KS this year that the freezer was at best a band-aid
> > and that drivers -had- to be fixed to cope regardless.
> 
> More accurately, freezing user tasks is at best a band-aid.  However 
> some kernel threads do need to be frozen, and keeping the freezer 
> around for their use makes sense.  It has less overhead -- I think 
> -- than adding new code to do the freezing in each of these threads.

I remember fixing various issues so that khubd would be safe when non
frozen (among other things) a while ago. Did you guys break it all
again ?

Ben.
