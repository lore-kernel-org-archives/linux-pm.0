From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [Bug 203297] Synaptics touchpad TM-3127 functionality broken by PCI
 runtime power management patch on 4.20.2
Date: Mon, 22 Apr 2019 08:08:14 -0500
Message-ID: <20190422130814.GJ173520@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Keijo Vaara <ferdasyn@rocketmail.com>, Jean Delvare <jdelvare@suse.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203297

Regression, suspected but as yet unconfirmed cause:

  c5eb1190074c ("PCI / PM: Allow runtime PM without callback functions")

backported to 4.20 stable as 39e1be324c2f.

Keijo Vaara <ferdasyn@rocketmail.com> reported:

> After upgrading from 4.20.1 to 4.20.2 Synaptics touchpad TM-3127 on HP
> 250 G5 is recognized in all logs like normal, but PCI runtime power
> management seems to keep it from working shortly after module
> initialization. Issuing "modprobe -r psmouse && modprobe psmouse" fixes
> the issue but the device stops working again if inactive for a second or
> so. This is likely caused by https://lkml.org/lkml/2019/1/11/615.
> 
> Possible workarounds known to work:
> 1) Forcing psmouse module to use imps protocol works, but disables most
> of the touchpad functionality such as two finger scrolling.
> 2) Disabling PCI runtime power management for the device (f.e. using tlp
> RUNTIME_PM_ON_BAT=on fixes the issue)
> 3) Downgrade kernel to 4.20.1
> 
> The bug has been reported by multiple users with different software
> setups, all with HP laptops (see
> https://bbs.archlinux.org/viewtopic.php?id=243677 for more info).
> 
> The suspect commit from kernel log:
> 
> commit 39e1be324c2f9048b013aaa190acf91b3f23b1a8
> Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Date:   Tue Oct 23 14:45:52 2018 +0300
> 
>     PCI / PM: Allow runtime PM without callback functions
>     
>     commit c5eb1190074cfb14c5d9cac692f1912eecf1a5e4 upstream.
>     
>     a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
>     nullified the runtime PM suspend/resume callback pointers while keeping the
>     runtime PM enabled.
>     
>     This caused the SMBus PCI device to stay in D0 with
>     /sys/devices/.../power/runtime_status showing "error" when the runtime PM
>     framework attempted to autosuspend the device.  This is due to PCI bus
>     runtime PM, which checks for driver runtime PM callbacks and returns
>     -ENOSYS if they are not set.
>     
>     Since i2c-i801.c doesn't need to do anything device-specific for runtime
>     PM, Jean Delvare proposed this be fixed in the PCI core rather than adding
>     dummy runtime PM callback functions in the PCI drivers.
>     
>     Change pci_pm_runtime_suspend()/pci_pm_runtime_resume() so they allow
>     changing the PCI device power state during runtime PM transitions even if
>     the driver supplies no runtime PM callbacks.
>     
>     This fixes the runtime PM regression on i2c-i801.c.
>     
>     It is not obvious why the code previously required the runtime PM
>     callbacks.  The test has been there since the code was introduced by
>     6cbf82148ff2 ("PCI PM: Run-time callbacks for PCI bus type").
>     
>     On the other hand, a similar change was done to generic runtime PM
>     callbacks in 05aa55dddb9e ("PM / Runtime: Lenient generic runtime pm
>     callbacks").
>     
>     Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
>     Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>     Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Jean Delvare <jdelvare@suse.de>
>     Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Cc: stable@vger.kernel.org      # v4.18+
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
