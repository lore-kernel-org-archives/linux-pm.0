From: Andrew Savchenko <bircoph@gmail.com>
Subject: Re: [BUG] 3.7-rc regression bisected: s2disk fails
 to resume image: Processes could not be frozen, cannot continue resuming
Date: Thu, 12 Sep 2013 12:32:17 +0400
Message-ID: <20130912123217.e1764291616cf8e59f0f92b8@gmail.com>
References: <20130812234415.7db639bb0d664e56b6ab2ab2@gmail.com>
	<20130827074843.ba1b6f62cc0a6dca8e47c06c@gmail.com>
	<20130905120811.GC15161@amd.pavel.ucw.cz>
	<2662480.5erkm9ACQI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7640478067503366647=="
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <2662480.5erkm9ACQI@vostro.rjw.lan>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel@lists.sourceforge.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
List-Id: linux-pm@vger.kernel.org

--===============7640478067503366647==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__12_Sep_2013_12_32_17_+0400_vA=0O4DjQlwtfJbC"

--Signature=_Thu__12_Sep_2013_12_32_17_+0400_vA=0O4DjQlwtfJbC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, 05 Sep 2013 14:23:25 +0200 Rafael J. Wysocki wrote:
> On Thursday, September 05, 2013 02:08:11 PM Pavel Machek wrote:
> > Hi!
> >=20
> > Rafael, Al: apparently we have a regression caused by
> > ba4df2808a86f8b103c4db0b8807649383e9bd13 .
>=20
> I noticed that, but I'm not sure how to deal with it.
>=20
> Also, s2disk still works on my test machines, so that seems to be
> specific to this particular configuration.

Is there any way to debug this issue further than just bisecting
commit? Perhaps suspend ioctl should be traced to see why it fails,
but I don't know what exactly inside the kernel should be debugged
and how.

Best regards,
Andrew Savchenko

--Signature=_Thu__12_Sep_2013_12_32_17_+0400_vA=0O4DjQlwtfJbC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJSMXwlAAoJEFZZU7lTcnVstv8P/iZYXjqI1rMeeTk9kohTnDUu
4iXBe3kMOsv/2FAHVQ90AI/WgWYFSv2eDIRYywDt276JsLYIk1EpzO8OpN9nVyaT
Q8FfwXUXUJ4YCz9k+QzvAVN3BVIFIfCz/eqR4MXLBtGAhkL1NzwOIA/HwzK9saZo
KTuRKCM/IS5bx/uQvLvYEN45T02c+EAjuKxvPHKPA48Ea6xnGmQWuT0qXn7k1y93
Mf9N/go3YJ+jkk0mqjpveQpH6bd5CS2p+fDcD/n8w+4+Am9nw6ywuY6jhNzrVNV4
T2f5fwcmvU16dOqR7i+01JKa1xwcb9rRBMTH8L9kCfVhGpW09YZhDPs/Gy6oHXNp
Sy0GoQbtXtujxC3z4U0IM/AAVwN3cJQQVZH1EsdwIkMjbpAkk0tvTOjgjorFs3CP
bEbcOl8DU43PH+FujcRIcuvHFerfyqOi8x9ovcw+sJ4iQQBrs7AFb8dobWIQtbVe
NcGndaikJO2lCTZb/MCgXwlmBfAefDXSUjJssbpvpZ0tCtpcPfWEZwmrcMjJX0d8
/O/0gQ8f2trpufC+IdB+HVOjEXzkD44CUoQN0DkCyz+4MjBjPTlhzFpQ8OV/EIpJ
Trcit+AhE7lKkdbvhB/w4PfBo3A2zdNgWIKlk3/ERXfJZGQmvGemIY3A5A1uOGlk
5FViGZq4H9ZOon8TBH5j
=NP95
-----END PGP SIGNATURE-----

--Signature=_Thu__12_Sep_2013_12_32_17_+0400_vA=0O4DjQlwtfJbC--


--===============7640478067503366647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
--===============7640478067503366647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Suspend-devel mailing list
Suspend-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/suspend-devel

--===============7640478067503366647==--
