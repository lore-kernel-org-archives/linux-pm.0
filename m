From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] power: reset: at91-reset: enable I-cache for at91sam9260_reset
Date: Tue, 16 Oct 2018 16:52:40 +0200
Message-ID: <2351196.3BzoFE0xYq@ws-140106>
References: <20181007125815.8392-1-jonas@threetimestwo.org> <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: jonas@orbital-systems.com, linux-kernel@vger.kernel.org, sre@kernel.org, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 16, 2018, 3:30:24 PM CEST Claudiu.Beznea@microchip.com wrote:
> Hi Jonas,
> 
> On 07.10.2018 15:57, Jonas Danielsson wrote:
> > From: Jonas Danielsson <jonas@orbital-systems.com>
> > 
> > This fixes a bug where our embedded system (AT91SAM9260 based) would
> > hang at reboot. At the most we managed 16 boot loops without a hang.
> > 
> > With this patch applied the problem has not been observed and the board
> > has managed above 250 boot loops.
> > 
> > The AT91SAM9260 datasheet tells us that with the instruction cache
> > disabled all instructions are fetched from SDRAM. And we have an errata
> > telling us we must power down the SDRAM before issuing cpu reset.
> > 
> > This means we need the instruction cache enabled in at91sam9260_reset()
> > At the moment it is being disabled in cpu_proc_fin() which is called from
> > arch/arm/kernel/reboot.c.
> 
> Are you using kexec reboot or implemented hibernate mode on this machine?
> I'm seeing cpu_proc_fin() is called only in case of kexec reboot or
> switching to hibernate mode.
> 
> In case of normal reboot (e.g. reboot command) machine_restart() from
> arch/arm/kernel/reboot.c is called. Please correct me if I'm wrong.

Another location is cpu_reset() aka cpu_arm926_reset() in proc-arm926.S
which also disables I-cache. But I can't track down a callstack
ending there.

Best regards,
Alexander
