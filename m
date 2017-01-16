From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5 3/8] PCI: Don't block runtime PM for Thunderbolt host
 hotplug ports
Date: Mon, 16 Jan 2017 12:29:27 +0200
Message-ID: <20170116102927.GA2023@lahna.fi.intel.com>
References: <cover.1484486499.git.lukas@wunner.de>
 <be633737115c0be241fccd75bc136dd1da72c1b5.1484486499.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:1507 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751226AbdAPKbn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Jan 2017 05:31:43 -0500
Content-Disposition: inline
In-Reply-To: <be633737115c0be241fccd75bc136dd1da72c1b5.1484486499.git.lukas@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:
> Hotplug ports generally block their parents from suspending to D3hot as
> otherwise their interrupts couldn't be delivered.
> 
> An exception are Thunderbolt host controllers:  They have a separate
> GPIO pin to side-band signal plug events even if the controller is
> powered down or its parent ports are suspended to D3.  They can be told
> apart from Thunderbolt controllers in attached devices by checking if
> they're situated below a non-Thunderbolt device (typically a root port,
> or the downstream port of a PCIe switch in the case of the MacPro6,1).
> 
> To enable runtime PM for Thunderbolt on the Mac, the downstream bridges
> of a host controller must not block runtime PM on the upstream bridge as
> power to the chip is only cut once the upstream bridge has suspended.
> Amend the condition in pci_dev_check_d3cold() accordingly.
> 
> This change does not impact non-Macs as their Thunderbolt hotplug ports
> are handled by the firmware rather than natively by the OS:  The hotplug
> ports are not allowed to suspend in pci_bridge_d3_possible() and keep
> their parent ports awake all the time.  Consequently it is meaningless
> whether they block runtime PM on their parent ports or not.
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
