From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] dt-bindings: Add summit SMB347 charger bindings
Date: Fri, 16 Sep 2016 08:29:35 -0500
Message-ID: <20160916132935.GA28919@rob-hp-laptop>
References: <1473243615-29746-1-git-send-email-simhavcs@gmail.com>
 <1473243615-29746-2-git-send-email-simhavcs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473243615-29746-2-git-send-email-simhavcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinay Simha BN <simhavcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonghwa Lee <jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Myungjoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 07, 2016 at 03:50:11PM +0530, Vinay Simha BN wrote:
> Add documentation for summit SMB347 charger
> 
> Cc: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Jonghwa Lee <jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Myungjoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Vinay Simha BN <simhavcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../bindings/power/supply/smb347_charger.txt       | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/smb347_charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/smb347_charger.txt b/Documentation/devicetree/bindings/power/supply/smb347_charger.txt
> new file mode 100644
> index 0000000..91570a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/smb347_charger.txt
> @@ -0,0 +1,57 @@
> +smb347_charger bindings
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +[Required porperties]
> +- compatible : "summit,smb347"
> +- reg : Slave address for i2c interface
> +# At least one of followings should be set
> +  - enable-usb-charging
> +  - enable-otg-charging
> +  - enable-mains-charging

These sound like user configuration which should be controlled with 
sysfs rather than DT?

> +
> +[Optional properties]
> +- interrupt-parent : The phandle for the interrupt controller
> +- interrupts : Interrupt line index for mapping
> +- enable-chg-ctrl : Enable charging control
> +		<0> : SW (i2c interface)
> +		<1> : Pin control (Active Low)
> +		<2> : Pin control (Active High)

Don't you need a gpio line defined to control this?

> +# Charging constraints
> +- max-chg-curr : Maximum current for charging (in uA)
> +- max-chg-volt : Maximum voltage for charging (in uV)
> +- pre-chg-curr : Pre-charging current (in uA)
> +- term-curr : Charging cycle termination current (in uA)
> +- fast-volt-thershold : Voltage threshold to transit to fast charge mode (in uV)
> +- mains-curr-limit : Maximum input current from AC/DC input (in uA)
> +- usb-curr-limit : Maximum input current from USB input (in uA)
> +
> +# Related thermometer monitoring (in degree C)
> +- chip-temp-threshold : Chip temperature for thermal regulaton.   <100, 130>
> +- soft-cold-temp-limit : Cold battery temperature for soft alarm. <0, 15>*
> +- soft-hot-temp-limit : Hot battery temperature for soft alarm.   <40, 55>
> +- hard-cold-temp-limit : Cold battery temperature for hard alarm. <0, 15>*
> +- hard-hot-temp-limit : Hot battery temperature for hard alarm.   <55, 65>
> +(* The written temperature has +5'C offset. 0'C -> -5'C, 15'C -> 10'C)

Minimally, all these need vendor prefixes and unit suffixes. See 
property-units.txt. However, ...

These also seem like common properties. Frankly, all the charger 
bindings are a mess. They are all done differently. There's common 
things like max charge current that are all described in different ways. 
I think minimally a couple of things need to be defined for a common 
structure.

A separate node for batteries with properties of the battery like charge 
current/voltage parameters, temperature params, type of battery, etc.

A sub node of the charger for each supply source like USB, wall, etc. 
and any parameters for those sources like current limits.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
