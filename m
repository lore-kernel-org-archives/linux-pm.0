From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 15 May 2015 11:04:17 +1000
Message-ID: <20150515110417.1e3bbe12@notabene.brown>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
	<20150511014428.GB15721@dastard>
	<20150514092251.6d0625af@notabene.brown>
	<20150514235426.GF4316@dastard>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/OFcuHkirrTzFzENhVqayhjQ"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39535 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423318AbbEOBE3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 May 2015 21:04:29 -0400
In-Reply-To: <20150514235426.GF4316@dastard>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Len Brown <lenb@kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

--Sig_/OFcuHkirrTzFzENhVqayhjQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2015 09:54:26 +1000 Dave Chinner <david@fromorbit.com> wrote:

> ng back On Thu, May 14, 2015 at 09:22:51AM +1000, NeilBrown wrote:
> > On Mon, 11 May 2015 11:44:28 +1000 Dave Chinner <david@fromorbit.com> w=
rote:
> >=20
> > > On Fri, May 08, 2015 at 03:08:43AM -0400, Len Brown wrote:
> > > > From: Len Brown <len.brown@intel.com>
> > > >=20
> > > > Remove sys_sync() from the kernel's suspend flow.
> > > >=20
> > > > sys_sync() is extremely expensive in some configurations,
> > > > and so the kernel should not force users to pay this cost
> > > > on every suspend.
> > >=20
> > > Since when? Please explain what your use case is that makes this
> > > so prohibitively expensive it needs to be removed.
> > >=20
> > > >=20
> > > > The user-space utilities s2ram and s2disk choose to invoke sync() t=
oday.
> > > > A user can invoke suspend directly via /sys/power/state to skip tha=
t cost.
> > >=20
> > > So, you want to have s2disk write all the dirty pages in memory to
> > > the suspend image, rather than to the filesystem?
> > >=20
> > > Either way you have to write that dirty data to disk, but if you
> > > write it to the suspend image, it then has to be loaded again on
> > > resume, and then written again to the filesystem the system has
> > > resumed. This doesn't seem very efficient to me....
> > >=20
> > > And, quite frankly, machines fail to resume from suspne dall the
> > > time. e.g. run out of batteries when they are under s2ram
> > > conditions, or s2disk fails because a kernel upgrade was done before
> > > the s2disk and so can't be resumed. With your change, users lose all
> > > the data that was buffered in memory before suspend, whereas right
> > > now it is written to disk and so nothing is lost if the resume from
> > > suspend fails for whatever reason.
> > >=20
> > > IOWs, I can see several good reasons why the sys_sync() needs to
> > > remain in the suspend code. User data safety and filesystem
> > > integrity is far, far more important than a couple of seconds
> > > improvement in suspend speed....
> >=20
> > To be honest, this sounds like superstition and fear, not science and f=
act.
> >=20
> > "filesystem integrity" is not an issue for the fast majority of filesys=
tems
> > which use journalling to ensure continued integrity even after a crash.=
  I
> > think even XFS does that :-)
>=20
> It has nothing to do with journalling, and everything to do with
> bring filesystems to an *idle state* before suspend runs.  We have a
> long history of bug reports with XFS that go: suspend, resume, XFS
> almost immediately detects corruption, shuts down.
>=20
> The problem is that "sync" doesn't make the filesystem idle - XFs
> has *lots* of background work going on, and if we aren't *real
> careful* the filesystem is still doing work while the hardware gets
> powerd down and the suspend image is being taken. the result is on
> resume that the on-disk filesystem state does not match the memory
> image pulled back from resume, and we get shutdowns.
>=20
> sys_sync() does not guarantee a filesystem is idle - it guarantees
> the data in memory is recoverable, butit doesn't stop the filesystem
> from doing things like writing back metadata or running background
> cleaup tasks. If those aren't stopped properly, then we get into
> the state where in-memory and on-disk state get out of whack. And
> s2ram can have these problems too, because if there is IO in flight
> when the hardware is powered down, that IO is lost....

This seems to be the nub of your complaint - yes?

