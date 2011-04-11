From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [SUBMIT REQUEST] cpupowerutils for linux-next
Date: Mon, 11 Apr 2011 13:57:30 +1000
Message-ID: <20110411135730.a6498f6f.sfr__43979.6636267149$1302494341$gmane$org@canb.auug.org.au>
References: <201104041510.56570.trenn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4962902524923466398=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104041510.56570.trenn@suse.de>
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
To: Thomas Renninger <trenn@suse.de>
Cc: Greg Kroah-Hartman <gregkh@novell.com>, Andreas Herrmann <andreas.herrmann3@amd.com>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============4962902524923466398==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__11_Apr_2011_13_57_30_+1000_jljszJLFS.YLJWKT"

--Signature=_Mon__11_Apr_2011_13_57_30_+1000_jljszJLFS.YLJWKT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, 4 Apr 2011 15:10:56 +0200 Thomas Renninger <trenn@suse.de> wrote:
>
> this is about the recently announced cpupowerutils project
> based on or say an enhancement of the well know
> cpufrequtils project:
> http://www.spinics.net/lists/cpufreq/msg02137.html
>=20
> It's basically cpufrequtils with some cpuidle info additions
> and the Intel only turbostat tool merged into it in a way
> that it can easily get extended for other HW (and got extended
> with some AMD facilities).
>=20
> As there is tools/power/x86 for some time, it would be very
> convenient to get cpupowerutils merged into linux-next (for now)
> into the tools/power/cpupower directory:
> Most of it is directly based on the cpufreq/cpuidle kernel
> subsystem and the output gathered by it should be attached
> to any CPU frequency/idle related kernel bug.
>=20
> Dominik was so kind to add the stuff to his pcmcia git tree
> as cpupowerutils branch.
> Therefore, this can easily be added by pulling from:
> git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git cpupow=
erutils

OK, I have added this tree starting tomorrow.

> Stephen: I added lkml, linux-pm lists and kernel people I know
> working in this area. Please tell me if you can/will just
> pull this or whatever you need to make it happen.

This maens that I will fetch from that tree every day and merge it into
linux-next.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Mon__11_Apr_2011_13_57_30_+1000_jljszJLFS.YLJWKT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNonwqAAoJEDMEi1NhKgbsKF8H/3WyvxuUOdr/UcB8t+WIL4Zs
cRqG7xlSFuZHSMgDnLTWoRxEZa2pDSyGBYaPm50knjmw/KZ6jLGMWMcWkENKFL0M
7+4psFVW8boz/f3OfqBOpSHFMy/CIsd1MCWOkkOYGuwSzuaBnPZXkVqAqfuoveRx
8Pyc8bnkwRK2LYUqoxpxLRgsZJf7f+EOvFnvB1V501Lw8kfpAaY+StUv4KeG2e9Q
rjdNz9y9x2K8I1hlD50VEs4VGx5PMX/uegNAPJ1EBrQS+IkSZi6qXGa2UdncDVYK
qY3bSDUXX6x0MeIXJNKIT3KKJF5Vd9qR4LlWQKlkHXJyH+0aA0Le7/TOaJN9Lvc=
=EixV
-----END PGP SIGNATURE-----

--Signature=_Mon__11_Apr_2011_13_57_30_+1000_jljszJLFS.YLJWKT--

--===============4962902524923466398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4962902524923466398==--
