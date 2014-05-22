From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC 2/2] PM / OPP: extend DT parsing to allow voltage ranges
Date: Thu, 22 May 2014 12:24:58 +0200
Message-ID: <1400754298.4913.15.camel@weser.hi.pengutronix.de>
References: <1400596877.4853.16.camel@weser.hi.pengutronix.de>
	 <CAGo_u6qTFzVMhcWrk0L5Z4zykfLTMrkph0b4AJNEX7SS7pvWxQ@mail.gmail.com>
	 <1400598429.4853.29.camel@weser.hi.pengutronix.de>
	 <CAGo_u6ru5OgwCbJRrMNXUzeNLFMUvW=j8su6AAC4vmy3GOSM2g@mail.gmail.com>
	 <CAGo_u6omOyuXvpDcirm36AnreGfa4nxisQ8BqZ8p2AVmWjfwbA@mail.gmail.com>
	 <1400600908.4853.41.camel@weser.hi.pengutronix.de>
	 <CAGo_u6pyU1O0uv-3CJc6OPoJ+bkcpNJ9_26JL3DxugX7dJhZfA@mail.gmail.com>
	 <1400604324.4853.51.camel@weser.hi.pengutronix.de>
	 <CAGo_u6ofuas-HBkAaKAUmKoOxjfWOpa7gmenS6Lspk9gWNt5cw@mail.gmail.com>
	 <1400665634.5926.18.camel@weser.hi.pengutronix.de>
	 <20140521233302.GA12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52039 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbaEVK0T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 06:26:19 -0400
In-Reply-To: <20140521233302.GA12304@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Am Donnerstag, den 22.05.2014, 00:33 +0100 schrieb Mark Brown:
> On Wed, May 21, 2014 at 11:47:14AM +0200, Lucas Stach wrote:
> 
> > To summarize things: I'm working on a new cpufreq driver and I think the
> > current practice of using a "voltage-tolerance" is bogus as most devices
> > don't actually have a fixed tolerance but rather an absolute maximum
> > rating which should not be exceeded.
> 
> We actually need both options here but yes, I agree.
> 
> > The voltage tolerance is used as the regulator needs to be given a
> > sensible range for set_voltage(). The minimum voltage is defined by the
> > current OPP, maximum not so much. Now most cpufreq drivers just add a
> > tolerance to the minimum to get the max value and call it a day, but
> > actually I think it would be more sensible to stick the absolute maximum
> > rating in there. The problem is a device driver currently doesn't know
> > about the maximum rating of it's device.
> 
> This depends very much on how the chip is specified - as far as I can
> tell some manufacturers specify things really tightly and only guarantee
> that the chip will operate at specific operating points while others do
> the more expected thing and specify a minimum voltage for the OPP and a
> maximum rated voltage with any voltage in the range being in spec.  I
> expect this is due to the need to guarantee performance so they're only
> quoting what's been fully simulated, verified and characterised in the
> datasheet.
> 
> Realistically it's probably unlikely that there would be any practical
> problems other than excessive power consumption going over voltage so
> long as it is within the maximum rated operational voltage but equally
> well if the datasheet specifies something more restrictive it seems
> sensible to follow what the datasheet said just in case there's some
> good reason for it (and to make it easier to get support from the
> hardware people!).
> 
> The people who did that code originally had the first case but we should
> as you say be able to handle the second case and allow each OPP (or
> possibly just the device as a whole) to have a ceiling put in place.
> 
> > On the other hand Nishanth argues that regulator constraints should be
> > set correctly to limit the voltage to the absolute maximum rating and I
> > can see his point here. But only using regulator constraints would make
> > the max voltage parameter in set_voltage() superfluous and we could just
> > set it to INT_MAX, which feels really wrong.
> 
> That would work as well of course but like you say eew.  :)
> 
> > So with the realization that the maximum rating isn't really dependent
> > on the current OPP it seems we could just have a generic
> > "*-supply-max-voltage" property to describe a reasonable upper bound
> > instead of this wobbly voltage-tolerance. Does this sound sensible to
> > you?
> 
> Yes, I definitely think that option should exist.  I don't know if it's
> worth doing it per OPP rather than for the chip as a whole in case
> that's a thing people want to use but I'd be surprised if anyone
> noticed.  We could also infer the maximum voltage from the highest
> voltage specified for an OPP if some boolean property was set which
> might be a bit less redundant.

Thanks for the feedback.

I think I'll go for the ceiling per device option, as I'm not really
able to convince myself anymore that a ceiling per OPP is necessary.

This shifts things from a change to the OPP framework to a change to the
regulator framework, as I would like to add this property to the device
supply definition. Patches upcoming.

I would really like to have a clear absolute maximum per device, as this
would allow me to infer the voltage tolerance of the device from the
difference between the highest OPP and maximum voltage.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