Some storage devices don't handle suspend as well as they should and lose
requests resulting in corruption.  They should obviously be fixed, but it is
you who gets the problem reports and you are not in a position to fix them.
So you want a general solution that hides those problems.
sys_sync at suspend time is a sort-of solution because it flushes and waits
so there  is less in-flight IO immediately after a sys_sync and so less
opportunity for a bad device to stuff up.
But you seem to suggest that sys_sync isn't a complete solution and it
doesn't guarantee that xfs is not doing some background metadata IO.

Maybe a sensible thing to do would be to hook the "disk" devices into suspe=
nd
and have them flush their queue and possibly send a CACHE_FLUSH command.
That would provide more of a guarantee for you, and less of a cost for Len,
would it not?

Thanks,
NeilBrown



>=20
> Every time some piece of generic infrastructure changes behaviour
> w.r.t. suspend/resume, we get a new set of problems being reported
> by users. It's extremely hard to test for these problems and it
> might take months of occasional corruption reports from a user to
> isolate it to being a suspend/resume problem.  It's a game of
> whack-a-mole, because quite often they come down to the fact that
> something changed and nobody in the XFS world knew they had to now
> set an different initialisation flag on some structure or workqueue
> to make it work the way it needed to work.
>=20
> Go back an look at the history of sys_sync() in suspend discussions
> over the past 10 years.  You'll find me saying exactly the same
> thing again and again about sys_sync(): it does not guarantee the
> filesystem is in an idle or coherent, unchanging state, and nothing
> in the suspend code tells the filesystem to enter an idle or frozen
> state. We actually have mechanisms for doing this - we use it in the
> storage layers to idle the filesystem while we do things like *take
> a snapshot*.
>=20
> What is the mechanism suspend to disk uses? It *takes a snapshot* of
> system state, written to disk. It's supposed to be consistent, and
> the only way you can guarantee the state of an active, mounted
> filesystem has consistent in-memory state and on-disk state and
> that it won't get changed is to *freeze the filesystem*.
>=20
> Removing the sync is only going to make this problem worse because
> the delta between on-disk and in-memory state is going to be much,
> much larger. There is also likely to be significant filesystem
> activity occurring when the filesystem has all it's background
> threads and work queues abruptly frozen with no warning or
> co-ordination, which makes it impossible for anyone to test
> suspend/resume reliably.
>=20
> Sorry for the long rant, but I've been saying the same thing for 10
> years, which is abotu as long as I've been dealing with filesystem
> corruptions that have resulted from suspend/resume.
>=20
> Cheers,
>=20
> Dave.


--Sig_/OFcuHkirrTzFzENhVqayhjQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVVVGETnsnt1WYoG5AQLTkw/+JAXJ65SRTbYC2cMI5R9BSGnwheTPj8rW
n7za5hvKhrsA8bKxvMYKGxQxYCv69oN2Ta/KXr5KUdZNb8ItB4A/dNOo7sRBUMFm
o6/CHisqI+WFgiCiDn8JqmjSokM4YiyEGp8vt/pPwVApCWCPBZnvBeYdOfevk/+T
Shd0vYlaR8ePKb+eg8u3YiQ04H2wf/4bmRxN2IQsBPoLrbNmgCewmo2lpmyjqKrf
OFgDf71l0csPNmUEg230oLDVpYMN/L+v5fwlp8KOrDvwcHi02B4MDqBSrp+S6m9V
HXx2s2+ELELvSiNq8K7Voj0k9IdXns2UtrnV4n0DF1KIiylNQzK5lo1pB1FPFrYY
XJjHjN8x4A+A0IdK7dZW/WT+5JHKzoA30qneIbo/iw/vT/a+nAB1YlY/1nnZbEdB
dRrc7f/zJReduJpV8qExGbuaFWSYc1B8qBmyNGk628860Iodt0dceqs7EZORYJCt
EewNIXI4Zg4AkBQ+7gxc3F3mnCAOh8G5/NaqBT1JCUOjVfBSPrOwKnqVI0D67X8T
hZ2y3nQTKspPBN1juT/h9VCIYalBHrGyIeAQhgI1QU8M4jJNpuflo6vSdG4qbsMT
dA/ZPCW3/bWhmMNMgqAH2USb0uC4Ubh1TV+LM7ewVZoLVjmED26h2r3Y5i9JP4EP
B5VWK8TOxU4=
=F183
-----END PGP SIGNATURE-----

--Sig_/OFcuHkirrTzFzENhVqayhjQ--
