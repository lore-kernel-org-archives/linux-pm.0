From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Re: swsusp: which page should be saved?
Date: Tue, 21 Mar 2006 13:33:30 +1000
Message-ID: <200603211333.35035.ncunningham@cyclades.com>
References: <1142481207.26706.16.camel@sli10-desk.sh.intel.com>
	<20060317065937.GH2674@elf.ucw.cz>
	<1142907568.11430.16.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============096020561038290264=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1142907568.11430.16.camel@sli10-desk.sh.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============096020561038290264==
Content-Type: multipart/signed; boundary="nextPart3500211.rgSLn0zAhK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3500211.rgSLn0zAhK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 21 March 2006 12:19, Shaohua Li wrote:
> > Ouch and IIRC top-level pagedir or something
> > like that lives in kernel "text" -- it is in assembly and wrongly
> > placed.
>
> i386 does the right thing and put the pagedir in data segment. x86_64
> not, I think we could clean it up.

Perhaps you could make use of the rotext/data sections? IIRC, there's alrea=
dy=20
a patch in 2.6.16 that enforces the attribute.

Regards,

Nigel

--nextPart3500211.rgSLn0zAhK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEH3QPN0y+n1M3mo0RAuIHAJ9ImVJNtxJBYpA2smwqs0zhLleNmQCePa/K
4P0RCdaax1UGVlq7ApG2Z/c=
=390K
-----END PGP SIGNATURE-----

--nextPart3500211.rgSLn0zAhK--

--===============096020561038290264==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============096020561038290264==--
