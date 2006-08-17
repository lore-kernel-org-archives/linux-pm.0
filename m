From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: [RFC] PowerOP, OMAP1 PM Core 2/3
Date: Fri, 18 Aug 2006 02:33:14 +0400
Message-ID: <44E4EEAA.7070607@gmail.com>
References: <44D7EA82.9090306@gmail.com> <20060815204253.GA5950@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060815204253.GA5950@ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
> Not only it does string parsing in generc code, it pushes it to
> architectures, too. Ouch.
>   =

are you talking about particular implementation of the parsing or about =

interfaces? Please note that the patches were mainly introduced now for =

_interfaces_ discussion and may contain suboptimal or just reference =

implementations.
If you are talking about  having parsing implementation itself  in a =

separate arch independent library then that's is intention.

I already addressed the question why parsing is needed at this level in =

separate reply to you.
>
>   =

>> +static char *pwr_param_names_list =3D "cpu_vltg dpll cpu tc per dsp dsp=
mmu lcd ";
>>     =

> ...
>
>   =

>> +#define PWR_PARAM_SET	1
>> +#define PWR_PARAM_GET	2
>> +/* FIXME: very temporary implementation, just to prove the concept !! */
>> +static int =

>> +process_pwr_param(struct pm_core_point *opt, int op, char *param_name,
>> +		  int va_arg)
>> +{
>> +	if (strcmp(param_name, "cpu_vltg") =3D=3D 0) {
>> +		if (op =3D=3D PWR_PARAM_SET)
>> +			opt->cpu_vltg =3D va_arg;
>> +		else if (opt !=3D NULL)
>> +			*(int *)va_arg =3D opt->cpu_vltg;
>> +		else if (unlikely((*(int *)va_arg =3D get_vtg("v1")) <=3D 0))
>> +			return -EINVAL;
>> +
>> +		return 0;
>> +	}
>> +
>> +	if (strcmp(param_name, "dpll") =3D=3D 0) {
>> +		if (op =3D=3D PWR_PARAM_SET)
>> +			opt->dpll =3D va_arg;
>> +		else if (opt !=3D NULL)
>> +			*(int *)va_arg =3D opt->dpll;
>> +		else if ((*(int *)va_arg =3D get_clk_rate("ck_dpll1")) <=3D 0)
>> +			return -EINVAL;
>> +
>> +		return 0;
>> +	}
>> +
>> +	if (strcmp(param_name, "cpu") =3D=3D 0) {
>> +		if (op =3D=3D PWR_PARAM_SET)
>> +			opt->cpu =3D va_arg;
>> +		else if (opt !=3D NULL)
>> +			*(int *)va_arg =3D opt->cpu;
>> +		else if ((*(int *)va_arg =3D get_clk_rate("arm_ck")) <=3D 0)
>> +			return -EINVAL;
>> +
>> +		return 0;
>> +	}
>> +
>> +	/* FIXME: more parameters to process */
>> +
>> +	return -EINVAL;
>> +}
>>     =

>
> It certainly tells me I do not like the concept :-(.
Concept is interfaces. And the concept addresses important design =

requirements (again as I've  mentioned already in previous reply) while =

leading to some "parsing" at this level. So what is your point here?

Thanks,
Eugeny
