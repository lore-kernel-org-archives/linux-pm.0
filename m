From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: power: tps65217_charger: add NTC type
 for battery temperature measurement.
Date: Fri, 26 May 2017 14:26:58 -0700
Message-ID: <CAKvHMgTf7Tz2hTo0-QrO_KjqoQrJtGephEz9Wuo-Ty=W7szCBw@mail.gmail.com>
References: <20170526110413.24836-1-enric.balletbo@collabora.com> <20170526110413.24836-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170526110413.24836-3-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Enric,

On Fri, May 26, 2017 at 4:04 AM, Enric Balletbo i Serra
<enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
> The TS pin of the TPS56217 connects to the NTC resistor in the battery
> pack. By default the device is setup to support a 10-kohm but can also
> be configured to support a 100-kohm. Add a propietry to configure the
> connected NTC resistor. Therefore, the charger would get the wrong
> temperature information.

This also needs a monitored-battery property, and a battery node in
the example. See https://patchwork.kernel.org/patch/9710803/


> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
> Changes since v2:
>  - Requested by Sebastian Reichel
>    - Get rid of common properties and only maintain ntc-type.
> Changes since v1:
>  - None
>
>  .../devicetree/bindings/power/supply/tps65217_charger.txt          | 7 +=
++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/tps65217_char=
ger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.t=
xt
> index a11072c..851f5c7 100644
> --- a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> @@ -6,6 +6,12 @@ Required Properties:
>               Should be <0> for the USB charger and <1> for the AC adapte=
r.
>  -interrupt-names: Should be "USB" and "AC"
>
> +Optional properties:
> +-ti,ntc-type: set the NTC type for battery temperature measurement. The =
value
> +       must be 0 or 1, where:
> +         0 =E2=80=93 100k (curve 1, B =3D 3960)
> +         1 =E2=80=93 10k  (curve 2, B =3D 3480) (default)
> +
>  This node is a subnode of the tps65217 PMIC.
>
>  Example:
> @@ -14,4 +20,5 @@ Example:
>                 compatible =3D "ti,tps65217-charger";
>                 interrupts =3D <0>, <1>;
>                 interrupt-names =3D "USB", "AC";
> +               ti,ntc-type =3D <1>;
>         };
> --
> 2.9.3
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
