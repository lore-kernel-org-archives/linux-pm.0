From: Stefan Rompf <stefan@loplof.de>
Subject: Re: [PATCH] suspend.c: make sure stdin,
	stdout and stderr are open
Date: Sat, 25 Mar 2006 09:20:52 +0100
Message-ID: <200603250920.53471.stefan@loplof.de>
References: <200603242013.48811.stefan@loplof.de>
	<200603242136.56180.rjw@sisk.pl> <200603242355.48702.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12966792539667504=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200603242355.48702.rjw@sisk.pl>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============12966792539667504==
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k2P8KRDZ026047

Am Freitag 24 M=C3=A4rz 2006 23:55 schrieb Rafael J. Wysocki:

> I've redone your patch a bit, could you please test it?

Works nicely, thanks, but why did you move the loop downwards, so that it=
 is=20
executed after reading config and calling into libcrypto?

As you asked for the distribution I use, it is SuSE 9.3 on i386, 2.6.16 w=
ith=20
some patches (uswsusp, RFC2863-operstate, avoid "udev vc" bloat).

Stefan


--===============12966792539667504==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============12966792539667504==--
