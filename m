From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 2/2]: PM: SMP-safe freezer
Date: Mon, 4 Dec 2006 20:56:36 +0100
Message-ID: <200612042056.36927.rjw@sisk.pl>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, 4 December 2006 20:44, Pavel Machek wrote:
> Hi!
> 
> > > > To solve first of these problems we need to stop using PF_FROZEN to tell
> > > > tasks that they should go to the refrigerator.  Instead, we can introduce
> > > > a special TIF_*** flag and use it for this purpose, since it is allowed to
> > > > change the other tasks' TIF_*** flags and there are special calls for it.
> > > > 
> > > > To avoid the freeze_process()-refrigerator() race we can make freeze_process()
> > > > to always check the task's PF_FROZEN flag after it's read its "freeze" flag.
> > > > We should also make sure that refrigerator() will always reset the task's
> > > > "freeze" flag after it's set PF_FROZEN for it.
> > > > 
> > > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > ACK.
> > 
> > But I think I'll need to add TIF_FROZEN for all architectures, because suspend
> > to RAM is supposed to work on all of them, isn't it?
> 
> Well, yes, it should be added, but no, I do not think s2ram works on
> that many machines.

So, do you think I should add any more architectures (which ones?) or leave it
as is?

> > Also, this patch is only sufficient with [1/2] or an alternative solution?
> 
> I haven't finished looking at that one. I suspect it is okay, but I'm
> not sure it is enough.

Well, I think I haven't overlooked anything, but of course that's always
possible. ;-)

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
