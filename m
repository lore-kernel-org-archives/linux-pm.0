From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: Toward runtime power management in Linux
Date: Tue, 02 Aug 2005 10:45:29 -0700
Message-ID: <42EFB139.3080406@am.sony.com>
References: <Pine.LNX.4.44L0.0507302219250.13423-100000@netrider.rowland.org>
	<Pine.LNX.4.50.0508011712220.2764-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============68860964695467897=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0508011712220.2764-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============68860964695467897==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Mochel wrote:
> - Automatic (or Dynamic) Suspend
> 
>   This is where a device will enter a low power state after a certain
>   amount of time has elapsed without any activity.
> 
>   The amount of time should be configurable on a per-device basis through
>   a sysfs interface.
> 
>   What defines "inactivity" is driver-dependent, and we expect to be
>   class-dependent (some classes may define inactivity as the device not
>   being opened; others may define it as having no read()/write() calls;
>   still others may define it as not having any network packets besides
>   ARP requests; you get the idea..) IOW, it doesn't matter to the core.
> 
>   The device should enter a low-power state that it supports. It doesn't
>   matter what state this is, and it's debatable whether or not it should
>   be exported/configurable via sysfs. (It's possible that a userspace-
>   based policy may wish to adjust this based on its extra knowledge about
>   system features/bugs, or based on the desired latency/consumption
>   tradeoff for the particular system or configuration (plugged, unplugged,
>   etc).
>   The device must be powered back on when a new request comes in. Again,
>   whether this is on open(), read(), or socket() is up to the class and
>   the drivers of that class.
> 
> - Directed Suspend
> 
>   This where a user or an application specifies a device to enter a lower
>   power state.
> 
>   The states that a device exports (allows to be set) should be exported.
>   The application should specify which state to enter.
> 
>   By default, the device may not respond to I/O requests. There must be a
>   flag exported to control this.
> 
> - Performance
> 
>   (This was not covered in detail, but based on the specified interface
>   above, it's pretty easy.)
> 
>   The states a device (and its driver) support should be exported via
>   sysfs.
> 
>   A user or application specifies which state to enter.
> 
>   This may turn on/off different functional components of the device. The
>   drivers need to be prepared to handle that.
> 

As you hint on, there is a question of the interface between a policy 
manager and the devices.  Many embedded devices need to aggressively manage 
power, so need to have an interface that allows device specific monitoring 
and control, yet for an average system a more generic policy manager included 
in a vendor's distribution could provide usable PM on a range of systems 
through a generic interface.

So a question is how to support this.  I suppose the PM system could allow 
both system specific interfaces and a 'generic standard' interface to be 
exported, with some mapping between.

-Geoff


--===============68860964695467897==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============68860964695467897==--
