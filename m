From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 01/15] ARM: export arm_pm_restart()
Date: Tue, 8 Jan 2019 23:31:37 +0000
Message-ID: <20190108233137.GW11171@n2100.armlinux.org.uk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
 <20190108175818.705110-2-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190108175818.705110-2-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 08, 2019 at 06:58:04PM +0100, Lubomir Rintel wrote:
> The OLPC XO 1.75 laptop is rebooted with a command to the Embedded
> Controller. The EC driver should be a module, since most people don't need
> it to be compiled in.

Why do you need this - is there a reason why you can't hook onto the
restart_handler_list using register_restart_handler()?  The registered
handlers are passed the command.

I would rather this is not exported to modules, it is generally unsafe
to hook stuff by directly poking function pointers from module code.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
