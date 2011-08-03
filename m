From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] PM / Freezer: Freeze filesystems along
 with freezing processes (was: Re: PM / hibernate xfs lock up /
 xfs_reclaim_inodes_ag)
Date: Wed, 3 Aug 2011 19:29:22 +0200
Message-ID: <20110803172922.GA2126__27240.1736620397$1312437788$gmane$org@ucw.cz>
References: <4E1C70AD.1010101@u-club.de> <20110727103308.GA20805@infradead.org>
	<4E300317.7090108@tuxonice.net> <201108032315.06012.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108032315.06012.rjw@sisk.pl>
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
Cc: Christoph <cr2005@u-club.de>, Dave Chinner <david@fromorbit.com>, LKML <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com, Christoph Hellwig <hch@infradead.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Freeze all filesystems during the freezing of tasks by calling
> freeze_bdev() for each of them and thaw them during the thawing
> of tasks with the help of thaw_bdev().
> 
> This is needed by hibernation, because some filesystems (e.g. XFS)
> deadlock with the preallocation of memory used by it if the memory
> pressure caused by it is too heavy.
> 
> The additional benefit of this change is that, if something goes
> wrong after filesystems have been frozen, they will stay in a
> consistent state and journal replays won't be necessary (e.g. after
> a failing suspend or resume).  In particular, this should help to
> solve a long-standing issue that in some cases during resume from
> hibernation the boot loader causes the journal to be replied for the
> filesystem containing the kernel image and initrd causing it to
> become inconsistent with the information stored in the hibernation
> image.

> +/**
> + * freeze_filesystems - Force all filesystems into a consistent state.
> + */
> +void freeze_filesystems(void)
> +{
> +	struct super_block *sb;
> +
> +	lockdep_off();

Ouch. So... why do we need to silence this?

> +	/*
> +	 * Freeze in reverse order so filesystems dependant upon others are
> +	 * frozen in the right order (eg. loopback on ext3).
> +	 */
> +	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
> +		if (!sb->s_root || !sb->s_bdev ||
> +		    (sb->s_frozen == SB_FREEZE_TRANS) ||
> +		    (sb->s_flags & MS_RDONLY) ||
> +		    (sb->s_flags & MS_FROZEN))
> +			continue;

Should we stop NFS from modifying remote server, too?

Plus... ext3 writes to read-only filesystems on mount; not sure if it
does it later. But RDONLY means 'user cant write to it' not 'bdev will
not be modified'. Should we freeze all?

How can 'already frozen' happen?

> +	list_for_each_entry(sb, &super_blocks, s_list)
> +		if (sb->s_flags & MS_FROZEN) {
> +			sb->s_flags &= ~MS_FROZEN;
> +			thaw_bdev(sb->s_bdev, sb);
> +		}

...because we'll unfreeze it even if we did not freeze it...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
