From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Tue, 26 May 2009 10:28:28 +1000
Message-ID: <1243297708.16743.149.camel__29088.1217144944$1243297673$gmane$org@nigel-laptop>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090525123228.GA13446@elf.ucw.cz>
	<1243287557.16743.114.camel@nigel-laptop>
	<200905260029.25847.oliver@neukum.org>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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

Hi.

On Tue, 2009-05-26 at 00:29 +0200, Oliver Neukum wrote:
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

I agree that a dedicated non-swap partition has advantages. The only
disadvantage I can think of is resizing it if you buy more RAM (and
since that's not going to happen often, it's not a biggie).

I'm not sure that going to a filesystem is hiding the problem though -
whatever solution you adopt, there can be situations in which space
available < space needed. Dedicated non-swap certainly has the least
difficulties, but least != none.

I want flexibility, because different people have different situations
and needs. You might care about a dedicated partition. Another person
might be putting their toe in the Linux water, dual booting with 80% of
the HDD in M$ and having insufficient space to shuffle Linux data around
to make the partition.

Read only filesystems aren't a problem, by the way. So long as you can
bmap the file, that's enough for TuxOnIce - it doesn't currently expand
files - just bmaps and writes directly to the blocks (not via the fs
layer). That's simpler because you _have_ to do the same approach in
reverse at resume time.

Regards,

Nigel
