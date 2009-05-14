From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Thu, 14 May 2009 11:16:17 +0200
Message-ID: <20090514091616.GB6417__28425.21076459$1242292793$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905090046.21282.rjw@sisk.pl>
	<20090509132711.GD10859@elf.ucw.cz>
	<200905092132.11138.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905092132.11138.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > And we have different ideas about how things should be done. Userspace
> > > > vs kernel space. Providing tuning knobs vs not. And so on.
> > > 
> > > This isn't _that_ important.  Actually, I'm not against an entirely in-kernel
> > > solution, as there are some clear benefits of doing it this way.  We only
> > > need to be careful enough not to break the existing setups.
> > 
> > Would you elaborate?
> 
> One benefit is that we need not anything in the initrd for hibernation to work.
> Another one is that we can get superior performance, for obvious reasons
> (less copying of data, faster I/O).   Yet another is simpler configuration and
> no need to maintain a separate set of user space tools.  I probably could
> find more.
>  
> > I would really hate to put progressbar painting into kernel; and if
> > that's in userspace, we can do compression/encryption there too as
> > well....
> 
> That's correct, we can.  But since we have LZO in the kernel now, we can use
> it for compression just as well, can't we?

Yes, but we do not have progressbar painting in the kernel -- yet --
so users will still need initrd etc.

Yes, we can move LZO into kernel pretty cheaply, and it will have
minor benefit of slightly faster reguler swsusp, but...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
