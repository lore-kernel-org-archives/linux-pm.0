From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: Re: [PATCH 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Sun, 26 Jun 2016 09:10:24 +0200
Message-ID: <1466925024.9121.3.camel@amnesix>
References: <1466622436-27963-1-git-send-email-karl-heinz@schneider-inet.de>
	 <1466622436-27963-2-git-send-email-karl-heinz@schneider-inet.de>
	 <20160624175014.GA29990@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20160624175014.GA29990@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

sorry for resending, forgot the Cc.

Am Freitag, den 24.06.2016, 12:50 -0500 schrieb Rob Herring:
> On Wed, Jun 22, 2016 at 09:07:15PM +0200, Karl-Heinz Schneider wrote:
> > This patch adds device tree documentation for the sbs-manager
> > 
> > Reviewed-by: Phil Reid <preid@electromag.com.au>
> > Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
> > ---
> >  .../devicetree/bindings/power/sbs,sbs-manager.txt  | 58
++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644
Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> > 
> > diff --git
a/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> > new file mode 100644
> > index 0000000..d52b466
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> > @@ -0,0 +1,58 @@
> > +Binding for sbs-manager
> > +
> > +Required properties:
> > +- compatible: should be "sbs,sbs-manager" or "lltc,ltc1760" if
device is a
> > +    ltc1760.
> 
> sbs is not a vendor. What chip is sbs-manager? I suspect you should
drop 
> it and only list specific chips.
Yes it's not a specific chip. But it's the specification of the
interface. See http://sbs-forum.org/specs/sbsm100b.pdf. One
implementation (with special features) is the LTC1760.

I choose this because the sbs-battery-driver did it the same way. You
can find this in sbs-battery.c:

static const struct of_device_id sbs_dt_ids[] = {
        { .compatible = "sbs,sbs-battery" },
        { .compatible = "ti,bq20z75" },
        { }
};

Why not keep a generic compatibility string?

> 
> > +- reg: integer, i2c address of the device. Should be <0xa>.
> > +
> > +Optional properties:
> > +- sbsm,i2c-retry-count: integer, number of retries for trying to
read or write
> > +    to registers. Default: 1
> 
> Seems like a driver setting. Is having a retry in the driver a
problem 
> if the h/w works and never actually needs it?
It could also be passed as a module parameter. But again the sbs-battery
driver did it the same way, it just acted as template in this case...

The retry problematic arises because the SBSM is itself an i2c master.
And (at least the LTC) stretches hosts i2c clock if it does communicate
with the connected batteries. This will likely disturb the hosts
communication to any i2c chip connected on this bus sooner or later,
including to the SBSM.
> 
> > +
> > +From OS view the device is basically an i2c-mux used to communicate
with up to
> > +four smart battery devices at address 0xb. The driver actually
implements this
> > +behaviour. So standard i2c-mux nodes can be used to register up to
four slave
> > +batteries. Channels will be numerated as 1, 2, 4 and 8.
> > +
> > +Example:
> > +
> > +batman@0a {
> > +    compatible = "sbs,sbs-manager";
> > +    reg = <0x0a>;
> > +    sbsm,i2c-retry-count = <3>;
> > +    #address-cells = <1>;
> > +    #size-cells = <0>;
> > +
> > +    channel1@1 {
> 
> channel@1
> 
> Do we have a standard node name for mux nodes? If not, we should.
I don't know. Other mux binding docs name the cannels just "i2c" or
"port". Spec names them (the battery) "Smart Battery [A,B..]".
Can at least drop the number in front of the @.
> 
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        reg = <1>;
> > +
> > +        battery1@0b {
> 
> battery@b

> 
> > +            compatible = "sbs-battery";
> 
> This should be an actual battery model. Or all this information is 
> generic, you don't really need it in DT.
A solution could be to bind the sbs-battery driver within the
sbs-manager driver for all detected channels per default, if not
otherwise state in device tree? Current implementation doesn't bind
anything by itself. Don't know what is the preferred behaviour?
> 
> > +            reg = <0x0b>;
> > +        };
> > +    };
> > +
> > +    channel2@2 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        reg = <2>;
> > +
> > +        battery2@0b {
> > +            compatible = "sbs-battery";
> > +            reg = <0x0b>;
> > +        };
> > +    };
> > +
> > +    channel3@4 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        reg = <4>;
> > +
> > +        battery3@0b {
> > +            compatible = "sbs-battery";
> > +            reg = <0x0b>;
> > +        };
> > +    };
> > +};
> > -- 
> > 1.9.1
> > 
Tanks for review.
-- 
Greetings
