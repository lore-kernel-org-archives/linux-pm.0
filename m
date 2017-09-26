From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] PM: ARM: sa1111: Drop suspend and resume bus type
 callbacks
Date: Tue, 26 Sep 2017 22:28:14 +0100
Message-ID: <20170926212812.GS20805@n2100.armlinux.org.uk>
References: <2654085.Tx1JnNWXkX@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2654085.Tx1JnNWXkX@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 26, 2017 at 10:47:10PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> None of the sa1111 drivers in the tree implements the suspend and
> resume callbacks from struct sa1111_driver, so drop them and drop
> the corresponding callbacks from sa1111_bus_type.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This will conflict with some patches I have - would you like me to queue
it along with my changes?  When would you like to get this merged?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
