From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH -mm 2/2]: PM: SMP-safe freezer
Date: Mon, 4 Dec 2006 21:43:18 -0800
Message-ID: <200612042143.19264.david-b@pacbell.net>
References: <200612032318.29030.rjw@sisk.pl> <200612041503.04439.rjw@sisk.pl>
	<20061204194401.GA4199@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061204194401.GA4199@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: linux-pm@lists.osdl.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend-devel List <suspend-devel@lists.sourceforge.net>, Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

[ off $SUBJECT ]

On Monday 04 December 2006 11:44 am, Pavel Machek wrote:
> > But I think I'll need to add TIF_FROZEN for all architectures, because suspend
> > to RAM is supposed to work on all of them, isn't it?
> 
> Well, yes, it should be added, but no, I do not think s2ram works on
> that many machines.

Userspace "s2ram" != PM_SUSPEND_MEM ("suspend-to-RAM") though.

I'm not even sure there's a globally acceptable definition of
what PM_SUSPEND_MEM indicates, beyond the fact that one expects
it saves more power than PM_SUSPEND_STANDBY.

Yes, the Documentation/power/states.txt regurgitates ACPI spec text.
But lots of non-ACPI systems don't have any reason to do things
like ACPI says.  And in terms of latency, I've seen a lot of that
be due to the PM framework taking so long to walk the device tree,
with no substantial difference between "standby" and "str" costs.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
