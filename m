From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/7] cpufreq: Fix formatting issues in 'struct
 cpufreq_driver'
Date: Wed, 26 Nov 2014 13:57:36 -0400
Message-ID: <20141126175734.GC1826@developer>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
 <3d727922615731d6e839f1ce5cb977bd3fc6ed24.1416980447.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:64908 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbaKZR5q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 12:57:46 -0500
Received: by mail-qa0-f44.google.com with SMTP id i13so2272057qae.31
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 09:57:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3d727922615731d6e839f1ce5cb977bd3fc6ed24.1416980447.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2014 at 11:22:56AM +0530, Viresh Kumar wrote:
> Adding any new callback to 'struct cpufreq_driver' gives following checkp=
atch
> warning:
>=20
> WARNING: Unnecessary space before function pointer arguments
> +	void	(*usable)	(struct cpufreq_policy *policy);
>=20
> This is because we have been using a tab spacing between function pointer=
 name
> and its arguments and the new one tried to follow that.
>=20
> Though we normally don't try to fix every checkpatch warning, specially a=
round
> formatting issues as that creates unnecessary noise over lists. But I tho=
ught we
> better fix this so that new additions don't generate these warnings plus =
it
> looks far better/symmetric now.
>=20
> So, remove these tab spacing issues in 'struct cpufreq_driver' only + fix
> alignment of all members.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Eduardo Valentin <edubezval@gmail.com>
Tested-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  include/linux/cpufreq.h | 50 ++++++++++++++++++++++++-------------------=
------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>=20
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 503b085..db3c130 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -217,26 +217,26 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
> =20
> =20
>  struct cpufreq_driver {
> -	char			name[CPUFREQ_NAME_LEN];
> -	u8			flags;
> -	void			*driver_data;
> +	char		name[CPUFREQ_NAME_LEN];
> +	u8		flags;
> +	void		*driver_data;
> =20
>  	/* needed by all drivers */
> -	int	(*init)		(struct cpufreq_policy *policy);
> -	int	(*verify)	(struct cpufreq_policy *policy);
> +	int		(*init)(struct cpufreq_policy *policy);
> +	int		(*verify)(struct cpufreq_policy *policy);
> =20
>  	/* define one out of two */
> -	int	(*setpolicy)	(struct cpufreq_policy *policy);
> +	int		(*setpolicy)(struct cpufreq_policy *policy);
> =20
>  	/*
>  	 * On failure, should always restore frequency to policy->restore_freq
>  	 * (i.e. old freq).
>  	 */
> -	int	(*target)	(struct cpufreq_policy *policy,	/* Deprecated */
> -				 unsigned int target_freq,
> -				 unsigned int relation);
> -	int	(*target_index)	(struct cpufreq_policy *policy,
> -				 unsigned int index);
> +	int		(*target)(struct cpufreq_policy *policy,
> +				  unsigned int target_freq,
> +				  unsigned int relation);	/* Deprecated */
> +	int		(*target_index)(struct cpufreq_policy *policy,
> +					unsigned int index);
>  	/*
>  	 * Only for drivers with target_index() and CPUFREQ_ASYNC_NOTIFICATION
>  	 * unset.
> @@ -252,27 +252,27 @@ struct cpufreq_driver {
>  	 * wish to switch to intermediate frequency for some target frequency.
>  	 * In that case core will directly call ->target_index().
>  	 */
> -	unsigned int (*get_intermediate)(struct cpufreq_policy *policy,
> -					 unsigned int index);
> -	int	(*target_intermediate)(struct cpufreq_policy *policy,
> -				       unsigned int index);
> +	unsigned int	(*get_intermediate)(struct cpufreq_policy *policy,
> +					    unsigned int index);
> +	int		(*target_intermediate)(struct cpufreq_policy *policy,
> +					       unsigned int index);
> =20
>  	/* should be defined, if possible */
> -	unsigned int	(*get)	(unsigned int cpu);
> +	unsigned int	(*get)(unsigned int cpu);
> =20
>  	/* optional */
> -	int	(*bios_limit)	(int cpu, unsigned int *limit);
> +	int		(*bios_limit)(int cpu, unsigned int *limit);
> =20
> -	int	(*exit)		(struct cpufreq_policy *policy);
> -	void	(*stop_cpu)	(struct cpufreq_policy *policy);
> -	int	(*suspend)	(struct cpufreq_policy *policy);
> -	int	(*resume)	(struct cpufreq_policy *policy);
> -	struct freq_attr	**attr;
> +	int		(*exit)(struct cpufreq_policy *policy);
> +	void		(*stop_cpu)(struct cpufreq_policy *policy);
> +	int		(*suspend)(struct cpufreq_policy *policy);
> +	int		(*resume)(struct cpufreq_policy *policy);
> +	struct freq_attr **attr;
> =20
>  	/* platform specific boost support code */
> -	bool                    boost_supported;
> -	bool                    boost_enabled;
> -	int     (*set_boost)    (int state);
> +	bool		boost_supported;
> +	bool		boost_enabled;
> +	int		(*set_boost)(int state);
>  };
> =20
>  /* flags */
> --=20
> 2.0.3.693.g996b0fd
>=20

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdhSFAAoJEMLUO4d9pOJW7SAH/RNufMVAxbs52NyDdSZC+CUC
/pNWZZewi38hSnLpbFtsvxV7tlC1uQVILkRP3kIWi2be4TJCpByg3bOZRl8v+Ruc
mfoyL65hVZ+kB+bcqjTFsziX4EX+IdBaRJjgy37Ntr8yH/UsWbuHvu+RmaAiqVsI
/jSwXp3eCKoVC2FeJQXEXwiR6D2c/2FSQaqlILo7Xf6aJN9pUtD+iGQ81E4rJoy2
o+mfuZh9J9pwMTUV0VQ+FX2nTQFIbTiLKpYP6GzCJMn6ObpKVzfP2Cwg+li7RWjr
7QLtyuQd9yIY+FIN9Pl51vGwf+L+cMCPmcpTGHyla1bGwQkf3r2lYRQvRB/rQgI=
=+byv
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
