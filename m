From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v4 5/8] dt-bindings: devfreq: add Exynos5422 DMC device description
Date: Sun, 3 Feb 2019 21:28:10 +0900
Message-ID: <CAGTfZH3Uh1yh8c_4v=PW_NAcTi58p1h40VDiBuQoMPQm3X9Z_w@mail.gmail.com>
References: <CGME20190201164720eucas1p1ae770f7981fa09016b69ca7265e820c7@eucas1p1.samsung.com>
 <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com> <1549039612-28905-6-git-send-email-l.luba@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549039612-28905-6-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

 Hi,

2019=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 2:45, Lu=
kasz Luba <l.luba@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> The patch adds description for DT binding for a new Exynos5422 Dynamic
> Memory Controller device.
> It also contains needed MAINTAINERS file update.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/devfreq/exynos5422-dmc.txt | 106 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-=
dmc.txt
>
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt=
 b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
> new file mode 100644
> index 0000000..229efba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
> @@ -0,0 +1,106 @@
> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller=
 device
> +
> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which =
the DRAM
> +memory chips are connected. The driver is to monitor the controller in r=
untime
> +and switch frequency and voltage. To monitor the usage of the controller=
 in
> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit)=
, which
> +is able to measure the current load of the memory.
> +When 'userspace' governor is used for the driver, an application is able=
 to
> +switch the DMC frequency.
> +
> +Required properties for DMC device for Exynos5422:
> +- compatible: Should be "samsung,exynos5422-bus".

The compatible name is wrong.
- exynos5422-bus -> exynos5422-dmc

> +- clock-names : the name of clock used by the bus, "bus".

'bus' is right?

> +- clocks : phandles for clock specified in "clock-names" property.
> +- devfreq-events : phandles for PPMU devices connected to this DMC.

The dt-binging file doesn't contain the any description for 'reg' propertie=
s.

> +
> +The example definition of a DMC and PPMU devices declared in DT is shown=
 below:
> +
> +       ppmu_dmc0_0: ppmu@10d00000 {
> +               compatible =3D "samsung,exynos-ppmu";
> +               reg =3D <0x10d00000 0x2000>;
> +               clocks =3D <&clock CLK_PCLK_PPMU_DREX0_0>;
> +               clock-names =3D "ppmu";
> +               status =3D "okay";
> +               events {
> +                       ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +                               event-name =3D "ppmu-event3-dmc0_0";
> +                       };
> +               };
> +       };
> +
> +
> +       ppmu_dmc0_1: ppmu@10d10000 {
> +               compatible =3D "samsung,exynos-ppmu";
> +               reg =3D <0x10d10000 0x2000>;
> +               clocks =3D <&clock CLK_PCLK_PPMU_DREX0_1>;
> +               clock-names =3D "ppmu";
> +               status =3D "okay";
> +               events {
> +                       ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
> +                               event-name =3D "ppmu-event3-dmc0_1";
> +                       };
> +               };
> +       };
> +
> +       ppmu_dmc1_0: ppmu@10d10000 {
> +               compatible =3D "samsung,exynos-ppmu";
> +               reg =3D <0x10d60000 0x2000>;
> +               clocks =3D <&clock CLK_PCLK_PPMU_DREX1_0>;
> +               clock-names =3D "ppmu";
> +               status =3D "okay";
> +               events {
> +                       ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
> +                               event-name =3D "ppmu-event3-dmc1_0";
> +                       };
> +               };
> +       };
> +
> +       ppmu_dmc1_1: ppmu@10d70000 {
> +               compatible =3D "samsung,exynos-ppmu";
> +               reg =3D <0x10d70000 0x2000>;
> +               clocks =3D <&clock CLK_PCLK_PPMU_DREX1_1>;
> +               clock-names =3D "ppmu";
> +               status =3D "okay";
> +               events {
> +                       ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
> +                               event-name =3D "ppmu-event3-dmc1_1";
> +                       };
> +               };
> +       };
> +
> +       dmc: memory-controller@10c20000 {
> +               compatible =3D "samsung,exynos5422-dmc";
> +               reg =3D <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +                       <0x10030000 0x1000>, <0x10000000 0x1000>;
> +               clocks =3D        <&clock CLK_FOUT_SPLL>,
> +                               <&clock CLK_MOUT_SCLK_SPLL>,
> +                               <&clock CLK_FF_DOUT_SPLL2>,
> +                               <&clock CLK_FOUT_BPLL>,
> +                               <&clock CLK_MOUT_BPLL>,
> +                               <&clock CLK_SCLK_BPLL>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                               <&clock CLK_MOUT_MCLK_CDREX>,
> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
> +                               <&clock CLK_CLKM_PHY0>,
> +                               <&clock CLK_CLKM_PHY1>;
> +               clock-names =3D   "fout_spll",
> +                               "mout_sclk_spll",
> +                               "ff_dout_spll2",
> +                               "fout_bpll",
> +                               "mout_bpll",
> +                               "sclk_bpll",
> +                               "mout_mx_mspll_ccore",
> +                               "mout_mx_mspll_ccore_phy",
> +                               "mout_mclk_cdrex",
> +                               "dout_clk2x_phy0",
> +                               "clkm_phy0",
> +                               "clkm_phy1";
> +
> +               status =3D "okay";
> +               devfreq-events =3D <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
> +                               <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
> +       };
> +
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e81dfbf..ab0d8a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3316,6 +3316,7 @@ L:        linux-pm@vger.kernel.org
>  L:     linux-samsung-soc@vger.kernel.org
>  S:     Maintained
>  F:     drivers/devfreq/exynos5422-dmc.c
> +F:     Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
>
>  BUSLOGIC SCSI DRIVER
>  M:     Khalid Aziz <khalid@gonehiking.org>
> --
> 2.7.4
>


--=20
Best Regards,
Chanwoo Choi
