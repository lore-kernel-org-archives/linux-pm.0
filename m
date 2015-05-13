From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Thu, 14 May 2015 09:22:51 +1000
Message-ID: <20150514092251.6d0625af@notabene.brown>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
	<20150511014428.GB15721@dastard>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/5ciHcd5XNvObRDyaeJPhAU8"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55009 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965125AbbEMXXB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 May 2015 19:23:01 -0400
In-Reply-To: <20150511014428.GB15721@dastard>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Len Brown <lenb@kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

--Sig_/5ciHcd5XNvObRDyaeJPhAU8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2015 11:44:28 +1000 Dave Chinner <david@fromorbit.com> wrote:

> On Fri, May 08, 2015 at 03:08:43AM -0400, Len Brown wrote:
> > From: Len Brown <len.brown@intel.com>
> >=20
> > Remove sys_sync() from the kernel's suspend flow.
> >=20
> > sys_sync() is extremely expensive in some configurations,
> > and so the kernel should not force users to pay this cost
> > on every suspend.
>=20
> Since when? Please explain what your use case is that makes this
> so prohibitively expensive it needs to be removed.
>=20
> >=20
> > The user-space utilities s2ram and s2disk choose to invoke sync() today.
> > A user can invoke suspend directly via /sys/power/state to skip that co=
st.
>=20
> So, you want to have s2disk write all the dirty pages in memory to
> the suspend image, rather than to the filesystem?
>=20
> Either way you have to write that dirty data to disk, but if you
> write it to the suspend image, it then has to be loaded again on
> resume, and then written again to the filesystem the system has
> resumed. This doesn't seem very efficient to me....
>=20
> And, quite frankly, machines fail to resume from suspne dall the
> time. e.g. run out of batteries when they are under s2ram
> conditions, or s2disk fails because a kernel upgrade was done before
> the s2disk and so can't be resumed. With your change, users lose all
> the data that was buffered in memory before suspend, whereas right
> now it is written to disk and so nothing is lost if the resume from
> suspend fails for whatever reason.
>=20
> IOWs, I can see several good reasons why the sys_sync() needs to
> remain in the suspend code. User data safety and filesystem
> integrity is far, far more important than a couple of seconds
> improvement in suspend speed....

To be honest, this sounds like superstition and fear, not science and fact.

"filesystem integrity" is not an issue for the fast majority of filesystems
which use journalling to ensure continued integrity even after a crash.  I
think even XFS does that :-)

For those few toy filesystems which don't journal, like VFAT and ..... well,
VFAT, it may well make sense for VFAT to request a notification on suspend
and to do whatever is needed to ensure consistent on-storage structures.

"User data safety" is not very closely related to "sys_sync".  That call
doesn't tell my emacs or my libre-office that now is a good time to auto-sa=
ve.
All that "sys_sync" saves is data that has been written-but-not-fsynced.
That is only a small portion of "user data" and anyone who thinks it is
"safe" is already deluded (possibly deluded by over-exposure to ext3).

I am very much in favour of Len's patch.  Not only does the sys_sync()
call have a real cost, but I believe it also has zero value.

Can you identify an actual case where the removal of sys_sync would introdu=
ce
a measurable cost?

NeilBrown

--Sig_/5ciHcd5XNvObRDyaeJPhAU8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVVPcyznsnt1WYoG5AQJ0DhAAo57iBsf6qCwuOIhYc3cA0beBR+gHl0Fi
J0fn0ZH1wbq0lUmN2KIxW9Zy86p2LahotNFPr5jnBIJs0l3oSMGzPC9FcXy8zyA8
qQSVUEm6+tU1HLYAr67BXG2z77g+2MwFDezjV9CWDOBeH/+mQq/wtIZhhoYT6zT0
KI5T4/dc/FC6f1HRIH5nUiKYZdSA2P1vJiFkgGOP8awPNMgr4i0FdHMOpWl8XEAm
nSqK1pUNx92FY3q6QAjc+gDTBclRWsDaZpYGn/fXe90UmwZSYpRX2aHvh6xdL0dW
xrdD4/xaf/HOlrlrsB2cw1gqXHZK/1RIgWk1AIbsBbXEkps9P56ofAT/fP/VXzMi
1SzcHayM11VYQ8sCg4c8b8BjzDz2LPzB6e/BOYM1JJKAa3tmi/zN/xNxCPW0XIy+
udi3Hwn7z688golQYe55er9NCYPLz5XDtXmp9a1gd2yznv5SaAaxUrCPmlv7+nDH
MghtAVA3FcT3wTRNh1Yh36dQVYbt4sYt4VLXLL6wgo+AWzXETDRuylRLsC/4hJp0
IPiJktJIp6Ex3hrk4KCT1rIPWUg26ne+Spk9bUH16dHGhffYRn+/51fBFchbdOnU
ANdkGyUNf1uhj7SfUvd65TykRO/wq7q2crepoamLfNlzxNlMFbgmdiFgAxXFDFRB
Sh9B0c7HdKs=
=Di7G
-----END PGP SIGNATURE-----

--Sig_/5ciHcd5XNvObRDyaeJPhAU8--
