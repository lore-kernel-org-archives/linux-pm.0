From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 13 Apr 2012 11:29:09 -0400
Message-ID: <1334330949.23924.360.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204131008010.1185-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-854DwyC3Fveln4UfAkCs"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204131008010.1185-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--=-854DwyC3Fveln4UfAkCs
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit

On Fri, 2012-04-13 at 10:10 -0400, Alan Stern wrote:
> On Thu, 12 Apr 2012, Alan Stern wrote:
> 
> > Tomorrow I'll look through the code more carefully; with those changes
> > there really is very little difference between the two cases.  Things
> > like mmio mappings and IRQs requested; they shouldn't cause a crash.
> 
> Let's start with some basic information.  First, before suspending,
> what shows up in /sys/kernel/debug/usb/devices?

Attached (after gzipping it).

> 
> Second, if you do
> 
> 	echo 0 >/sys/bus/usb/devices/usb1/bConfigurationValue

This never returned. I did the echo, and the command locked up.

(process 3077)

cat /proc/3077/wchan 
usb_disconnect

-- Steve


> 	echo 0 >/sys/bus/usb/devices/usb2/bConfigurationValue
> 
> before suspending (using a vanilla kernel and no script), does it 
> change the behavior?  I expect it won't, but we should check just to be 
> thorough.
> 
> Alan Stern


--=-854DwyC3Fveln4UfAkCs
Content-Type: application/x-gzip; name="devices.gz"
Content-Disposition: attachment; filename="devices.gz"
Content-Transfer-Encoding: base64

H4sICNVEiE8AA2RldmljZXMA7Vddb9owFH3Pr7CEJoVpY752EgJSHiDt1kjthsbaPU6QhIEWyJTE
FO3X7zofNNCEwtpI7dQnAz72OT7HvjbKtz4hQxFbVCOX/tqilIyiVZK2YZS2dvb1zF+3LEKAjH97
lk7xl6uNPbcIU4Y4xSAIQhe76QcTe0RMVELftN+RloOj8Wf5KQ7lJ+UM4Td+ZBHekbMHyN1T52JK
SJuMxTSTECInR4bR2CI90rJnP2NJrozSwSsvjCzwjKlEes4ZjkH0V9QvJwVljKiryUrMJm4iIuS6
XKzEBvugo713RZyES7KZu4sfc9dLwXIa4SbW5sJ2yEUYJ8QOV0kUBoEfpYCxHy0mwWexnOJsyEb7
lPcp7VDF7r/Ftc1QHhCU2ZLtIIksXxo0uo3kmpcDxUGYM8Neil4lsmmdj7JB9Q6g69FijYzYqZxL
mz3LBNVppwyUq+hup53bRIhGnHVgMd1YxoqyDZafEqxmUvLoYNkDwUKm2NCOCpa9BlsdLHt2wdJG
g/Wrgj0/IVjaB+8FBQt5sLAbLBTBsv1gjSc7giY1u3dJMS1LCk/Fs3IPKt2DJzkWvPpYsP/zWExe
wrGA12Px+GPBcvdYjXs8dQ8YKdyr2uc+VW8DN1zlOuFo94yte2D2UveMXgd6JffYv7jHD6vK3Zsm
Ij7CPzBS/wDdy7GUqV9yLFOHIvi1xRrZTqV3WJNt563HbtcBu+tgp68D1RfacEVx6N7tA7q/DpNv
tdVjHcSWtUEj2nonaOvVamNNaIPu8dpK2H1tvAltTD9eWwm7r01rQhvnx2srYfe16U1o007YbyXs
g9UTsurJiuqp7d89ldVzpi4XsVtUeXbkvyLu8aJ66l2gafUE6HB6/5Uw+IPN7WTt77wJrsdDKYJc
39jk5tOAfPen9mRZ8SrY4LMAamuyWdRkncqaPMDhHxdRnOSF2ZnZoVglRYDUV9cLzw/zxfLiSnvo
JtwdBvs3oVi7aX9FnNXlXDtQdmkVJaulrKuQlcrrp7l/Eek7GxGYmW1Epov60vfEpDre/PWkvBFS
kC+pelKtGVKdGwdI9UZIGdUOZWo0Q2qYh0i7jZBy2i1vpL8EtlofZxQAAA==


--=-854DwyC3Fveln4UfAkCs--

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
