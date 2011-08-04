From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM / Freezer: Freeze filesystems along
	with freezing processes (was: Re: PM / hibernate xfs lock up
	/ xfs_reclaim_inodes_ag)
Date: Fri, 5 Aug 2011 00:25:09 +0200
Message-ID: <201108050025.09792.rjw__25167.2386577868$1312496692$gmane$org@sisk.pl>
References: <4E1C70AD.1010101@u-club.de> <20110803172922.GA2126@ucw.cz>
	<201108041127.30944.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108041127.30944.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph <cr2005@u-club.de>, Theodore Ts'o <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>, LKML <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com, Christoph Hellwig <hch@infradead.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-ext4@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, August 04, 2011, Rafael J. Wysocki wrote:
> On Wednesday, August 03, 2011, Pavel Machek wrote:
> > Hi!
> > 
> > > Freeze all filesystems during the freezing of tasks by calling
> > > freeze_bdev() for each of them and thaw them during the thawing
> > > of tasks with the help of thaw_bdev().
> > > 
> > > This is needed by hibernation, because some filesystems (e.g. XFS)
> > > deadlock with the preallocation of memory used by it if the memory
> > > pressure caused by it is too heavy.
> > > 
> > > The additional benefit of this change is that, if something goes
> > > wrong after filesystems have been frozen, they will stay in a
> > > consistent state and journal replays won't be necessary (e.g. after
> > > a failing suspend or resume).  In particular, this should help to
> > > solve a long-standing issue that in some cases during resume from
> > > hibernation the boot loader causes the journal to be replied for the
> > > filesystem containing the kernel image and initrd causing it to
> > > become inconsistent with the information stored in the hibernation
> > > image.
> > 
> > > +/**
> > > + * freeze_filesystems - Force all filesystems into a consistent state.
> > > + */
> > > +void freeze_filesystems(void)
> > > +{
> > > +	struct super_block *sb;
> > > +
> > > +	lockdep_off();
> > 
> > Ouch. So... why do we need to silence this?
> 
> So that it doesn't complain? :-)
> 
> I'll need some time to get the exact details here.

So, this is because ext3_freeze() that doesn't call
journal_unlock_updates() on success, which quite frankly looks like
a bug in ext3 to me.  At least that's different from what ext4 does
in exactly the same situation (which looks correct).

If ext3_freeze() called journal_unlock_updates() on success too and
the call to journal_unlock_updates() is removed from ext3_unfreeze(),
we wouldn't need that lockdep_off()/lockdep_on() around the loop.

I need someone with ext3/ext4 knowledge to comment here, though.

Moreover, I'm not sure if other filesystems don't do such things.

Anyway, this is just a false-positive, even with the ext3 code as is.

> > > +	/*
> > > +	 * Freeze in reverse order so filesystems dependant upon others are
> > > +	 * frozen in the right order (eg. loopback on ext3).
> > > +	 */
> > > +	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
> > > +		if (!sb->s_root || !sb->s_bdev ||
> > > +		    (sb->s_frozen == SB_FREEZE_TRANS) ||
> > > +		    (sb->s_flags & MS_RDONLY) ||
> > > +		    (sb->s_flags & MS_FROZEN))
> > > +			continue;
> > 
> > Should we stop NFS from modifying remote server, too?
> 
> What do you mean exactly?
> 
> > Plus... ext3 writes to read-only filesystems on mount; not sure if it
> > does it later. But RDONLY means 'user cant write to it' not 'bdev will
> > not be modified'. Should we freeze all?
> > 
> > How can 'already frozen' happen?
> > 
> > > +	list_for_each_entry(sb, &super_blocks, s_list)
> > > +		if (sb->s_flags & MS_FROZEN) {
> > > +			sb->s_flags &= ~MS_FROZEN;
> > > +			thaw_bdev(sb->s_bdev, sb);
> > > +		}
> > 
> > ...because we'll unfreeze it even if we did not freeze it...
> 
> So we need not check MS_FROZEN in freeze_filesystems().  OK

Thanks,
Rafael
