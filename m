From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 0/9] Zynq PM updates
Date: Mon, 15 Sep 2014 15:34:03 +0200
Message-ID: <c64f6993-2f83-455e-b542-4c78eb39906f@BL2FFO11FD031.protection.gbl>
References: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2911402610850777606=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, linux-pm@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

--===============2911402610850777606==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="NRtvChqGG5AqXXHMGgl3D1hSoloED7ESS"

--NRtvChqGG5AqXXHMGgl3D1hSoloED7ESS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/02/2014 11:19 PM, Soren Brinkmann wrote:
> Hi all,
>=20
> here is v2 of this series. It's mostly the same and most changes are
> related to reformatting comments. The only functional change is in 'ARM=
:
> zynq: PM: Enable DDR clock stop' which does no longer enable
> self-refresh too. It seems self-refresh is inflicting a non-negligible
> amount of latency that degrades memory performance if enabled throughou=
t
> the whole run time.
>=20
> 	Thanks,
> 	S=C3=B6ren
>=20
> Daniel Lezcano (2):
>   ARM: zynq: Remove invalidate cache for cpu die
>   ARM: zynq: cpuidle: Remove pointless code
>=20
> Soren Brinkmann (7):
>   ARM: zynq: PM: Enable A9 internal clock gating feature
>   Documentation: devicetree: Add binding for Synopsys DDR controller
>   ARM: zynq: DT: Add DDRC node
>   ARM: zynq: PM: Enable DDR clock stop
>   ARM: zynq: Synchronise zynq_cpu_die/kill
>   ARM: zynq: Remove hotplug.c
>   ARM: zynq: Rename 'zynq_platform_cpu_die'
>=20
>  .../bindings/memory-controllers/synopsys.txt       | 11 +++
>  arch/arm/boot/dts/zynq-7000.dtsi                   |  5 ++
>  arch/arm/mach-zynq/Makefile                        |  3 +-
>  arch/arm/mach-zynq/common.c                        |  7 ++
>  arch/arm/mach-zynq/common.h                        | 16 ++++-
>  arch/arm/mach-zynq/hotplug.c                       | 47 +-----------
>  arch/arm/mach-zynq/platsmp.c                       | 41 ++++++++++-
>  arch/arm/mach-zynq/pm.c                            | 83 ++++++++++++++=
++++++++
>  arch/arm/mach-zynq/slcr.c                          | 43 ++++++++++-
>  drivers/cpuidle/cpuidle-zynq.c                     | 10 +--
>  10 files changed, 205 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controller=
s/synopsys.txt
>  create mode 100644 arch/arm/mach-zynq/pm.c
>=20

Applied all.

Thanks,
Michal



--NRtvChqGG5AqXXHMGgl3D1hSoloED7ESS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlQW6ssACgkQykllyylKDCH8uwCfYTkclAGg0jSyTwxbldhDXviI
R38An0/9Rvt6HERzQWZzwl5BBhtkwgiS
=UcOf
-----END PGP SIGNATURE-----

--NRtvChqGG5AqXXHMGgl3D1hSoloED7ESS--


--===============2911402610850777606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2911402610850777606==--
