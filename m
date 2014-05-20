From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC 2/2] PM / OPP: extend DT parsing to allow voltage ranges
Date: Tue, 20 May 2014 17:07:09 +0200
Message-ID: <1400598429.4853.29.camel@weser.hi.pengutronix.de>
References: <1400596060-5330-1-git-send-email-l.stach@pengutronix.de>
	 <1400596060-5330-3-git-send-email-l.stach@pengutronix.de>
	 <537B6782.5080505@ti.com>
	 <1400596877.4853.16.camel@weser.hi.pengutronix.de>
	 <CAGo_u6qTFzVMhcWrk0L5Z4zykfLTMrkph0b4AJNEX7SS7pvWxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59454 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbaETPIY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 11:08:24 -0400
In-Reply-To: <CAGo_u6qTFzVMhcWrk0L5Z4zykfLTMrkph0b4AJNEX7SS7pvWxQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Am Dienstag, den 20.05.2014, 09:53 -0500 schrieb Nishanth Menon:
> On Tue, May 20, 2014 at 9:41 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Am Dienstag, den 20.05.2014, 09:32 -0500 schrieb Nishanth Menon:
> >> On 05/20/2014 09:27 AM, Lucas Stach wrote:
> >> > Following the introduction of voltage ranges into OPP
> >> > we need a way to encode them in the device tree in a
> >> > similar fashion to the non-ranged versions.
> >> >
> >> > To keep compatibility with old DTs the parsing function
> >> > is changed to understand both versions.
> >> >
> >> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >> > ---
> >> >  Documentation/devicetree/bindings/power/opp.txt | 23 ++++++++++++++++++
> >> >  drivers/base/power/opp.c                        | 31 ++++++++++++++++++-------
> >> >  2 files changed, 46 insertions(+), 8 deletions(-)
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
> >> > index 74499e5033fc..5b520ff321f5 100644
> >> > --- a/Documentation/devicetree/bindings/power/opp.txt
> >> > +++ b/Documentation/devicetree/bindings/power/opp.txt
> >> > @@ -10,6 +10,16 @@ Properties:
> >> >     freq: clock frequency in kHz
> >> >     vol: voltage in microvolt
> >> >
> >> > +or
> >> > +
> >> > +- operating-points-range: An array of 4-tuple items, each item consisting
> >> > +  of a frequency and a related voltage range in the following form:
> >> > +  <freq min-vol-uV nom-vol-uV max-vol-uV>
> >> > +   freq: clock frequency in kHz
> >> > +   min-vol-uV: absolute minimum required voltage for this frequency
> >> > +   nom-vol-uV: nominal voltage for this frequency
> >> > +   max-vol-uV: absolute maximum allowed voltage for this frequency
> >>
> >> And, Why cant we function at min-volt-uV? because PMIC cannot support
> >> it? then why add voltage tolerance? This is not clear in the dt
> >> description.
> >>
> > The min-vol-uV is meant as the absolute minimum voltage where the device
> > is still able to work.
> > But still vendors are giving nominal voltages that should be met if
> > possible. So for example for a CPU device we might always want to try to
> > match the nominal voltage, but in case the regulator isn't able to
> > supply a this voltage it's still ok to use a voltage in the
> > min...nominal range.
> 
> So,the chip either is supposed to function OR not function for a
> frequency at a voltage right?
> 
> Then, we have a problem here -> if min_uV is selected by a regulator
> (for the sake of argument), then device is expected to function. So,
> then why choose nom_uV on a regulator that can do min_uV? if the
> device is NOT *guaranteed* to work at min_uV, then defining min_uV as
> "functional voltage if nom_uV is not available" is wrong as well - no?
> 
> Is'nt that a wrong definition?
> 
The chip (or part of it) is supposed to work at min_uV. This is the
value you can find in datasheets as the absolute minimum voltage. The
values provided as min_uV are always safe to be used.

Technically we could get away with just defining a minimum and a maximum
voltage for one OPP, but I think it's wrong to introduce a new DT
binding that already knowingly discards information which is already
present, as vendors usually define the 3-tuple of [min|typical|max] in
their component datasheets. I want to avoid introducing yet another
binding once we see a clear use-case for the nominal voltage.
 
> 
> >
> > Another case may be where we are scaling CPU voltage and have to
> > maintain a certain voltage difference between CPU and SoC power domain.
> > So there may be cases where we might decide that it's better (faster) to
> > scale CPU only to it's min voltage to avoid touching the SoC regulator.
> 
> That is not the job of OPP definition for device X - voltage domain to
> voltage domain dependency is part of something else (for example: an
> voltage domain driver like an RFC[1] or equivalent)
> 
Right, but OPP should provide the voltage domain drivers with enough
information about the devices to make some well-informed choices.
Currently the OPP framework lacks some crucial information for this.

For example you can't currently answer the question: "How much can I
raise the voltage of this domain, without exceeding the specs for any
connected device?". This feels like a major limitation.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

