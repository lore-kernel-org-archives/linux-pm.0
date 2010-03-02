From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Wakeup for PNP
Date: Tue, 2 Mar 2010 13:31:05 -0800
Message-ID: <20100302213105.GB13499__29317.9064327434$1267565533$gmane$org@core.coreip.homeip.net>
References: <20100223214920.GA14313@core.coreip.homeip.net>
	<Pine.LNX.4.44L0.1003021505130.1910-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1003021505130.1910-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 02, 2010 at 03:13:30PM -0500, Alan Stern wrote:
> On Tue, 23 Feb 2010, Dmitry Torokhov wrote:
> 
> > Yes, I agree, we need a genric mechanism for PNP to emable wakups. It
> > was discussed a bit here:
> > 
> > 	http://bugzilla.kernel.org/show_bug.cgi?id=8286
> > 
> > but David was too hung up on the fact that number of devices in ACPI
> > does not map directly onto number of serio ports when i8042 is in active
> > multiplexing mode that it id not go anywhere.
> 
> Does this look reasonable?  I don't know anything about PNPBIOS or 
> ISAPNP, so it handles only PNPACPI.  But at least it's a starting 
> point -- and it does enable my system to wake up in response to 
> hitting a key.
> 
> (This combines changes to the PNP core with changes to the i8042 
> drivers.  For submission they can be broken out into separate patches.)
> 
> Alan Stern
> 
> 
> Index: usb-2.6/drivers/input/serio/i8042-x86ia64io.h
> ===================================================================
> --- usb-2.6.orig/drivers/input/serio/i8042-x86ia64io.h
> +++ usb-2.6/drivers/input/serio/i8042-x86ia64io.h
> @@ -625,6 +625,7 @@ static int i8042_pnp_kbd_probe(struct pn
>  	}
>  
>  	i8042_pnp_kbd_devices++;
> +	device_set_wakeup_enable(&dev->dev, true);
>  	return 0;
>  }
>  
> @@ -646,6 +647,7 @@ static int i8042_pnp_aux_probe(struct pn
>  	}
>  
>  	i8042_pnp_aux_devices++;
> +	device_set_wakeup_enable(&dev->dev, true);
>  	return 0;
>  }
>  
> @@ -656,7 +658,7 @@ static struct pnp_device_id pnp_kbd_devi
>  };
>  
>  static struct pnp_driver i8042_pnp_kbd_driver = {
> -	.name           = "i8042 kbd",
> +	.name           = "i8042-kbd",

Why is this needed? I don't think spaces are more dangerous than a colon
which we do use...

Other than that - looks reasonable to me...

-- 
Dmitry
