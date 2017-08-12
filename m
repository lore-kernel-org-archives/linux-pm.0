From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v2 2/5] devicetree: power: Add docs for TI BQ24190 battery charger
Date: Sat, 12 Aug 2017 12:00:13 -0700
Message-ID: <CAKvHMgR+GxSqhy+iwdYmku2600HzoF__oXV7_w72ZJg-aK7O-Q@mail.gmail.com>
References: <20170807195420.20767-1-liam@networkimprov.net>
 <20170807195420.20767-3-liam@networkimprov.net> <20170811025038.5qnhbabyybx7rgu5@rob-hp-laptop>
 <CAKvHMgSuwm5UFivbsq9dQn_wfd7kbs63UuuQSHVdGxDf_WReUA@mail.gmail.com> <20170812164233.won7fairxmrnblps@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170812164233.won7fairxmrnblps@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,


On Sat, Aug 12, 2017 at 9:42 AM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
> On Fri, Aug 11, 2017 at 02:57:10PM -0700, Liam Breck wrote:
>> On Thu, Aug 10, 2017 at 7:50 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > On Mon, Aug 07, 2017 at 12:54:17PM -0700, Liam Breck wrote:
>> >> From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>> >>
>> >> Document monitored-battery and ti,system-minimum-microvolt properties.
>> >>
>> >> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> >> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> >> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>> >> ---
>> >>  .../devicetree/bindings/power/supply/bq24190.txt   | 49 ++++++++++++++++++++++
>> >>  1 file changed, 49 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.txt
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
>> >> new file mode 100644
>> >> index 00000000..82a1c842
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
>> >> @@ -0,0 +1,49 @@
>> >> +TI BQ24190 Li-Ion Battery Charger
>> >> +
>> >> +Required properties:
>> >> +- compatible: contains one of the following:
>> >> +    * "ti,bq24190"
>> >> +    * "ti,bq24192i"
>> >> +- reg: integer, I2C address of the charger.
>> >> +- interrupts[-extended]: configuration for charger INT pin.
>> >> +
>> >> +Optional properties:
>> >> +- monitored-battery: phandle of battery characteristics devicetree node
>> >> +    The charger uses the following battery properties:
>> >> +    + precharge-current-microamp: maximum charge current during precharge
>> >> +      phase (typically 20% of battery capacity).
>> >> +    + charge-term-current-microamp: a charge cycle terminates when the
>> >> +      battery voltage is above recharge threshold, and the current is below
>> >> +      this setting (typically 10% of battery capacity).
>> >> +    See Documentation/devicetree/bindings/power/supply/battery.txt
>> >> +- ti,system-minimum-microvolt: when power is connected and the battery is below
>> >> +    minimum system voltage, the system will be regulated above this setting.
>> >> +
>> >> +Other features:
>> >> +- Use gpio-hog to set the OTG pin high to enable 500mA charge current on USB SDP port.
>> >
>> > Why doesn't the charger driver control this?
>>
>> This pin/gpio has to be high when USB is plugged in to make the
>> charger chip negotiate 500mA from a SDP port. It should generally be
>> configured that way even if the driver is not loaded, as the chip does
>> not require a driver to function. Some boards may do that with a
>> pull-up. Also the user may want to change this via sysfs and not have
>> the driver "fix" it.
>
> drivers/power/supply/qcom_smbb.c exposes the otg feature as
> regulator. I think in this case it could be exposed as
> gpio-regulator.

Hans is doing that here:
https://patchwork.kernel.org/patch/9883717/

The datasheet labels one pin "OTG" but that's misleading; it really
enables negotiation of 500mA input current, but does not turn on OTG
mode. If this pin is low, it only prevents the driver from starting
OTG mode via I2C msg.

Tony & Matt & I discussed this at some length off-list.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
