From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 5 Jun 2010 21:39:31 +0200
Message-ID: <201006052139.31253.rjw__38136.3344648436$1275766814$gmane$org@sisk.pl>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<201006052104.05324.rjw@sisk.pl> <1275765379.1645.532.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275765379.1645.532.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: tytso@mit.edu, Andrew Morton <akpm@linux-foundation.org>, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Saturday 05 June 2010, Peter Zijlstra wrote:
> On Sat, 2010-06-05 at 21:04 +0200, Rafael J. Wysocki wrote:
> > 
> > > I have seen recent proposals that don't require changing the whole
> > > user-space. That might actually be used by other players.
> > 
> > Sure, an approach benefitting more platforms than just Android would be better,
> > but saying that the kernel shouldn't address the Android's specific needs as a
> > rule if no one else has those needs too is quite too far reaching to me. 
> 
> Well, if the android people keep rejecting all sensible approaches to
> power savings except their suspend blocker mess, then I don't see why we
> should support their ill designed mess.

Well, I certainly would like the Android people to be more appreciative of our
ideas if they expect reciprocity.

> We should strive to provide an interface that can be used by all
> interested parties to conserve power; if Android really is the only
> possible user of the interface then I don't see any reason at all to
> merge it, they might as well keep it in their private tree.

There is a number of kernel users that depend on Android user space
(phone vendors using Android on their hardware, but providing their own
drivers), so I don't think we really can identify Android with Google in that
respect.

Rafael
