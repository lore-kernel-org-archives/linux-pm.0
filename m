From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: comments on irc log
Date: Thu, 24 Mar 2005 10:40:46 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503241037420.8012-100000@monsoon.he.net>
References: <1111113131.25179.73.camel@gaston>
	<200503231153.48230.david-b@pacbell.net>
	<20050323210835.GF30704@elf.ucw.cz>
	<200503231333.22647.david-b@pacbell.net>
	<20050323215330.GJ30704@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============96745158141822407=="
In-Reply-To: <20050323215330.GJ30704-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============96745158141822407==
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Wed, 23 Mar 2005, Pavel Machek wrote:

A couple of questions:



> --- clean/drivers/base/power/shutdown.c	2004-08-15 19:14:55.000000000 +0200
> +++ linux/drivers/base/power/shutdown.c	2005-03-22 12:20:53.000000000 +0100
> @@ -29,7 +29,8 @@
>  			dev->driver->shutdown(dev);
>  		return 0;
>  	}
> -	return dpm_runtime_suspend(dev, dev->detach_state);
> +	/* FIXME */
> +	return dpm_runtime_suspend(dev, PMSG_FREEZE);

Why is this a FIXME? Mind adding a bit more descriptive of a comment
there?

> --- clean/drivers/base/power/sysfs.c	2004-08-15 19:14:55.000000000 +0200
> +++ linux/drivers/base/power/sysfs.c	2005-03-22 12:20:53.000000000 +0100
> @@ -26,19 +26,20 @@
>
>  static ssize_t state_show(struct device * dev, char * buf)
>  {
> -	return sprintf(buf, "%u\n", dev->power.power_state);
> +	return sprintf(buf, "%u\n", dev->power.power_state.event);
>  }
>
>  static ssize_t state_store(struct device * dev, const char * buf, size_t n)
>  {
> -	u32 state;
> +	pm_message_t state;
>  	char * rest;
>  	int error = 0;
>
> -	state = simple_strtoul(buf, &rest, 10);
> +	state.event = simple_strtoul(buf, &rest, 10);
> +//	state.flags = PFL_RUNTIME;

What is PFL_RUNTIME?

This appears to be the only usage of the .flags field. Perhaps we should
omit that field (and this commented out line) for now?

Thanks,


	Pat


--===============96745158141822407==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============96745158141822407==--
