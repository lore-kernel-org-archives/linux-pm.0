From: David Brownell <david-b@pacbell.net>
Subject: Fwd: [patch 2.6.14-rc2 0/12] USB updates,
	mostly for suspend/resume
Date: Wed, 28 Sep 2005 09:26:42 -0700
Message-ID: <200509280926.42922.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============15669350390971282=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============15669350390971282==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This stuff isn't yet in the MM tree, but it's in Greg's USB queue.

----------  Forwarded Message  ----------

Subject: [patch 0/12] USB updates, mostly for suspend/resume
Date: Thursday 22 September 2005 10:29 pm
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Cc: Greg KH <greg@kroah.com>

Here are a bunch of USB updates, many making power management
become simpler, for 2.6.15.early merging.  They go on top of
2.6.14-rc2 with the patches already in Greg's queue [1].

The patches can be grouped roughly into three subsequences:

   * Stuff that's pretty isolated; the first two listed here don't
     actually affect anything else in this series.

	- pm-shrink.patch ... saves a word per struct device, when
		CONFIG_PM is enabled.  Actually, safe for 2.6.14 ...

	- quirk-ohci.patch ... builds on the PCI quirk patch, fixing
		some problems in "early handoff" code for OHCI.
		(Depends on the "quirk.patch" that needs some
		minor build fixes.)

	- ehci-mporter.patch ... Matt Porter's patch to split out
		the PCI-specific  bits from the ehci-hcd.  Minor
		updates included, making it build with CONFIG_PM.

	- pm-hub.patch ... now with CONFIG_PM, all HCDs provide
		access to their root hub suspend/resume methods.
		Mostly an issue for some non-PCI OHCI code.

   * PM updates for usbcore.  This is the stuff that simplifies
     things by making CONFIG_USB_SUSPEND mean a lot less.

	- pm-root1.patch ... a handful of PM updates that don't
		directly affect much else; e.g. a new method that
		can make OHCI autosuspend work again.

	- pm-root2.patch ... gets rid of lots of special cases
		and merges most of the USB_SUSPEND logic in
		with normal PM support.

	- pm-rootpci.patch ... make the PCI bus glue catch up
		to pm-root2.patch changes

	- pm-usbsusp2.patch ... we don't want to export these
		two routines any more

   * HCD updates to match pm-root2.patch; mostly minor/obvious
     removal of code.  Also included:  updates to make some more
     swsusp special cases work. 

	- pm-ohci.patch
	- pm-ehci.patch
	- pm-uhci.patch
	- pm-isp116x.patch

The stack has been tested on a handful of strategic OHCI and EHCI
configurations, involving remote wakeup (1..3 hubs involved),
swsusp disk snapshot/resume, and both USB_SUSPEND settings.  But
I'd not be surprised to find a few configurations with bugs,
not necessarily involving UHCI or ISP116x hardware.  :)

- Dave

[1] http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


-------------------------------------------------------

--===============15669350390971282==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============15669350390971282==--
