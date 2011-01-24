From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: User tool for configuring wake-up devices
Date: Mon, 24 Jan 2011 11:17:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101241107330.2030-100000__44313.0936044783$1295886003$gmane$org@iolanthe.rowland.org>
References: <201101241509.48032.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101241509.48032.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, oneukum@suse.de, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Jan 2011, Thomas Renninger wrote:

> Hi,
> 
> some time ago we talked about a userspace tool
> which can enable specific devices to be able to
> wake the machine up from suspend.
> 
> While Rafael solved that for network directly
> in the driver iirc (should work via ethtool now),
> there wasn't any outcome for
> other devices (usb, key, mouse, generic ACPI implementation
> reading out device's sysfs path...) to activate them as
> wakeup devices in a userfriendly way?

I'm not aware of any.  (Note that keyboard devices are supposed to be
enabled for wakeup by default, although this may not yet be implemented
in all the keyboard drivers.)

> Oliver just asked me for a tool to e.g. configure
> and enable usb or other devices as wake-up devices.
> 
> I quickly googled and found:
>   - acpitools (http://sourceforge.net/projects/acpitool)
>     rather old, I doubt it does any sysfs reads to find
>     out which devices could be configured and of what
>     type they are?
> 
>   - acpi-wakeup
>     even less feature rich...
> 
> In sysfs is this supposed to work via:
> /sys/devices/.../power/wakeup_active
> now?

The filename is just "wakeup", not "wakeup_active".  It's worth 
pointing out that for USB devices, one must enable wakeup both on the 
device itself and also on the host controller for the device's bus.

> How are users supposed to enable devices for suspend wake up?

By writing "enabled" to the sysfs file.  Writing "disabled" to the file 
has the opposite effect.

Currently this is done by udev rules, by desktop config programs, or by
manually adding lines to system shell scripts.

> Are there any tools already which are worth packaging
> or is such a tool waiting for implementation?

I don't know of any tools capable of handling this.

Alan Stern
