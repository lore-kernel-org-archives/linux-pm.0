From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch/rft 2.6.17-rc5-git 4/6] PM_EVENT_PRETHAW for
	various graphics cards
Date: Tue, 30 May 2006 19:30:16 +0000
Message-ID: <20060530193016.GC4044@ucw.cz>
References: <200604241429.52022.david-b@pacbell.net>
	<20060527163837.GE4242@ucw.cz>
	<200606050938.34988.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606050938.34988.david-b@pacbell.net>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

>  #ifdef CONFIG_PM
> -static int nvidiafb_suspend(struct pci_dev *dev, pm_message_t state)
> +static int nvidiafb_suspend(struct pci_dev *dev, pm_message_t mesg)
>  {
>  	struct fb_info *info =3D pci_get_drvdata(dev);
>  	struct nvidia_par *par =3D info->par;
>  =

> +	if (mesg.event =3D=3D PM_EVENT_PRETHAW)
> +		mesg.event =3D PM_EVENT_FREEZE;
>  	acquire_console_sem();
> -	par->pm_state =3D state.event;
> +	par->pm_state =3D mesg.event;
>  =

> -	if (state.event =3D=3D PM_EVENT_FREEZE) {
> -		dev->dev.power.power_state =3D state;
> -	} else {
> +	if (mesg.event =3D=3D PM_EVENT_SUSPEND) {
>  		fb_set_suspend(info, 1);
>  		nvidiafb_blank(FB_BLANK_POWERDOWN, info);
>  		nvidia_write_regs(par, &par->SavedReg);
>  		pci_save_state(dev);
>  		pci_disable_device(dev);
> -		pci_set_power_state(dev, pci_choose_state(dev, state));
> +		pci_set_power_state(dev, pci_choose_state(dev, mesg));
>  	}
> +	dev->dev.power.power_state =3D mesg;

If PRETHAW event is sent, we still store FREEZE into power_state. That
is not consistent with other drivers.

> Index: g26/drivers/video/savage/savagefb_driver.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- g26.orig/drivers/video/savage/savagefb_driver.c	2006-06-02 18:08:30.0=
00000000 -0700
> +++ g26/drivers/video/savage/savagefb_driver.c	2006-06-02 18:11:27.000000=
000 -0700
> @@ -2151,24 +2151,24 @@ static void __devexit savagefb_remove (s
>  	}
>  }
>  =

> -static int savagefb_suspend (struct pci_dev* dev, pm_message_t state)
> +static int savagefb_suspend (struct pci_dev* dev, pm_message_t mesg)
>  {
>  	struct fb_info *info =3D pci_get_drvdata(dev);
>  	struct savagefb_par *par =3D info->par;
>  =

>  	DBG("savagefb_suspend");
>  =

> -
> -	par->pm_state =3D state.event;
> +	if (mesg.event =3D=3D PM_EVENT_PRETHAW)
> +		mesg.event =3D PM_EVENT_FREEZE;
> +	par->pm_state =3D mesg.event;
> +	dev->dev.power.power_state =3D mesg;

Same here.
						Pavel

-- =

Thanks for all the (sleeping) penguins.
