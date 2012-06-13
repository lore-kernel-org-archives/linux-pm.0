From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] PCI: add NO_D3_DURING_SLEEP flag and revert
 151b61284776be2
Date: Wed, 13 Jun 2012 08:27:01 -0700
Message-ID: <20120613152701.GA28116@kroah.com>
References: <201206131122.36198.rjw@sisk.pl>
 <Pine.LNX.4.44L0.1206131117260.1401-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1206131117260.1401-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, "Oleksij Rempel (fishor)" <bug-track-M18mAb7Tlt0yCq4wW13eYl6hYfS7NtTn@public.gmane.org>, =?iso-8859-1?Q?D=E2niel?= Fraga <fragabr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 13, 2012 at 11:20:19AM -0400, Alan Stern wrote:
> This patch (as1558) fixes a problem affecting several ASUS computers:
> The machine crashes or corrupts memory when going into suspend if the
> ehci-hcd driver is bound to any controllers.  Users have been forced
> to unbind or unload ehci-hcd before putting their systems to sleep.
>=20
> After extensive testing, it was determined that the machines don't
> like going into suspend when any EHCI controllers are in the PCI D3
> power state.  Presumably this is a firmware bug, but there's nothing
> we can do about it except to avoid putting the controllers in D3
> during system sleep.
>=20
> The patch adds a new flag to indicate whether the problem is present,
> and avoids changing the controller's power state if the flag is set.
> Runtime suspend is unaffected; this matters only for system suspend.
> However as a side effect, the controller will not respond to remote
> wakeup requests while the system is asleep.  Hence USB wakeup is not
> functional -- but of course, this is already true in the current stat=
e
> of affairs.
>=20
> A similar patch has already been applied as commit
> 151b61284776be2d6f02d48c23c3625678960b97 (USB: EHCI: fix crash during
> suspend on ASUS computers).  The patch supersedes that one and revert=
s
> it.  There are two differences:
>=20
> 	The old patch added the flag at the USB level; this patch
> 	adds it at the PCI level.
>=20
> 	The old patch applied to all chipsets with the same vendor,
> 	subsystem vendor, and product IDs; this patch makes an
> 	exception for a known-good system (based on DMI information).
>=20
> Signed-off-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> Tested-by: D=E2niel Fraga <fragabr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Tested-by: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
> Tested-by: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
> CC: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
> CC: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>=20
> ---
>=20
> Greg, do you mind if this goes in through Rafael's tree?

Not at all, but I can also take it.

Rafael, if you want to take it, please add:

Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>

to it, or let me know, and I can take this through my tree.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
