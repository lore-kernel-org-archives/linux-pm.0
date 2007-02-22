From: Greg KH <greg@kroah.com>
Subject: Re: [patch/rfc 0/6] rtc framework: remove class_device,
	use class suspend()/resume()
Date: Thu, 22 Feb 2007 10:09:41 -0800
Message-ID: <20070222180941.GA15289@kroah.com>
References: <200702211945.15003.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200702211945.15003.david-b@pacbell.net>
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
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>, rtc-linux@googlegroups.com, john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 21, 2007 at 07:45:14PM -0800, David Brownell wrote:
> Hi,
> =

> Following this message (on the RTC list) are six patches:
> =

>  - Remove the /sys/class/rtc-dev class_device, and a class_interface
>  - Use "struct rtc_device" in the external interface, not class_device
>  - Simplify the sysfs attribute handling, removing a class_interface
>  - Simplify the /proc/driver/rtc handling, removing the last class_interf=
ace
>  - Remove the class_device in "struct rtc_device"; now suspend()/resume()=
 work
>  - Implement class suspend()/resume() so the system clock is updated on r=
esume
> =

> The main point of this series of patches is that last one, which I'll
> circulate just a bit more widely.  (Although I think the first four are
> also nice cleanups!)   It might be the first example of a framework that
> uses the "new" class level suspend()/resume() calls to offload drivers.
> =

> Other than actually using that new PM infrastructure, this series should
> be interesting since it addresses one of the few remaining obstacles to
> having the "Generic Time-Of-Day" (GTOD) framework be fully generic, in
> the sense of working with whatever RTC is available on the platform (which
> includes ones accessed through I2C or SPI, so that spinlocked access is
> insufficient) and removing arch-specific RTC hooks.
> =

> This has been lightly tested on one of the ARMs that doesn't yet have
> new-style dynamic tick working.  I'm sure fault paths need tweaking yet.

All of these looks good to me, feel free to add an:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to them if you want.

thanks for doing the class_device removal work, I appreciate it.

greg k-h
