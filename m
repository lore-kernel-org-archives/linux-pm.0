From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: Re: standby to disk transition
Date: Tue, 14 Mar 2006 09:11:54 +1000
Message-ID: <200603140912.01502.nigel@suspend2.net>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<20060313220811.GL10348@elf.ucw.cz>
	<200603132342.37691.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============64484623150554654=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200603132342.37691.rjw@sisk.pl>
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
Cc: linux-pm@osdl.org, linux-pm@lists.osdl.org, "Victor Porton, , ,
	" <porton@ex-code.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============64484623150554654==
Content-Type: multipart/signed; boundary="nextPart8164138.tzVE4FZEVT";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8164138.tzVE4FZEVT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 14 March 2006 08:42, Rafael J. Wysocki wrote:
> On Monday 13 March 2006 23:08, Pavel Machek wrote:
> > > >  > Yep, I call that suspend-to-both. It is planned, but not really
> > > >  > trivial, and I'm a little busy. If someone wants to help....
> > > >
> > > > I was thinking a few days ago. With your move of all this stuff to
> > > > userspace, if it was done in multiple stages, we could implement
> > > > a form of checkpointing this way.
> > > >
> > > > So instead of doing the 'suspend to disk/ram' after 'write out all
> > > > pages', we just continue.
> > > >
> > > > Why is this useful ?  We've seen bugs reported that only ever bite
> > > > customers after they've run their workload for a month.  Now, if th=
ey
> > > > had a means of checkpointing, then when it crashes, they could
> > > > capture the last image that landed somewhere, and set that up for
> > > > more tests/monitoring with kprobes etc and reproduce those
> > > > hard-to-reproduce bugs a lot faster.
> > >
> > > I've been asked about this from time to time too. Apart from the issu=
es
> > > Pavel has already mentioned, the big problem in my mind was figuring
> > > out what to do about disk storage. As the algorithm stands at the
> > > moment, the image includes information about the state of mounted
> > > filesystems. We'd need to somehow get rid of or be able to ignore tha=
t.
> > > Any suggestions?
> >
> > Well, copying all the filesystems would work, as would having no
> > filesystems at all :-) [ramdisk case]. And perhaps practical
> > equivalent of "copy all filesystems" can be done with device mapper.
> >
> > [Of course, you'd have to copy all the filesystems back before doing
> > resume].
>
> If we had anything like fs suspend/resume, we could handle such things.
> We could also handle the "USB device mounted before suspend" problem
> (I think it's related).

Well, we have bdev freezing, which I guess is what is used for fixing up ra=
id=20
mirrors (but don't know for certain). I use it in refrigerating to get XFS =
to=20
really stop activity. I don't think it helps in this case though:

We need to be able to rollback the state of the filesystem in memory and on=
=20
disk to the point where the last checkpoint was made. Memory would be=20
straight forward if we want to do it dumbly and slowly - just reload the=20
whole check pointed image. If we want to be more efficient, we'd want to ju=
st=20
load the pages that had changed (Mark on (first) write?). But filesystems=20
seem to be a whole different story. Do any of the commonly used fses have=20
support for checkpointing and rollback back at the moment?

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart8164138.tzVE4FZEVT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEFfxBN0y+n1M3mo0RAkzRAKCqKHgUfCT1M6yjYWurBVi2TVJtIACgg3iP
fOTdxbUVeZ64gO9d9psUgVo=
=9olD
-----END PGP SIGNATURE-----

--nextPart8164138.tzVE4FZEVT--

--===============64484623150554654==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============64484623150554654==--
