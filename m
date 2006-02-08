From: Greg KH <greg@kroah.com>
Subject: Re: [linux-pm] Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Wed, 8 Feb 2006 08:58:03 -0800
Message-ID: <20060208165803.GA15239@kroah.com>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060208130422.GB25659@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 08, 2006 at 01:04:22PM +0000, Matthew Garrett wrote:
> +/**
> + *	pm_set_ac_status - Set the ac status callback
> + *	@ops:	Pointer to function
> + */
> +
> +void pm_set_ac_status(int (*ac_status_function)(void))

No extra line in there please.
And perhaps a bit more description of what this is used for?

> +{
> +	down(&pm_sem);

Shouldn't this be a mutex?

> +	get_ac_status = ac_status_function;
> +	up(&pm_sem);
> +}
> +
> +EXPORT_SYMBOL(pm_set_ac_status);

No extra line between the function and the EXPORT_SYMBOL please.

Also, how about EXPORT_SYMBOL_GPL()?

And, who will be using this interface, and what for?



> +
> +/**
> + *	pm_get_ac_status - return true if the system is on AC
> + */
> +
> +int pm_get_ac_status(void)
> +{
> +	int status;
> +
> +	down (&pm_sem);
> +	if (get_ac_status)
> +		status = get_ac_status();
> +	else
> +		status = 0;
> +	up (&pm_sem);

You can save 2 lines by setting status = 0 on the first line of this
function :)

thanks,

greg k-h
