From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH/RFC v6 4/7] PM / Domains: Add DT bindings for PM QoS
 device latencies
Date: Wed, 13 May 2015 10:36:21 +0200
Message-ID: <CAPDyKFp=FK1ietZdx4fkRF0j_i1me8f+w5YasFHHyBCARwAr+Q@mail.gmail.com>
References: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
	<1430138622-14029-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430138622-14029-5-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Axel Haslam <ahaslam@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27 April 2015 at 14:43, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> PM QoS device start/stop are properties of the hardware.
> In legacy code, they're specified from platform code.
> On DT platforms, their values should come from DT.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v6:
>   - Rebased on top of v4.1-rc1 for new RFC,
>
> v4:
>   - Drop save/restore state latencies, as they're Linux driver-specific,
>   - Change state to RFC, as this is put on hold,
>
> v3:
>   - No changes,
>
> v2:
>   - New.
> ---
>  Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index d659e5cb39be6057..32d1d3a399fe2a48 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -73,12 +73,18 @@ Required properties:
>   - power-domains : A phandle and PM domain specifier as defined by bindings of
>                     the power controller specified by phandle.
>
> +Optional properties:
> + - stop-latency: Stop latency of the device, in ns,
> + - start-latency: Start latency of the device, in ns,
> +

What do you think of renaming these to "suspend-latency" and
"resume-latency" instead? I think that better reflects their purpose.
I have no strong opinion though.

>  Example:
>
>         leaky-device@12350000 {
>                 compatible = "foo,i-leak-current";
>                 reg = <0x12350000 0x1000>;
>                 power-domains = <&power 0>;
> +               stop-latency = <250000>;
> +               start-latency = <250000>;
>         };
>
>  The node above defines a typical PM domain consumer device, which is located
> --
> 1.9.1
>

Kind regards
Uffe
