From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: [RFC] Driver States
Date: Tue, 29 Mar 2005 21:57:43 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503292155120.26543-100000@monsoon.he.net>
References: <1111963367.3503.152.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============55904417521386773=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <1111963367.3503.152.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============55904417521386773==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sun, 27 Mar 2005, Adam Belay wrote:

> Dynamic power management may require devices and drivers to transition
> between various physical and logical states.  I would like to start a
> discussion on how these might be defined at the bus, driver, and class
> levels.

<snip>

> Bus Level
> =========
> At the bus level, there are two state attributes, power and
> enable/disable.  Enable/disable may mean different things on different
> buses, but they generally refer to resource decoding.  A device can only
> be enabled during a non-off power state.

<...>

> Driver Level
> ============
> At the driver level there are two areas of interest, physical and
> logical state.  There is an additional concern of transitioning between
> these states multiple times.  Because a driver acts as a bridge between
> physical and logical components, I think separating these steps seems
> natural.

<...>

> *attach - allocates data structures, creates sysfs entries, prepares driver
>        to handle the hardware.
>
> *start -  Sets up device resources and configures the hardware.  Loads
> firmware, etc.
> (physical)
>
> *open -   engages the hardware, and makes it usable by the class device.
> (logical and physical)
>
> *close -  disengages the hardware, and stops class level access
> (logical and physical)
>
> *stop -   physically disables the hardware
> (physical)
>
> *detach - tears down the driver and releases it from the "struct device"
>

You have a few things here that can easily conflict, and that will be
developed at different paces. I like the direction that it's going, but
how do you intend to do it gradually. I.e. what to do first?


	Pat


--===============55904417521386773==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============55904417521386773==--
