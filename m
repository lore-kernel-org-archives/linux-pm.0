From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] PowerOP, PowerOP Sysfs 2/3
Date: Thu, 24 Aug 2006 22:58:18 -0700
Message-ID: <20060825055818.GB24226@kroah.com>
References: <44ECFCE2.4040806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44ECFCE2.4040806@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 24, 2006 at 05:12:02AM +0400, Eugeny S. Mints wrote:
> Reference SysFS code for PowerOP

> diff --git a/drivers/powerop/Kconfig b/drivers/powerop/Kconfig
> index 94d2459..fe5c946 100644
> --- a/drivers/powerop/Kconfig
> +++ b/drivers/powerop/Kconfig
> @@ -8,5 +8,10 @@ config POWEROP
>  	bool "PowerOP Core"
>  	help
>  =

> +config POWEROP_SYSFS
> +	bool "  Enable PowerOP sysfs interface"
> +	depends on POWEROP && SYSFS
> +	help

Why would you not want this?  Why not always force it enabled?

> +static ssize_t active_store(struct subsystem * subsys, const char * buf,
> +			    size_t n)
> +{
> +	int error;
> +	=

> +	error =3D powerop_set_point(buf);
> +	if (error !=3D 0)
> +		return error;
> +
> +	strcpy(active_name, buf);
> +	return n;
> +}

This seems to be an abuse of the "one value per file" rule of sysfs,
right?

> +	if ((error =3D subsystem_register(&powerop_subsys))) {

So now there is both a /sys/power and /sys/powerop?  That will be
confusing for everyone, why not just use the /sys/power place?

thanks,

greg k-h
