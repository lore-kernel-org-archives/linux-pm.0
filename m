From: Greg KH <greg@kroah.com>
Subject: Re: Power event notification patch
Date: Mon, 9 Jul 2007 09:34:11 -0700
Message-ID: <20070709163411.GA16617@kroah.com>
References: <20070706184153.GA4486@kroah.com>
	<67670A5CEA5C374B8E7B16D7DC55F953012909BA@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <67670A5CEA5C374B8E7B16D7DC55F953012909BA@bgsmsx413.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


On Mon, Jul 09, 2007 at 10:04:42AM +0530, V, Sankara Narayanan wrote:
> Dbus is a distro specific thing and you cannot be really dependent on
> that if you are going for real time systems.

And you can't depend on this message getting out either if you are using
a "real time system", so that's not an argument to add this at all,
sorry.

And yes, dbus is on _all_ distros these days, you will not have a
working system without much functionality if you do not have it (heck,
even the nokia devices use it.)

> Also, they have their own bindings for the notification support
> (dbus-glib and dbus-qt).

I don't see this being a problem, why do you?  No one forces you to use
those bindings, you can listen to "raw" dbus messages quite easy from a
simple C program if you want to.

> One more drawback with dbus (apart from the above one), it will be
> another redirection before our application receives the notification).

You already have that if you are using udev, as udev will be the one
that grabs this uevent and passes it to dbus anyway.  Unless you are
going to say you aren't using udev either?

> Also, if you say S3/S4 are PC oriented (or intel specific; It is
> mentioned in ACPI spec.) terms, the suspend-to-ram and to disk is not
> necessarily PC (or intel) oriented. 

Yeah, "suspend-to-ram" and disk are not pc oriented, but that is not
what you called your kevents, so why mention that?

thanks,

greg k-h
