From: Heikki Orsila <shd@zakalwe.fi>
Subject: Re: [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Date: Sun, 1 Oct 2006 18:22:28 +0300
Message-ID: <20061001152228.GA24539@zakalwe.fi>
References: <20060930022435.b2344b5f.eugeny.mints@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750992AbWJAPXY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060930022435.b2344b5f.eugeny.mints@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org, matt@nomadgs.com, amit.kucheria@nokia.com, igor.stoppa@nokia.com, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org

Some nitpicking about the patch follows..

On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
> +static long 
> +get_vtg(const char *vdomain)
> +{
> +	long ret = 0;

Unnecessary initialisation.

> +static long 
> +set_vtg(const char *vdomain, int val)
> +{
> +	long ret = 0;

here too. This and 'int i = 0;' happens in many functions.

> +	err = omap_pm_core_verify_opt(opt);
> +	if (err != 0)
> +		goto out;
> +
> +	return (void *)opt;
> +out:
> +	kfree(opt);
> +	return NULL;
> +}

Maybe use if (err != 0) { kfree(opt); return NULL; } because goto out is 
only used once?

> +static int cpu_vltg_show(void *md_opt, int *value)
> +{
> +	int rc = 0;
> +	if (md_opt == NULL) {
> +		if ((*value = get_vtg("v1")) <= 0)
> +			return -EIO;
> +	}
> +	else {
> +		struct pm_core_point *opt = (struct pm_core_point *)md_opt;
> +		*value = opt->cpu_vltg;
> +	}
> +
> +	return rc;
> +}

int rc is unnecessary because the function always returns 0. This 
happens in many places.

> +	int dpll;     /* in KHz */
> +	int cpu;      /* CPU frequency in KHz */
> +	int tc;       /* in KHz */
> +	int per;      /* in KHz */
> +	int dsp;      /* in KHz */
> +	int dspmmu;   /* in KHz */
> +	int lcd;      /* in KHz */
> +};

The SI multiplier is 'k', not 'K'.

- Heikki
