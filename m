From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH RESEND V2 2/2] power: collie_battery: support generating
 wakeup event
Date: Thu, 15 Jan 2015 14:44:33 +0100
Message-ID: <20150115134432.GB512@earth.universe>
References: <1421287238-23522-1-git-send-email-dbaryshkov@gmail.com>
 <1421287238-23522-2-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421287238-23522-2-git-send-email-dbaryshkov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jan 15, 2015 at 05:00:38AM +0300, Dmitry Eremin-Solenikov wrote:
> Teach collie_battery driver to communicate to the kernel that it can
> generate wakeup events. Handle enabling/disabling wakeup on battery full
> event in suspend/resume callbacks.

Thanks, applied:

http://git.infradead.org/battery-2.6.git/commit/a465005643a4c1e02681b02075082fc6c7fa076a

-- Sebastian

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUt8RAAAoJENju1/PIO/qaFyoQAILosLE0+WzG2mjx3bGHFB8I
cJeAeijse4T7zQdoonKZyZVYj96gp0HW155aVERjVbjVjeFwwnwmcOTML2fI2W3O
EUvFE3k8TapPxrgl/0oCkmpz30RbNpSRk/THQN48u8KmFoL1BFiP1VWU1AeFdeVa
QRMkLc88eCI2bPEqwdjr4kfPcWfXEbQLWriXSgugEecyNZsMi2pqL3xvzTov266z
NBpLRCMjvv9K7CrRUdO+hHZZmyI7dMls9lTUGBRIKWgQtlUGk8nCyEOa5X0BlOTQ
PiMhjOgGid1HAsbYRGLH/niX4O9ZF8JGX4cFzCtujr1bWdz/abprGB1cHuvCWM91
xPFWK1errV9ihj78OD8zyLHgnKRZkt0iM3TbULphdH6iTAsWnhr6HXmI03crinab
IqS1eRTgjhay+dUrbrPorbJuh2AZMh1bek516L8zIa/S4hWxchr4dG6hosQ7To4M
BdBeQpeuXu2640EZtXYMWwCD8izeorvXJz8UQ8y/nsecvuzCW+z8k0aNQtE4d9xR
10Un9q57TWpkQxuiRe90uVBnAulb1NPy78n1r2lvoeBF/0T4Lqvr24vMikfGw/Mt
viEf0I/GKEtpI4GG1ngQpa/r0iT+tIMTnkS1BLSmiFHJqwThIFZaybtHqFpeTCfe
qvI74D92H040S+PZzmOA
=Jbte
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
