From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC 2/2] PM / OPP: extend DT parsing to allow voltage ranges
Date: Tue, 20 May 2014 18:45:24 +0200
Message-ID: <1400604324.4853.51.camel@weser.hi.pengutronix.de>
References: <1400596060-5330-1-git-send-email-l.stach@pengutronix.de>
	 <1400596060-5330-3-git-send-email-l.stach@pengutronix.de>
	 <537B6782.5080505@ti.com>
	 <1400596877.4853.16.camel@weser.hi.pengutronix.de>
	 <CAGo_u6qTFzVMhcWrk0L5Z4zykfLTMrkph0b4AJNEX7SS7pvWxQ@mail.gmail.com>
	 <1400598429.4853.29.camel@weser.hi.pengutronix.de>
	 <CAGo_u6ru5OgwCbJRrMNXUzeNLFMUvW=j8su6AAC4vmy3GOSM2g@mail.gmail.com>
	 <CAGo_u6omOyuXvpDcirm36AnreGfa4nxisQ8BqZ8p2AVmWjfwbA@mail.gmail.com>
	 <1400600908.4853.41.camel@weser.hi.pengutronix.de>
	 <CAGo_u6pyU1O0uv-3CJc6OPoJ+bkcpNJ9_26JL3DxugX7dJhZfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59435 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbaETQqk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 12:46:40 -0400
In-Reply-To: <CAGo_u6pyU1O0uv-3CJc6OPoJ+bkcpNJ9_26JL3DxugX7dJhZfA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Am Dienstag, den 20.05.2014, 11:09 -0500 schrieb Nishanth Menon:
> On Tue, May 20, 2014 at 10:48 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Am Dienstag, den 20.05.2014, 10:29 -0500 schrieb Nishanth Menon:
> >> On Tue, May 20, 2014 at 10:23 AM, Nishanth Menon <nm@ti.com> wrote:
> 
> [...]
> >> If you need to handle PMIC accuracy, use voltage-tolerance.
> >>
> > And that's exactly one of the issues of the current binding, the
> > tolerance isn't stable, but rather per OPP.
> >
> > As an example look at two operating points of the i.MX5:
> >
> > /*  kHz min(uV) nom(uV) max(uV) */
> >  166666  850000  900000 1400000
> > 1200000 1300000 1350000 1400000
> >
> > So for the 1,2GHz OPP the voltage tolerance is just 3,7% as anything
> > bigger would exceed the absolute maximum rating, but for the 166MHz OPP
> > it is already 64,7%.
> >
> > I agree that I could just cap the rail at 1,4V and give a max voltage
> > equal to that as max_volt to the regulator API, but actually the device
> > doesn't even know it's tolerance as it has no max defined. It makes
> > having a max_volt in the regulator API kind of senseless, as connected
> > devices don't know their maximum rating.
> 
> Is'nt that(voltage-tolerance binding) a different problem that needs a
> different solution rather than creating a new binding for OPP - which
> actually makes no description sense (since the max is absolute max)?
> 
Ok, I agree that having a nominal voltage isn't really required, so this
leaves us with min...max, where min is already there in the OPP
framework.

The question here is: are there any devices out there where we could
imagine a frequency dependent max-voltage? I could very well image such
a thing for CPU devices, where thermal constraints would force us to
reduce the regulator voltage to allow for a higher frequency. If any
device on the same rail needs a higher voltage this would prevent using
the higher OPP.

I have never seen such a device in practice, so maybe just having a
global max-voltage property is the right thing. I'll have to think about
this.

> How can we address that? should we add some logic that says:
> 
> if voltage tolerance == 0, then try min_uV to max_opp_uV?
> OR
> introduce a new binding that says absolute-max-voltage (this is what I
> was planning on doing with voltage domain btw).. and ensure that that
> is used?
> 
> Personally, I never liked voltage-tolerance binding precisely for the
> same reason as you bring up.. but that is a ABI now and we need to see
> if the requirements can match with it, or define a new one keeping the
> old ABI alive..
> 
I would like to keep the focus on new drivers using OPPs. How to fit in
drivers with existing bindings is to be defined later. I'm working on a
new cpufreq driver and would like to work out a solution that avoids
using this wobbly voltage-tolerance.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

