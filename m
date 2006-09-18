From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Mon, 18 Sep 2006 12:44:37 +0200
Message-ID: <20060918104437.GA4973@elf.ucw.cz>
References: <45096933.4070405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751647AbWIRKog@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45096933.4070405@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> The PowerOP Core provides completely arch independent interface
> to create and control operating points which consist of arbitrary
> subset of power parameters available on a certain platform.
> Also, PowerOP Core provides optional SysFS interface to access
> operating point from userspace.

Please inline patches and sign them off.

Also if you are providing new userland interface, describe it... in
Documentation/ABI.

> +struct powerop_driver {
> +	char *name;
> +	void *(*create_point) (const char *pwr_params, va_list args);
> +	int (*set_point) (void *md_opt);
> +	int (*get_point) (void *md_opt, const char *pwr_params, va_list args);
> +};

We can certainly get better interface than va_list, right?

> +
> +#
> +# powerop
> +#
> +
> +menu "PowerOP (Power Management)"
> +
> +config POWEROP
> +	tristate "PowerOP Core"
> +	help

Hohum, this is certainly going to be clear to confused user...

> +	list_add_tail(&opt->node, &named_opt_list);
> +	strcpy(registered_names[registered_opt_number], id);
> +	registered_opt_number++;
> +	up(&named_opt_list_mutex);
> +
> +	blocking_notifier_call_chain(&powerop_notifier_list,
> +				     POWEROP_REGISTER_EVENT, id);
> +	return 0;
> +
> +      fail_set_name:
> +	kfree(opt->md_opt);
> +
> +      fail_opt_create:
> +	kfree(registered_names[registered_opt_number]);
> +
> +      fail_name_nomem:
> +	kfree(opt);
> +	return err;
> +}

Careful about spaces vs. tabs...

...so, you got support for 20 operating points... And this should
include devices, too, right? How is it going to work on 8cpu box? will
you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
