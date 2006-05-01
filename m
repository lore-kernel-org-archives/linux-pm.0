From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Mon, 1 May 2006 11:49:58 +1000
Message-ID: <200605011150.04429.nigel@suspend2.net>
References: <200604242355.08111.rjw@sisk.pl>
	<200604261049.39592.nigel@suspend2.net>
	<200604301427.22687.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============57565404317004332=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604301427.22687.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============57565404317004332==
Content-Type: multipart/signed; boundary="nextPart1871835.EFzUlhTMSJ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1871835.EFzUlhTMSJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

Sorry for the slow response - I only have internet access at work now. This=
 is=20
going to be a pattern for the next few weeks - I'm off work next week and.t=
he=20
week after I'll also be off apart from Monday and Tuesday (those are my las=
t=20
two days working for Cyclades - I then get my sweetheart and little one bac=
k,=20
and we drive down to Victoria over the rest of the week).

On Sunday 30 April 2006 22:27, Rafael J. Wysocki wrote:
> Hi,
>
> On Wednesday 26 April 2006 02:49, Nigel Cunningham wrote:
> > On Wednesday 26 April 2006 08:43, Rafael J. Wysocki wrote:
> > > On Wednesday 26 April 2006 00:25, Pavel Machek wrote:
> > > > > > It does apply to all of the LRU pages. This is what I've been
> > > > > > doing for years now. The only corner case I've come across is
> > > > > > XFS. It still wants to write data even when there's nothing to =
do
> > > > > > and it's threads are frozen (IIRC - haven't looked at it for a
> > > > > > while). I got around that by freezing bdevs when freezing
> > > > > > processes.
> > > > >
> > > > > This means if we freeze bdevs, we'll be able to save all of the L=
RU
> > > > > pages, except for the pages mapped by the current task, without
> > > > > copying.  I think we can try to do this, but we'll need a patch to
> > > > > freeze bdevs for this purpose. ;-)
> > > >
> > > > ...adding more dependencies to how vm/blockdevs work. I'd say curre=
nt
> > > > code is complex enough...
> > >
> > > Well, why don't we see the patch?  If it's too complex, we can just
> > > decide not to use it. :-)
> >
> > In Suspend2, I'm still using a different version of process.c to what y=
ou
> > guys have. In my version, I thaw kernelspace, then thaw bdevs, then thaw
> > userspace. The version below just thaws bdevs after thawing all
> > processes. I think that might need modification, but thought I'd post
> > this now so you can see how complicated or otherwise it is.
>
> IMHO it doesn't look so scary. :-)

:)

> > diff -ruN linux-2.6.17-rc2/kernel/power/process.c
> > bdev-freeze/kernel/power/process.c ---
> > linux-2.6.17-rc2/kernel/power/process.c	2006-04-19 14:27:36.000000000
> > +1000 +++ bdev-freeze/kernel/power/process.c	2006-04-26
> > 10:44:56.000000000 +1000 @@ -19,6 +19,56 @@
> >   */
> >  #define TIMEOUT	(20 * HZ)
> >
> > +struct frozen_fs
> > +{
> > +	struct list_head fsb_list;
> > +	struct super_block *sb;
> > +};
> > +
> > +LIST_HEAD(frozen_fs_list);
> > +
> > +void freezer_make_fses_rw(void)
> > +{
> > +	struct frozen_fs *fs, *next_fs;
> > +
> > +	list_for_each_entry_safe(fs, next_fs, &frozen_fs_list, fsb_list) {
> > +		thaw_bdev(fs->sb->s_bdev, fs->sb);
> > +
> > +		list_del(&fs->fsb_list);
> > +		kfree(fs);
> > +	}
> > +}
> > +
> > +/*
> > + * Done after userspace is frozen, so there should be no danger of
> > + * fses being unmounted while we're in here.
> > + */
> > +int freezer_make_fses_ro(void)
> > +{
> > +	struct frozen_fs *fs;
> > +	struct super_block *sb;
> > +
> > +	/* Generate the list */
> > +	list_for_each_entry(sb, &super_blocks, s_list) {
> > +		if (!sb->s_root || !sb->s_bdev ||
> > +		    (sb->s_frozen =3D=3D SB_FREEZE_TRANS) ||
> > +		    (sb->s_flags & MS_RDONLY))
> > +			continue;
> > +
> > +		fs =3D kmalloc(sizeof(struct frozen_fs), GFP_ATOMIC);
>
> Shouldn't we check for kmalloc() failures here?

Good point. Just because I've never seen it fail, doesn't mean it can't :)

Before I roll a new version, what did you think splitting the thawing and=20
thawing bdevs in the middle? I think it's the right thing (TM) to do :>

Nigel

> > +		fs->sb =3D sb;
> > +		list_add_tail(&fs->fsb_list, &frozen_fs_list);
> > +	};
> > +
> > +	/* Do the freezing in reverse order so filesystems dependant
> > +	 * upon others are frozen in the right order. (Eg loopback
> > +	 * on ext3). */
> > +	list_for_each_entry_reverse(fs, &frozen_fs_list, fsb_list)
> > +		freeze_bdev(fs->sb->s_bdev);
> > +
> > +	return 0;
> > +}
> > +
> >
> >  static inline int freezeable(struct task_struct * p)
> >  {
> > @@ -77,6 +127,7 @@
> >  	printk( "Stopping tasks: " );
> >  	start_time =3D jiffies;
> >  	user_frozen =3D 0;
> > +	bdevs_frozen =3D 0;
> >  	do {
> >  		nr_user =3D todo =3D 0;
> >  		read_lock(&tasklist_lock);
> > @@ -107,6 +158,10 @@
> >  			start_time =3D jiffies;
> >  		}
> >  		user_frozen =3D !nr_user;
> > +
> > +		if (user_frozen && !bdevs_frozen)
> > +			freezer_make_fses_ro();
> > +
> >  		yield();			/* Yield is okay here */
> >  		if (todo && time_after(jiffies, start_time + TIMEOUT))
> >  			break;
> > @@ -156,6 +211,8 @@
> >  			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
> >  	} while_each_thread(g, p);
> >
> > +	freezer_make_fses_rw();
> > +
> >  	read_unlock(&tasklist_lock);
> >  	schedule();
> >  	printk( " done\n" );
>
> Greetings,
> Rafael

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1871835.EFzUlhTMSJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEVWlMN0y+n1M3mo0RAuqOAJ458CoTYI5r+bDnuFnZTywMGNUvxwCdEWeG
NRi0B9Mhb/M1aLnAxtvjjYc=
=4Kko
-----END PGP SIGNATURE-----

--nextPart1871835.EFzUlhTMSJ--

--===============57565404317004332==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============57565404317004332==--
