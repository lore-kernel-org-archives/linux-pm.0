From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [RFC][PATCH -mm 4/5] swsusp: Add
	PLATFORM_SNAPSHOT and PLATFORM_RESTORE ioctls
Date: Mon, 27 Nov 2006 11:37:20 +0100
Message-ID: <20061127103720.GE13648@elf.ucw.cz>
References: <200611252210.58203.rjw@sisk.pl> <200611252245.28687.rjw@sisk.pl>
	<20061126195110.GE12535@elf.ucw.cz>
	<200611270012.12019.rjw@sisk.pl>
	<20061126232937.GE13647@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061126232937.GE13647@elf.ucw.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2006-11-27 00:29:37, Pavel Machek wrote:
> Hi!
> 
> > > Maybe we should add SNAPSHOT_WITH_FLAGS (uint)
> > >                     RESTORE_WITH_FLAGS (uint)
> > > 
> > > with one of those flags being USE_PLATFORM_MODE? We may need more
> > > flags in future...
> > 
> > Sure, we can do that.
> 
> Okay, that works for me ;-).
> 
> > > ...or maybe have ioctl(fd, USE_PLATFORM_MODE)?
> > 
> > No.  At least I'm not going to implement it. ;-)
> 
> -ELAZY.

(Of course this meant "Pavel is too lazy, so he'll take interface
Rafael _is_ willing to implement").
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
