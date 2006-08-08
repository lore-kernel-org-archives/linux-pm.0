From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 09:42:11 +1000
Message-ID: <200608090942.12404.nigel@suspend2.net>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com>
	<1155080145.26338.130.camel@mindpipe>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0696688038=="
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
In-Reply-To: <1155080145.26338.130.camel@mindpipe>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Mime-version: 1.0
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-pm@osdl.org, pavel@suse.cz, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Suspend2-devel@lists.suspend2.net
List-Id: linux-pm@vger.kernel.org

--===============0696688038==
Content-Type: multipart/signed; boundary="nextPart2559238.HXLSHJF9yQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2559238.HXLSHJF9yQ
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 09 August 2006 09:35, Lee Revell wrote:
> On Tue, 2006-08-08 at 19:31 -0400, Steven Rostedt wrote:
> > On Wed, 9 Aug 2006, Nigel Cunningham wrote:
> > > The problem will be ACPI related, not particular to swsusp or Suspend=
2,
> > > which is why you're seeing it with both implementations. I would
> > > suggest that you contact the ACPI guys, and also look to see whether
> > > there is a bios update available and/or a DSDT override for your
> > > machine. The later will help if the problem is with your particular
> > > machine's ACPI support, the former if it's a more general ACPI issue.
> >
> > Thanks for the response Nigel,
> >
> > There does exist a recent bios update for this machine:
> >
> > http://www-307.ibm.com/pc/support/site.wss/document.do?sitestyle=3Dleno=
vo&l
> >ndocid=3DMIGR-58127
> >
> > Hmm, it requires windows, and I've already wiped out that partition.  I
> > did a search but it seems really scary to update the BIOS via Linux.
> >
> > Anyone else out there have a Thinkpad G41 and has successfully upgraded
> > their BIOS?
>
> I would just report it to the ACPI people.  It's a bug if Linux does not
> work with the same BIOS + DSDT that the other OS works on.

True. I was assuming (perhaps wrongly?) that Steven is interested in both=20
getting the bug fixed and being able to hibernate while he waits for the AC=
PI=20
guys to achieve bug-for-bug compatibility with M$; hence suggesting doing=20
both.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2559238.HXLSHJF9yQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE2SFUN0y+n1M3mo0RAmp5AJ9CRDFqvHngr91z526F0iyBWcbYawCdEVUN
TrPzo1vId+j5GTzpaeJZAhU=
=VE9Y
-----END PGP SIGNATURE-----

--nextPart2559238.HXLSHJF9yQ--


--===============0696688038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Suspend2-devel mailing list
Suspend2-devel@lists.suspend2.net
http://lists.suspend2.net/mailman/listinfo/suspend2-devel

--===============0696688038==--
