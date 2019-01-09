From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v4 01/15] ARM: export arm_pm_restart()
Date: Wed, 09 Jan 2019 08:24:04 +0100
Message-ID: <916efaa742e0b621f02b385f0ac6f186b960c028.camel@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
         <20190108175818.705110-2-lkundrak@v3.sk>
         <20190108233137.GW11171@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108233137.GW11171@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2019-01-08 at 23:31 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 08, 2019 at 06:58:04PM +0100, Lubomir Rintel wrote:
> > The OLPC XO 1.75 laptop is rebooted with a command to the Embedded
> > Controller. The EC driver should be a module, since most people don't need
> > it to be compiled in.
> 
> Why do you need this - is there a reason why you can't hook onto the
> restart_handler_list using register_restart_handler()?  The registered
> handlers are passed the command.

Actually, yes. The restart handlers are invoked in atomic context, but
the EC communication needs to block. (The 1.75 EC is actually a SPI
master: a command it initiated by poking a GPIO and waiting until EC
tells us it's ready to read a command.)

Sorry for not mentioning that earlier, I forgot that it is the case.

> I would rather this is not exported to modules, it is generally unsafe
> to hook stuff by directly poking function pointers from module code.

Lubo
