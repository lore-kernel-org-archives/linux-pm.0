From: Henrik Austad <henrik@austad.us>
Subject: Re: [Question] AMD opteron can support CPUfreq by per
	core ?
Date: Mon, 3 Nov 2008 15:10:10 +0100
Message-ID: <200811031510.21697.henrik__16258.1834164031$1225727504$gmane$org@austad.us>
References: <28c262360810292306x2f3fb6bag559943c59fa83006@mail.gmail.com>
	<804dabb00810302006x7d59474bg27b716ffadf4515a@mail.gmail.com>
Reply-To: henrik@austad.us
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7789454761311923923=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <804dabb00810302006x7d59474bg27b716ffadf4515a@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: kernelnewbies@nl.linux.org
Cc: linux-pm@lists.linux-foundation.org, Peter Teoh <htmldeveloper@gmail.com>
List-Id: linux-pm@vger.kernel.org

--===============7789454761311923923==
Content-Type: multipart/signed;
  boundary="nextPart3385028.W8BKtd9boQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3385028.W8BKtd9boQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 31 October 2008 04:06:44 Peter Teoh wrote:
> check this out:
>
> http://osdir.com/ml/kernel.cpufreq/2004-07/msg00012.html
>
> from the reply, since the power management flag is at the per-core
> level (check /proc/cpuinfo), all control can be done at the per-core
> level, hard-ware wise.   (not sure of Linux Kernel itself)

This is for intel core2duo, not amd, but to address if the kernel will scal=
e=20
pr core or pr. chip.

On my machine running 2.6.27.7 (standard ubuntu intrepid kernel), it will=20
scale the to cores separatedly:

*snip*
model name      : Intel(R) Core(TM)2 CPU          4300  @ 1.80GHz
*snip*

[ 15:01 ] henrikau@icarus:~  $ cat /proc/cpuinfo  | grep "cpu MHz"
cpu MHz         : 1200.000
cpu MHz         : 1800.000


So, the kernel is capable of scaling each core individually.

> But at least 4 flags must be present (read above email):   ts, ttp, fid,
> vid.

Is this the powernow-technology?

>
> I must also say this is the first time I am aware of these flags too :-).
>
> On Thu, Oct 30, 2008 at 2:06 PM, MinChan Kim <minchan.kim@gmail.com> wrot=
e:
> > Hi,  all,
> >
> > I want to test CPUfreq function in  AMD opteron quad-core series.
> > But I am not sure linux in now can support CPUfreq for ADM opteron by p=
er
> > core ? What I mean is not controling to put together 2 core by one
> > package but control by per core.
> > After all, I want to control all 4 cpu separetely.
> >
> > Is is possible? If it is possible, What kinds of model can support ?
> >
> >  --
> > Kinds regards,
> > MinChan Kim
> >
> > --
> > To unsubscribe from this list: send an email with
> > "unsubscribe kernelnewbies" to ecartis@nl.linux.org
> > Please read the FAQ at http://kernelnewbies.org/FAQ

=2D-=20
med Vennlig Hilsen - Yours Sincerely
Henrik Austad

--nextPart3385028.W8BKtd9boQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkPBkIACgkQ/8Nu36TQ45G3YQCfYDkMqbnwDSDurnmwjLneJPSA
DP4AmwbkqBbF/8v5nupk+txqcnfTLszp
=hX3f
-----END PGP SIGNATURE-----

--nextPart3385028.W8BKtd9boQ--

--===============7789454761311923923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7789454761311923923==--
