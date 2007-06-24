From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [RFC][PATCH -mm] PM: Introduce set_target
	method in pm_ops
Date: Sun, 24 Jun 2007 11:52:34 +0200
Message-ID: <1182678754.21939.135.camel__4195.023692637$1182678751$gmane$org@johannes.berg>
References: <Pine.LNX.4.44L0.0706232026460.9663-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0447289803289370467=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706232026460.9663-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <len.brown@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============0447289803289370467==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-YiLWCoipO96/7RQiwSE3"


--=-YiLWCoipO96/7RQiwSE3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-06-23 at 20:28 -0400, Alan Stern wrote:

> Okay.  But on non-ACPI systems, do we want to restrict the=20
> /sys/power/state interface to sleep states?  How then should the user=20
> tell the system to go to a low-performance run state?  Or should that=20
> be handled automatically within the kernel?

The code for pasemi processors/boards has various idle loops right now
that put the processor into different states with different wakeup
latency, these are currently handled with a kernel parameter there.

johannes

--=-YiLWCoipO96/7RQiwSE3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGfj7i/ETPhpq3jKURApNKAJ94pVVOeLOUIsPaaYCzUCzpygtm4QCfbbPI
P0i3l4uLVaAYFV+EdoMn3os=
=5weH
-----END PGP SIGNATURE-----

--=-YiLWCoipO96/7RQiwSE3--


--===============0447289803289370467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0447289803289370467==--
