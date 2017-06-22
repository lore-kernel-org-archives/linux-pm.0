From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: Drivers taking different actions depending on sleep state
Date: Thu, 22 Jun 2017 10:51:02 +0200
Message-ID: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
References: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
 <CAJZ5v0iL7voAz9T+36fXXncOj4UrFSAH8WzwEbec96GuFUteaQ@mail.gmail.com>
 <ccac39d6-4611-8b46-12f7-24227ef3b35e@gmail.com>
 <CAJZ5v0g_egRwxOLqft=JhvzAqBWuyvC8yiO7De5TYUZLUT2Fpw@mail.gmail.com>
 <7001768d-9134-4975-127e-e8444e00f677@gmail.com>
 <CAJZ5v0ihqn5Xcj1yoZcrb7caYiH+x8YivLJit6BqvDGradZJ=Q@mail.gmail.com>
 <b7a49925-d823-b03d-2990-2894ba2c2714@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60940 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbdFVIvP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jun 2017 04:51:15 -0400
Content-Disposition: inline
In-Reply-To: <b7a49925-d823-b03d-2990-2894ba2c2714@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 21/06/2017 at 16:55:04 -0700, Florian Fainelli wrote:
> > That is conceivable, but again, the meaning of STANDBY and MEM is
> > platform-specific.  Actions to be taken for, say, STANDBY, may differ
> > from one platform to another.
> 
> True, though I would only expect drivers for that particular platform to
> care about that information and these drivers would only make sense on
> that particular platform so the meaning of STANDBY and MEM would be
> clear for those drivers. The intent is really to keep the "distributed"
> model where individual drivers manage their particular piece of HW,
> while utilizing a global piece of information that is platform specific.
> 
> If this seems acceptable to you along with proper documentation to
> illustrate the platform specific meaning of these states, I will got
> ahead and cook a patch.

Well, that won't work for us. We need need two kind of information:
 - whether main clock is switched from the master clock to the slow
   clock
 - whether VDDcore will be cut

for the first one, we already have an hackish callback:
at91_suspend_entering_slow_clock() that will call from the platform
specific drivers.

The main issue now is for the second one. We also need it for IPs that
are shared with other SoCs. For example, the macb ethernet controller
that is shared with the zynq and the m_can controller. In those cases,
I don't think it is a good idea to add platform specific code in the
drivers but at the same time, I don't think it is reasonable to
unconditionally reinit the IP on resume as there is a significant
latency hit. I don't think that the xilinx guys will like when suddenly
their platform takes 500ms to resume.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
