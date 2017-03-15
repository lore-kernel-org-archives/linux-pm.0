From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2 RESEND] power: reset: Add a driver for the Gemini
 poweroff
Date: Wed, 15 Mar 2017 22:11:49 +0100
Message-ID: <20170315211149.of3xvrnlq7ne7r5w@earth>
References: <20170312223621.3010-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3248743441256729878=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170312223621.3010-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: openwrt-devel@openwrt.org, Florian Fainelli <f.fainelli@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-pm@vger.kernel.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>inux-pm@vger.kernel.org, Janos Laube <janos.dev@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============3248743441256729878==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jtlot5hsk45z3qlj"
Content-Disposition: inline


--jtlot5hsk45z3qlj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Sun, Mar 12, 2017 at 11:36:21PM +0100, Linus Walleij wrote:
> The Gemini (SL3516) SoC has a special power controller block
> that only deal with shutting down the system.
>=20
> If you do not register a driver and activate the block, the
> power button on the systems utilizing this SoC will do an
> uncontrolled power cut, which is why it is important to have
> a special poweroff driver.
>=20
> The most basic functionality is to just shut down the system
> by writing a special bit in the control register after the
> system has reached pm_poweroff.
>=20
> It also handles the poweroff from a button or other sources:
>=20
> When the poweroff button is pressed, or a signal is sent to
> poweroff from an infrared remote control, or when the RTC
> fires a special alarm (!) the system emits an interrupt.
> At this point, Linux must acknowledge the interrupt and
> proceed to do an orderly shutdown of the system.
>=20
> After adding this driver, pressing the poweroff button gives
> this dmesg:
>=20
> root@gemini:/
> root@gemini:/ gemini-poweroff 4b000000.power-controller:
> poweroff button pressed
>=20
> calling shutdown scripts..
> setting /dev/rtc0 from system time
> unmounting file systems...
> umount: tmpfs busy - remounted read-only
> umount: can't unmount /: Invalid argument
> The system is going down NOW!
> Sent SIGTERM to all processes
> Sent SIGKILL to all processes
> Requesting system poweroff
> uhci_hcd 0000:00:09.1: HCRESET not completed yet!
> uhci_hcd 0000:00:09.0: HCRESET not completed yet!
> reboot: Power down
> gemini-poweroff 4b000000.power-controller: Gemini power off
>=20
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Sebastian: please just merge this when your are pleased
> with it. I will funnel the ARM parts through the ARM SoC tree.

DONE.

-- Sebastian

--jtlot5hsk45z3qlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJrhUACgkQ2O7X88g7
+ppFJQ//fkF9AS64QqGdWA1U9u14Y/GwFwPr+wEmsfYz1Oc8XCPrEfuR3GfwWnY3
1DjUDDyasvBMmxKpaxaXUfvVj0JU1dMinMIqY8kLeF+KTUkyt3i71kaxjMpG9AgT
j4S+UKfb+aH5eYZJt6q6bl88Cjh/M10lN3wTEtTmXmzG/aCw6siCNklMsiDoIG99
2odl9WUfKvU/NcKQ0OAhAJ/Q9m7w4F3NLLIJQYNNF/uczotD4rSD4ZN1tOhvejL/
/luMk7kNdYYeCTYERh0X7KK2ek5+2o3s4OGjTHCs2LuH8lDRM8A8Oe5Ji/jvgNur
xSK+JVRhTpc06TBarlZ7Z2eHf2KLNpGPkioDOWLByYLZstVgoo16//uUV1wJ76zM
8S0pgYJU9ikSeKuLIHImreKSkXOaYK7091SAQ3N7ey9lkydtZ0SaXezXFhylFt6j
H2lJFx9GREmCFL26Knex7jZo99wxb69JKRXX6kZ9JaSN9vjBA5FAl340mGk5ijJc
45fLW5ubLCxniMvdlN+Mrnvic0LVJYOS2S1z0NHZ5lQcyTIjAC7Vg1cBCgbSubpz
HyS824tkF0VldiaNJR84pGsqo5AR8FKrQsEAht7kYw0v7pYKlpgllDCxI67sMYXg
wTqwyvGE7xVnOquZ4vS2ju2J1eI1EFZr4urskNQGLS5BI4nIBZ8=
=63P5
-----END PGP SIGNATURE-----

--jtlot5hsk45z3qlj--


--===============3248743441256729878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3248743441256729878==--
