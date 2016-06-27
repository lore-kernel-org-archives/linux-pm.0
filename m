From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: Re: [PATCH 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Mon, 27 Jun 2016 23:10:24 +0200
Message-ID: <1467061824.9121.33.camel@amnesix>
References: <1466622436-27963-1-git-send-email-karl-heinz@schneider-inet.de>
	 <1466622436-27963-2-git-send-email-karl-heinz@schneider-inet.de>
	 <20160624175014.GA29990@rob-hp-laptop>
	 <9ccbeeb9-3612-fe07-3396-48da7c832bc6@electromag.com.au>
	 <CAL_JsqL38hnQpchy8q+yk1rZQ1ngF4JUwFgN0V=mGyAyAq1GVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from schneider-inet.de ([85.214.76.205]:33363 "EHLO
	h1714509.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbcF0VKi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 17:10:38 -0400
In-Reply-To: <CAL_JsqL38hnQpchy8q+yk1rZQ1ngF4JUwFgN0V=mGyAyAq1GVg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Phil Reid <preid@electromag.com.au>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>

Am Sonntag, den 26.06.2016, 09:05 -0500 schrieb Rob Herring:
> On Sun, Jun 26, 2016 at 12:21 AM, Phil Reid <preid@electromag.com.au> wrote:
> > G'day Rob
> >
> > Couple of thoughts / question below.
> >
> > On 25/06/2016 01:50, Rob Herring wrote:
> >>
> >> On Wed, Jun 22, 2016 at 09:07:15PM +0200, Karl-Heinz Schneider wrote:
> >>>
> >>> This patch adds device tree documentation for the sbs-manager
> >>>
> >>> Reviewed-by: Phil Reid <preid@electromag.com.au>
> >>> Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
> >>> ---
> >>>  .../devicetree/bindings/power/sbs,sbs-manager.txt  | 58
> >>> ++++++++++++++++++++++
> >>>  1 file changed, 58 insertions(+)
> >>>  create mode 100644
> >>> Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> >>> b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> >>> new file mode 100644
> >>> index 0000000..d52b466
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
> >>> @@ -0,0 +1,58 @@
> >>> +Binding for sbs-manager
> >>> +
> >>> +Required properties:
> >>> +- compatible: should be "sbs,sbs-manager" or "lltc,ltc1760" if device is
> >>> a
> >>> +    ltc1760.
> >>
> >>
> >> sbs is not a vendor. What chip is sbs-manager? I suspect you should drop
> >> it and only list specific chips.
> >
> > This follows the interface to the existing paired sbs,sbs-battery driver
> > defined in power/sbs-battery.c
> > It implements a generic driver for the Smart Battery System Manager
> > Specification.
> > Spec available here: http://sbs-forum.org/specs/sbsm100b.pdf
> >
> > In addition the ltc1760 extends the spec.
> 
> Chips will always vary from specs in some way either on purpose or by
> accident. sbs,sbs-manager is fine as a fallback string, but there
> should always be a chip specific string first.

All right. Will change compatible string to "lltc,ltc1760" and mention
in the Required properties section that "sbs,sbs-manager" is usable as
fallback.
> 
> >>> +- reg: integer, i2c address of the device. Should be <0xa>.
> >>> +
> >>> +Optional properties:
> >>> +- sbsm,i2c-retry-count: integer, number of retries for trying to read or
> >>> write
> >>> +    to registers. Default: 1
> >>
> >>
> >> Seems like a driver setting. Is having a retry in the driver a problem
> >> if the h/w works and never actually needs it?
> >
> > Similarly the sbs-battery driver specifies the same same retry behaviour.
> > And is a model for this implementation.
> >
> > I've found the ltc1760 and sbs batteries to be problematic when
> > communicating to them.
> > A lot of drivers (and the associated hardware) don't handle multiple bus
> > masters well.
> > The bus arbitation doesn't seem to work correctly.
> > Retries where the only thing I could do to to get things to work reliably.
> > Mostly means the driver needs fixing, but in one case the designware core
> > hardware seemed to be the problem for me.
> 
> I'm not questioning the need for a retry. I'm questioning the need to
> limit the retries and tune per platform. What would be the issue if
> the driver hardcodes the number of retries to 10? This will work for
> any h/w that needs 0, 1, 2, ..., or 10 retries. The only issue would
> be how long until it errors out.
> 
> And yes, I can confirm DW i2c h/w is a POS at least for some versions.
> 
> >>> +From OS view the device is basically an i2c-mux used to communicate with
> >>> up to
> >>> +four smart battery devices at address 0xb. The driver actually
> >>> implements this
> >>> +behaviour. So standard i2c-mux nodes can be used to register up to four
> >>> slave
> >>> +batteries. Channels will be numerated as 1, 2, 4 and 8.
> >>> +
> >>> +Example:
> >>> +
> >>> +batman@0a {
> >>> +    compatible = "sbs,sbs-manager";
> >>> +    reg = <0x0a>;
> >>> +    sbsm,i2c-retry-count = <3>;
> >>> +    #address-cells = <1>;
> >>> +    #size-cells = <0>;
> >>> +
> >>> +    channel1@1 {
> >>
> >>
> >> channel@1
> >>
> >> Do we have a standard node name for mux nodes? If not, we should.
> >>
> >>> +        #address-cells = <1>;
> >>> +        #size-cells = <0>;
> >>> +        reg = <1>;
> >>> +
> >>> +        battery1@0b {
> >>
> >>
> >> battery@b
> >>
> >>> +            compatible = "sbs-battery";
> >>
> >>
> >> This should be an actual battery model. Or all this information is
> >> generic, you don't really need it in DT.
> >
> > Do we really want to restrict to battery model?
> 
> You're not. It is just being explicit in case some battery needs
> special handling and you only find that out after writing the binding.
> The DT model is such that the kernel can be updated with fixes without
> updating the DT. Specific compatible strings are needed for that to
> work.
> 
> > I have hardware where complete different sbs compliant batteries can be
> > plugged in.
> > Without the compatible flag here how do you get the sbs-battery driver to
> > load and manage the battery itself?
> > Or are you suggesting the manager should do this somehow?
> > I'm still learning...
> 
> sbs,sbs-battery can still be a fall-back compatible string.

Consider this scenario: compatible = "ti,bq2060", "sbs,sbs-battery";

By now the there is no special "bq2060" driver. But my battery might be
on of those. I code the DT this way everything should work find
(sbs-battery driver will bind).
If battery is removable and battery device changes everything should
still work fine hence sbs-battery works on subset of registers of the
standard.

But what happens if a kernel update is done and a bq2060 driver appears
which might want access to registers not part of the standard and the
(now changed) device doesn't provide?
> 
> Rob

Karl-Heinz


