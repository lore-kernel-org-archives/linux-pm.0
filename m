From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] suspend.c: make sure stdin,
	stdout and stderr are open
Date: Sat, 25 Mar 2006 11:54:03 +0100
Message-ID: <200603251154.04186.rjw@sisk.pl>
References: <200603242013.48811.stefan@loplof.de>
	<200603242355.48702.rjw@sisk.pl>
	<200603250920.53471.stefan@loplof.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36191876098531317=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200603250920.53471.stefan@loplof.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Stefan Rompf <stefan@loplof.de>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============36191876098531317==
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k2PB2YDZ001225

On Saturday 25 March 2006 09:20, Stefan Rompf wrote:
> Am Freitag 24 M=C3=A4rz 2006 23:55 schrieb Rafael J. Wysocki:
>=20
> > I've redone your patch a bit, could you please test it?
>=20
> Works nicely, thanks, but why did you move the loop downwards, so that =
it is=20
> executed after reading config and calling into libcrypto?

For no particular reason.  You're right it should go earlier, I'll change=
 that.

> As you asked for the distribution I use, it is SuSE 9.3 on i386, 2.6.16=
 with=20
> some patches (uswsusp, RFC2863-operstate, avoid "udev vc" bloat).

Thanks.  I'm having problems with compiling vbetool on x86_64 SuSE 9.3,
but it's good to know i386 is fine.

Greetings,
Rafael



--===============36191876098531317==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============36191876098531317==--
