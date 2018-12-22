From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm SoCs
Date: Fri, 21 Dec 2018 23:39:49 -0800
Message-ID: <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
References: <20181221115946.10095-1-rplsssn@codeaurora.org> <20181221115946.10095-4-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221115946.10095-4-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Raju P.L.S.S.S.N (2018-12-21 03:59:44)
> diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Do=
cumentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> index 9b86d1eff219..f24afb45d0d9 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> @@ -30,6 +30,12 @@ will be an aggregate of the sleep votes from each of t=
hose subsystems. Clients
>  may request a sleep value for their shared resources in addition to the =
active
>  mode requests.
> =20
> +When the processor enters deepest low power mode, the next wake-up timer=
 value
> +needs to be programmed to PDC (Power Domain Controller) through RSC regi=
sters
> +dedicated for this purpose. PDC timer is specified as child node of RSC =
with
> +register offets to program timer match value.

That's great info, but I have no idea why it's in the DT binding
document.

> +
> +
>  Properties:
> =20
>  - compatible:
> @@ -86,6 +92,20 @@ Properties:
>  Drivers that want to use the RSC to communicate with RPMH must specify t=
heir
>  bindings as child nodes of the RSC controllers they wish to communicate =
with.
> =20
> +If an RSC needs to program next wake-up in the PDC timer, it must specif=
y the
> +binding as child node with the following properties:
> +
> +Properties:
> +- compatible:
> +    Usage: required
> +       Value type: <string>
> +       Definition: must be "qcom,pdc-timer".
> +
> +- reg:
> +    Usage: required
> +       Value type: <prop-encoded-array>
> +       Definition: Specifies the offset of the control register.
> +
>  Example 1:
> =20
>  For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of =
2, the
> @@ -103,6 +123,9 @@ TCS-OFFSET: 0xD00
>                       <0x179d0000 0x10000>,
>                       <0x179e0000 0x10000>;
>                 reg-names =3D "drv-0", "drv-1", "drv-2";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges;
>                 interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> @@ -112,6 +135,12 @@ TCS-OFFSET: 0xD00
>                                   <SLEEP_TCS   3>,
>                                   <WAKE_TCS    3>,
>                                   <CONTROL_TCS 1>;
> +
> +               pdc_timer@38 {
> +                       compatible =3D "qcom,pdc-timer";
> +                       reg =3D <0x38 0x1>,
> +                             <0x40 0x1>;

I don't understand this whole binding. Why can't the pdc timer be
programmed within the rpmh driver? This looks like a node is being added
as a child just to make a platform driver and device match up in the
linux kernel. And that in turn causes a regmap to need to be created?
Sorry, it just looks really bad.

At least for the regulators we have a semi-good reason to have a subnode
because of the pmic-id property that we need to match up to the right
pmic. The argument for the rpmh clock node is unclear to me so we should
probably get rid of that node entirely. I can't figure out why that
wasn't just a #clock-cells at the toplevel rsc node. The same goes for
the interconnect and rpmhpd bindings. It's all sub-nodes to placate
linux device driver model.

And now that I've had to look at the rpmh binding again I'm disappointed
that we have SoC data stored in there with the qcom,tcs-offset and
qcom,tcs-config properties. Just make an SoC compatible like
qcom,rpmh-rsc-sdm845" and figure these things out that way. And please
tell hardware folks to stop moving the register regions around in the
future so that there doesn't have to be so many variants in the driver
and compatible string space.
