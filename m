From: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch, rft] amd74xx: implement suspend-to-ram
Date: Wed, 26 Jul 2006 01:09:55 +0200
Message-ID: <20060725230955.GB7220@elf.ucw.cz>
References: <20060715210518.GA3263@opus.vpn-dev.reflex> <19700101003716.GA3558@ucw.cz> <20060718133920.GA4106@suse.cz> <20060724005340.GA4073@opus.vpn-dev.reflex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060724005340.GA4073@opus.vpn-dev.reflex>
Sender: linux-ide-owner@vger.kernel.org
To: Jason Lunz <lunz@falooley.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-ide@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

I do not have the affected hardware, sorry.

> Index: linux-2.6.18-rc2-git1/drivers/ide/pci/amd74xx.c
> ===================================================================
> --- linux-2.6.18-rc2-git1.orig/drivers/ide/pci/amd74xx.c
> +++ linux-2.6.18-rc2-git1/drivers/ide/pci/amd74xx.c
> @@ -494,6 +498,53 @@
>  	/* 19 */ DECLARE_AMD_DEV("AMD5536"),
>  };
>  
> +static int amd74xx_suspend(struct pci_dev *dev, pm_message_t state)
> +{
> +	pci_save_state(dev);
> +
> +	// PM_EVENT_SUSPEND means s2ram. otherwise, the disk behind this device
> +	// might hold the s2disk image, and we can't disable the disk
> +	// controller until we've used it to write that out.

C-style comments, please.

> +	if(state.event == PM_EVENT_SUSPEND) {

"if (". Ouch and please don't do this. Suspend-to-disk will call
amd74xx_resume when it needs to talk to the disk.

> +		pci_disable_device(dev);
> +		pci_set_power_state(dev, pci_choose_state(dev, state));
> +	}
> +	return 0;
> +}


								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
