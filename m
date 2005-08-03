From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch 2.6.13-rc5] driver model wakeup support
Date: Wed, 3 Aug 2005 09:37:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508030931290.4886-100000@iolanthe.rowland.org>
References: <200508021526.12073.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============96617288505767318=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200508021526.12073.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============96617288505767318==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 2 Aug 2005, David Brownell wrote:

> Here's a refresh of my driver model wakeup patch.  Two
> changes from last time:
> 
>   - It sets up USB too, not just PCI.  So keyboards and hubs,
>     plus a few network adapters, will have these attributes.
> 
>   - Only devices that are known to have wakeup capabilities
>     have the attribute.   So "find /sys/devices -name wakeup"
>     returns only "interesting" devices.
> 
> At this time, wakeup mechanisms need to be explicitly enabled
> in userspace code; so this is in a sense a policy setting API
> affecting runtime (and suspend-to-ram time) device-specific PM.
> 
> There will be some usbcore changes to follow this, assuming
> this gets on the 2.6.14 train ... replacing current kluges.

Nice to see this finally get into the kernel.

The PCI part of this patch should try to use ACPI to identify devices
capable of platform-specific non-PME wakeup signalling.  I don't have the
faintest idea how to do this; maybe Len can help.

> +#define device_set_wakeup_enable(dev,val) \
> +       ((dev)->power.should_wakeup = (dev)->power.can_wakeup ? !!(val) : 0)

This can be simplified to:

+#define device_set_wakeup_enable(dev,val) \
+       ((dev)->power.should_wakeup = ((dev)->power.can_wakeup && val));

Alan Stern


--===============96617288505767318==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============96617288505767318==--
