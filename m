From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Mon, 1 May 2006 13:20:49 +0200
Message-ID: <200605011320.50256.rjw@sisk.pl>
References: <200604242355.08111.rjw@sisk.pl> <200604301427.22687.rjw@sisk.pl>
	<200605011150.04429.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============84411167539719489=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200605011150.04429.nigel@suspend2.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Linux PM <linux-pm@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============84411167539719489==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[Dropped Nick and LKML from the Cc list.]

Hi,

On Monday 01 May 2006 03:49, Nigel Cunningham wrote:
> Hi.
> 
> Sorry for the slow response - I only have internet access at work now.

No problem at all. :-)

> This is  going to be a pattern for the next few weeks - I'm off work next
> week and.the week after I'll also be off apart from Monday and Tuesday
> (those are my last two days working for Cyclades - I then get my sweetheart
> and little one back, and we drive down to Victoria over the rest of the week).
> 
> On Sunday 30 April 2006 22:27, Rafael J. Wysocki wrote:
> > On Wednesday 26 April 2006 02:49, Nigel Cunningham wrote:
> > > On Wednesday 26 April 2006 08:43, Rafael J. Wysocki wrote:
> > > > On Wednesday 26 April 2006 00:25, Pavel Machek wrote:
> > > > > > > It does apply to all of the LRU pages. This is what I've been
> > > > > > > doing for years now. The only corner case I've come across is
> > > > > > > XFS. It still wants to write data even when there's nothing to do
> > > > > > > and it's threads are frozen (IIRC - haven't looked at it for a
> > > > > > > while). I got around that by freezing bdevs when freezing
> > > > > > > processes.
> > > > > >
> > > > > > This means if we freeze bdevs, we'll be able to save all of the LRU
> > > > > > pages, except for the pages mapped by the current task, without
> > > > > > copying.  I think we can try to do this, but we'll need a patch to
> > > > > > freeze bdevs for this purpose. ;-)
> > > > >
> > > > > ...adding more dependencies to how vm/blockdevs work. I'd say current
> > > > > code is complex enough...
> > > >
> > > > Well, why don't we see the patch?  If it's too complex, we can just
> > > > decide not to use it. :-)
> > >
> > > In Suspend2, I'm still using a different version of process.c to what you
> > > guys have. In my version, I thaw kernelspace, then thaw bdevs, then thaw
> > > userspace. The version below just thaws bdevs after thawing all
> > > processes. I think that might need modification, but thought I'd post
> > > this now so you can see how complicated or otherwise it is.
> >
> > IMHO it doesn't look so scary. :-)
> 
> :)
> 
> > > diff -ruN linux-2.6.17-rc2/kernel/power/process.c
> > > bdev-freeze/kernel/power/process.c ---
> > > linux-2.6.17-rc2/kernel/power/process.c	2006-04-19 14:27:36.000000000
> > > +1000 +++ bdev-freeze/kernel/power/process.c	2006-04-26
> > > 10:44:56.000000000 +1000 @@ -19,6 +19,56 @@
> > >   */
> > >  #define TIMEOUT	(20 * HZ)
> > >
> > > +struct frozen_fs
> > > +{
> > > +	struct list_head fsb_list;
> > > +	struct super_block *sb;
> > > +};
> > > +
> > > +LIST_HEAD(frozen_fs_list);
> > > +
> > > +void freezer_make_fses_rw(void)
> > > +{
> > > +	struct frozen_fs *fs, *next_fs;
> > > +
> > > +	list_for_each_entry_safe(fs, next_fs, &frozen_fs_list, fsb_list) {
> > > +		thaw_bdev(fs->sb->s_bdev, fs->sb);
> > > +
> > > +		list_del(&fs->fsb_list);
> > > +		kfree(fs);
> > > +	}
> > > +}
> > > +
> > > +/*
> > > + * Done after userspace is frozen, so there should be no danger of
> > > + * fses being unmounted while we're in here.
> > > + */
> > > +int freezer_make_fses_ro(void)
> > > +{
> > > +	struct frozen_fs *fs;
> > > +	struct super_block *sb;
> > > +
> > > +	/* Generate the list */
> > > +	list_for_each_entry(sb, &super_blocks, s_list) {
> > > +		if (!sb->s_root || !sb->s_bdev ||
> > > +		    (sb->s_frozen == SB_FREEZE_TRANS) ||
> > > +		    (sb->s_flags & MS_RDONLY))
> > > +			continue;
> > > +
> > > +		fs = kmalloc(sizeof(struct frozen_fs), GFP_ATOMIC);
> >
> > Shouldn't we check for kmalloc() failures here?
> 
> Good point. Just because I've never seen it fail, doesn't mean it can't :)
> 
> Before I roll a new version, what did you think splitting the thawing and 
> thawing bdevs in the middle? I think it's the right thing (TM) to do :>

Do you mean to thaw kernel threads first, thaw bdevs next and thaw user
space processes at the end?  I think it should be done in that order if
the bdevs are frozen.

Greetings,
Rafael

--===============84411167539719489==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============84411167539719489==--
