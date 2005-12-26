From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Mon, 26 Dec 2005 18:01:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512261755280.10595-100000@netrider.rowland.org>
References: <200512261750.26186.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============14765924381838724=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200512261750.26186.dtor_core@ameritech.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============14765924381838724==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 26 Dec 2005, Dmitry Torokhov wrote:

> Device removal could happen at any point, even during suspend transition.
> The kernel should be able to handle this scenario therefore implementation
> that assumes that device tree is frozen in flawed. As far as I understand
> the only thing that does not work at the moment is invoking hotplug handler.

The situation isn't all that bad.

The device tree can be changed only by calling device_add or device_del 
(or the corresponding register/unregister routines).  That can only be 
done in process context; hence if processes are frozen it can't happen.  
Or rather, it can happen only if a suspend() or resume() method tries to 
do it.

If those methods don't try to handle device removal or addition -- which 
in most cases they shouldn't -- then there's nothing to worry about.  It's 
only oddball situations (like calling the remove method when the driver 
doesn't define a suspend method) that cause problems.

And even then, with most drivers you don't get a hotplug event when the 
driver is unbound.  It happens only with things like usb-storage, that 
define child devices.

Alan Stern


--===============14765924381838724==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============14765924381838724==--
