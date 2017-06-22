From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Drivers taking different actions depending on sleep state
Date: Thu, 22 Jun 2017 18:00:21 +0200
Message-ID: <1791746.otcIQZBd7p@aspire.rjw.lan>
References: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr> <b7a49925-d823-b03d-2990-2894ba2c2714@gmail.com> <20170622085102.mpk7vxodpgxtrlfd@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53843 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750812AbdFVQHl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jun 2017 12:07:41 -0400
In-Reply-To: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thursday, June 22, 2017 10:51:02 AM Alexandre Belloni wrote:
> On 21/06/2017 at 16:55:04 -0700, Florian Fainelli wrote:
> > > That is conceivable, but again, the meaning of STANDBY and MEM is
> > > platform-specific.  Actions to be taken for, say, STANDBY, may differ
> > > from one platform to another.
> > 
> > True, though I would only expect drivers for that particular platform to
> > care about that information and these drivers would only make sense on
> > that particular platform so the meaning of STANDBY and MEM would be
> > clear for those drivers. The intent is really to keep the "distributed"
> > model where individual drivers manage their particular piece of HW,
> > while utilizing a global piece of information that is platform specific.
> > 
> > If this seems acceptable to you along with proper documentation to
> > illustrate the platform specific meaning of these states, I will got
> > ahead and cook a patch.
> 
> Well, that won't work for us. We need need two kind of information:
>  - whether main clock is switched from the master clock to the slow
>    clock
>  - whether VDDcore will be cut
> 
> for the first one, we already have an hackish callback:
> at91_suspend_entering_slow_clock() that will call from the platform
> specific drivers.
> 
> The main issue now is for the second one. We also need it for IPs that
> are shared with other SoCs. For example, the macb ethernet controller
> that is shared with the zynq and the m_can controller. In those cases,
> I don't think it is a good idea to add platform specific code in the
> drivers but at the same time, I don't think it is reasonable to
> unconditionally reinit the IP on resume as there is a significant
> latency hit. I don't think that the xilinx guys will like when suddenly
> their platform takes 500ms to resume.

We can add a ->target_state callback in struct platform_suspend_ops that
will return a value representing the the particular target state the platform
has chosen to go to.  Along with it, there can be a list of values for all
of the low-level sleep states defined by all of the different platforms
(in which case I'd like to reserve values 0-5 for the ACPI system states).

There can be a wrapper, say platform_suspend_target_state() around that,
so the driver will call it, compare the return value with what is known to it
about the different platforms it can run on and act accordingly.

Thanks,
Rafael
