From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 2.6.12-rc4] driver model wakeup support
Date: Sun, 8 May 2005 21:49:16 -0400
Message-ID: <20050509014916.GA27448@neo.rr.com>
References: <200505081724.09468.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25243217277722252=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505081724.09468.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============25243217277722252==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 08, 2005 at 05:24:09PM -0700, David Brownell wrote:
> This is a refresh of a patch I sent before.  I suspect it'd be
> appropriate to merge this, given the agreement I thought I
> heard last time I posted it.
> 
> Follow-on patches would update other subsystems to use this:
> 
>   * USB, replacing existing HCD support, when activating
>     configurations that support remote wakeup, and when
>     deciding whether to activate remote wakeup for a device
>     as it's being suspended;
> 
>   * ACPI, since there's a table flagging devices that can
>     support wakeup, and that info is basically invisible
>     to the drivers for those devices (unless the device
>     also supports PCI PM);
> 
>   * Networking, where I suspect the "ethtool" commands to
>     set wake-on-LAN should update the "may_wakeup" bit
> 
>   * ... and surely more; this after all only affects the
>     policy applying to a device wakeup, it doesn't do
>     anything to have wakeup actually work on the hardware.
> 
> The main thing I dislike about this patch is that it always
> creates the sysfs attribute, even for devices for which it's
> meaningful.  That should be fixable by just adding the
> attributes one-at-a-time. 
> 
> - Dave

I actually was working on a similar patch, but decided to stop.  I have some
concerns about the generic-ness of "wakeup".  For example, some devices may
have multiple wakeup modes or wakeup criteria.  Under these situations having
a global "wakeup" parameter might become clumsy.  So should drivers be
exporting these sort of things on their own?

"Wake-on-lan", as an example, could have 4 or 5 different packet types to look
for.  So when the user specifies one of these, he or she is expecting
"wake-on-lan" to just work.  In the case of your patch, I think the sysfs
attribute would also need to be configured.

"wakeup" seems to fit most ACPI and PCI devices well.  I'm not sure how it
would apply to usb, firewire, pcmcia, etc., especially when determining
if it supports wake.  It may just be something that only the driver knows.

A few more points:

Wakeup configuration may vary between system states, how can we account for
this?  Should wakeup information be reconfigured by userspace before entering
a sleep or off state?

Would there be any value in exporting a list of system states in which wake is
supported on a per-device basis?


> This is a refresh of an earlier patch to add "wakeup" support to
> to the PM-core model:
> 
>   * struct device_pm_info has two bits that are initialized as
>     part of setting up the enclosing struct device:
>       - "can_wakeup", reflecting system hardware capabilities
>       - "may_wakeup", the policy setting (when CONFIG_PM)
> 
>   * there's a writeable sysfs "wakeup" file, with one of three values:
>       - "enabled", when the policy is to allow wakeup 
>       - "disabled", when the policy is not to allow it
>       - "" (empty string), when the hardware doesn't support wakeup
> 
>   * this patch includes support to initialize these bits for devices
>     that support PCI PM.
> 
> It would be preferable to not have the attribute for devices that aren't
> wired with wakeup support, but that'd involve extra sysfs magic.

This probably isn't too difficult.  The question is how consistent we want
the interface to be.

Thanks,
Adam

--===============25243217277722252==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25243217277722252==--
