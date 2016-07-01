From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: Re: [PATCH v2 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Fri, 01 Jul 2016 23:49:31 +0200
Message-ID: <1467409771.9121.38.camel@amnesix>
References: <1bFnWI-0000MX-9R>
	 <1467317142-14063-1-git-send-email-karl-heinz@schneider-inet.de>
	 <1467317142-14063-2-git-send-email-karl-heinz@schneider-inet.de>
	 <20160630225217.GA11555@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20160630225217.GA11555@earth>
Sender: linux-i2c-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

Am Freitag, den 01.07.2016, 00:52 +0200 schrieb Sebastian Reichel:
> Hi,
> 
> On Thu, Jun 30, 2016 at 10:05:41PM +0200, Karl-Heinz Schneider wrote:
> > This patch adds device tree documentation for the sbs-manager
> > 
> > Reviewed-by: Phil Reid <preid@electromag.com.au>
> > Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
> > ---
> >  .../devicetree/bindings/power/sbs,sbs-manager.txt  | 52 ++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> > new file mode 100644
> > index 0000000..1d7e5ee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> > @@ -0,0 +1,52 @@
> > +Binding for sbs-manager
> > +
> > +Required properties:
> > +- compatible: should be "lltc,ltc1760" or use "sbs,sbs-manager" as fallback.
> > +- reg: integer, i2c address of the device. Should be <0xa>.
> > +
> > +From OS view the device is basically an i2c-mux used to communicate with up to
> > +four smart battery devices at address 0xb. The driver actually implements this
> > +behaviour. So standard i2c-mux nodes can be used to register up to four slave
> > +batteries. Channels will be numerated as 1, 2, 4 and 8.
> 
> I think it's better to use channel 1-4 and do the translation in the
> driver's channel select method. It means one does not have to worry
> about anybody accidently configuring channel 3 and it also maps
> nicely to the datasheet talking about BAT1-BAT4.
You're not the first one pointing that out... Will fix that in the next
revision.

> 
> -- Sebastian

-- 
Greetings
