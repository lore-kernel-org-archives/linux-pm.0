From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH v3 2/4] ARM: bcm2835: add rpi power domain driver
Date: Wed, 16 Dec 2015 02:11:11 +0100
Message-ID: <20151216011110.GA13147@earth>
References: <1450215622-27394-1-git-send-email-eric@anholt.net>
 <1450215622-27394-3-git-send-email-eric@anholt.net>
 <567093CD.1020208@gmail.com> <87oadrmfmi.fsf@eliezer.anholt.net>
 <5670AAB2.1080102@gmail.com> <87mvtbkyd0.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3053096730522145668=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87mvtbkyd0.fsf@eliezer.anholt.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============3053096730522145668==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 15, 2015 at 04:53:31PM -0800, Eric Anholt wrote:
> >>> What motivated the location of this power domain driver in
> >>> arch/arm/mach-bcm? Should not we have this in drivers/power/ or
> >>> somewhere in drivers/ at the very least?
> >>=20
> >> ls stronly suggests that power contains drivers for power supplies and
> >> batteries, not power domains.

Indeed it's used for fuel gauges and chargers, but also for
reboot/powerdown and adaptive voltage scaling, so another
subdirectory for power-domains wouldn't be that odd.

> >> There are 6 power domain drivers in
> >> arch/arm, 3 in drivers/clk, and 3 in drivers/soc.
> >
> > If we ever have to support a different architecture which happens to use
> > a similar power domain, then we want it to be in a location which makes
> > it easy for sharing it in the first place. As it stands today, it does
> > not seem useful to me to have this code in arch/arm/mach-bcm/ at all.
> >
> > Maybe there is room from a drivers/power/domains/ of some kind?

I like the idea, but let's include generic power domain maintainers
in this discussion, as I suggested here (I got a power domain driver
patch for drivers/power just a few days ago):

https://lkml.org/lkml/2015/12/15/815

Also somebody would have to step up to maintain that directory.

> The great thing about git is that moving code is easy, even after it's
> first committed.
>
> The subsystem maintainer didn't comment on the code's location in v1 or
> v2, and I think they probably have the final say on that.  Whatever they
> want, where there is currently a genpd driver, is fine with me.

sounds reasonable.

P.S.: Thanks for taking bringing RPI support upstream :)

-- Sebastian

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWcLosAAoJENju1/PIO/qayHQP/3LA9qewnqfA4VNNZiM2JGSL
G3oMD9a7lLRgIwTa5H+SKewdbzsXMeR/uNRfw+wt+jj6WDzfNopDK/zjW8IbHCIC
qpS/bLX1XyeE1Jdkecusn2U3OazTnPH174z8KzfURReM+WMyLyp6WA4zuD9GIqSJ
BF9yGFBqaaAxNnnDx4z+ZzIqFLVseyAsQKY13AjxU9NbLtugRnpN8h8VAwdGiLIG
36e4aWwcroSqsfguP8Jb10tgGN29PWaRFk93zOAW2Hs3w82Fg4YYZHz9sXJr/5Ue
2IguacUAbjg+rKu4Imyx1PqZo4AbH+L/7hwIwZ/nTtb15povcKCHMO009JIS086B
B4XFyRUEWHFUpUOQQgnS1xKdkC+56TAb2WZUQyclz1jWnqQ9Tvqw6MnUUvoaBIuS
hleChC52E0ALbxHhGyyY7FB1HsuYRaTGO2G8cKKICbVkrTCiDAdc2DFOL2694vZW
St6ww2FaT6zcdjHxA1eWE7HzY9hQZ4CBCaJS+jBA5RjzwSaRwZ48c93ceqme6AVK
zbUavziTYoMo8jTf7I+d4XtwH+Fnsa3H4Eoh+ZPpK+RQA5g8JCqA6iVMHwxnQ/R9
d4DfiRlrSvyEIa/AeT7fbcnRoa6D7hOe2yub1YlUuZYRha8oNZHl0EBaZXZZv4Cw
SMctL1g8DOvX9oa59VGM
=Z91h
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--


--===============3053096730522145668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3053096730522145668==--
