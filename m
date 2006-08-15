From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] PowerOP, OMAP1 PM Core 2/3
Date: Tue, 15 Aug 2006 20:42:53 +0000
Message-ID: <20060815204253.GA5950@ucw.cz>
References: <44D7EA82.9090306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44D7EA82.9090306@gmail.com>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

Not only it does string parsing in generc code, it pushes it to
architectures, too. Ouch.


> +static char *pwr_param_names_list =3D "cpu_vltg dpll cpu tc per dsp dspm=
mu lcd ";
...

> +#define PWR_PARAM_SET	1
> +#define PWR_PARAM_GET	2
> +/* FIXME: very temporary implementation, just to prove the concept !! */
> +static int =

> +process_pwr_param(struct pm_core_point *opt, int op, char *param_name,
> +		  int va_arg)
> +{
> +	if (strcmp(param_name, "cpu_vltg") =3D=3D 0) {
> +		if (op =3D=3D PWR_PARAM_SET)
> +			opt->cpu_vltg =3D va_arg;
> +		else if (opt !=3D NULL)
> +			*(int *)va_arg =3D opt->cpu_vltg;
> +		else if (unlikely((*(int *)va_arg =3D get_vtg("v1")) <=3D 0))
> +			return -EINVAL;
> +
> +		return 0;
> +	}
> +
> +	if (strcmp(param_name, "dpll") =3D=3D 0) {
> +		if (op =3D=3D PWR_PARAM_SET)
> +			opt->dpll =3D va_arg;
> +		else if (opt !=3D NULL)
> +			*(int *)va_arg =3D opt->dpll;
> +		else if ((*(int *)va_arg =3D get_clk_rate("ck_dpll1")) <=3D 0)
> +			return -EINVAL;
> +
> +		return 0;
> +	}
> +
> +	if (strcmp(param_name, "cpu") =3D=3D 0) {
> +		if (op =3D=3D PWR_PARAM_SET)
> +			opt->cpu =3D va_arg;
> +		else if (opt !=3D NULL)
> +			*(int *)va_arg =3D opt->cpu;
> +		else if ((*(int *)va_arg =3D get_clk_rate("arm_ck")) <=3D 0)
> +			return -EINVAL;
> +
> +		return 0;
> +	}
> +
> +	/* FIXME: more parameters to process */
> +
> +	return -EINVAL;
> +}

It certainly tells me I do not like the concept :-(.

-- =

Thanks for all the (sleeping) penguins.
