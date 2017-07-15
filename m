From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sat, 15 Jul 2017 20:33:58 +0200
Message-ID: <20170715183358.4bnhshokalyulswz@piout.net>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <2497538.J9F6XFeBfd@aspire.rjw.lan>
 <20170715062838.GA20741@amd>
 <5864280.u6UQBsuXnA@aspire.rjw.lan>
 <20170715164626.GA1373@amd>
 <1a5ef0ae-16f3-5a61-ae4e-083664cb30c0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1a5ef0ae-16f3-5a61-ae4e-083664cb30c0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 15/07/2017 at 10:20:27 -0700, Florian Fainelli wrote:
> > We already have
> > 
> > struct regulator_state {
> >        int uV; /* suspend voltage */
> >        unsigned int mode; /* suspend regulator operating mode */
> >        int enabled; /* is regulator enabled in this suspend state */
> >        int disabled; /* is the regulator disabled in this suspend state */
> > };
> > 
> >  * struct regulation_constraints - regulator operating constraints.
> >   * @state_disk: State for regulator when system is suspended in disk
> >   * mode.
> >   * @state_mem: State for regulator when system is suspended in mem
> >   * mode.
> >   * @state_standby: State for regulator when system is suspended in
> >   * standby
> >   *                 mode.
> >    
> > . So it seems that maybe we should tell the drivers if we are entering
> > "state_mem" or "state_standby" (something I may have opposed, sorry),
> > then the driver can get neccessary information from regulator
> > framework.
> 
> OK, so what would be the mechanism to tell these drivers about the
> system wide suspend state they are entering if it is not via
> platform_suspend_target_state()?
> 
> Keep in mind that regulators might be one aspect of what could be
> causing the platform to behave specifically in one suspend state vs.
> another, but there could be pieces of HW within the SoC that can't be
> described with power domains, voltage islands etc. that would still have
> inherent suspend states properties (like memory retention, pin/pad
> controls etc. etc). We still need some mechanism, possibly centralized
> 

I concur, the regulator stuff is one aspect of one of our suspend state
(cutting VDDcore). But we have another state where the main clock (going
to the IPs) is going from a few hundred MHz to 32kHz. This is currently
handled by calling at91_suspend_entering_slow_clock(). I think it is
important to take that into account so we can remove this hack from the
kernel.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
