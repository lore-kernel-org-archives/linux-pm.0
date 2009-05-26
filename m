From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Tue, 26 May 2009 10:43:13 +0200
Message-ID: <20090526084313.GB29563__21331.4222092324$1243327493$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090525123228.GA13446@elf.ucw.cz>
	<1243287557.16743.114.camel@nigel-laptop>
	<200905260029.25847.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905260029.25847.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

On Tue 2009-05-26 00:29:24, Oliver Neukum wrote:
> Am Montag, 25. Mai 2009 23:39:17 schrieb Nigel Cunningham:
> > > If there's not enough swap available, swsusp should freeze, realize
> > > there's no swap, unfreeze and continue. I do not see reliability
> > > problem there.
> >
> > If there's not enough storage available (I'm also thinking of the file
> > allocator Oliver wants), freeing some memory may get you in a position
> 
> No, I do want a dedicated partition. Going to a filesystem is just hiding
> the problem. Filesystems can return -ENOSPC.
> I also want my sytem to reliably hibernate if the filesystem to hold
> the image happens to be remounted ro or to be undergoing a filesystem
> check.
> 
> For full reliability you simply need a reservation. In addition that's
> the fastest solution, too. A simple linear write to an unfragmented
> area.
> The typical system today has three orders of magnitude more disk
> than ram. Do you really have a sytem you want to hibernate that has
> less than 2two orders of magnitude more disk than ram?

My x60 has 60GB disk and 2GB ram. And yes, I'd prefer not to waste 2GB
of disk space...

Yes, linear write is faster, but it the difference will be lost in noise.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
