From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: [RFC] CPUFreq PowerOP integration,
 Centrino PM Core and OPs registration 2/3
Date: Mon, 09 Oct 2006 17:42:26 +0400
Message-ID: <452A51C2.2010106@gmail.com>
References: <45096C1A.7010008@gmail.com>
	<20061007031910.GA1494@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061007031910.GA1494@dominikbrodowski.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, "Eugeny S. Mints" <eugeny.mints@gmail.com>, pm list <linux-pm@lists.osdl.org>, Matthew Locke <matt@nomadgs.com>, Amit Kucheria <amit.kucheria@nokia.com>, Igor Stoppa <igor.stoppa@nokia.com>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Dominik Brodowski wrote:
> Hi,
> =

> On Thu, Sep 14, 2006 at 06:50:02PM +0400, Eugeny S. Mints wrote:
> =

>> +static int =

>> +process_pwr_param(struct pm_core_point *opt, int op, char *param_name,
>> +		  int va_arg)
>> +{
>> +	int cpu =3D 0;
>> +	char buf[8];
>> +
>> +	for (cpu =3D 0; cpu < NR_CPUS; cpu++)
>> +	{
>> +		sprintf(buf, "v%d", cpu);
>> +
>> +		if (strcmp(param_name, buf) =3D=3D 0) {
>> +			if (op =3D=3D PWR_PARAM_SET)
>> +				opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_V] =3D =

>> +									va_arg;
>> +			else if (opt !=3D NULL)
>> +				*(int *)va_arg =3D =

>> +				     opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_V];
>> +			else if ((*(int *)va_arg =3D get_vtg(cpu)) <=3D 0)
>> +				return -EINVAL;
>> +			return 0;
>> +		}
>> +
>> +		sprintf(buf, "freq%d", cpu);
>> +
>> +		if (strcmp(param_name, buf) =3D=3D 0) {
>> +			if (op =3D=3D PWR_PARAM_SET)
>> +				opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_FREQ] =3D =

>> +									va_arg;
>> +			else if (opt !=3D NULL)
>> +				*(int *)va_arg =3D =

>> +				  opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_FREQ];
>> +			else if ((*(int *)va_arg =3D get_freq(cpu)) <=3D 0)
>> +				return -EINVAL;
>> +
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
> =

> Ouch. IIRC Pavel had some fine comments about such string parsing deep in
> arch code... Other than that I see lots of indirection, lots of code being
> added (~400 lines) for no gain in functionality for the x86 case.
THis code is no longer anyhow relevant to the latest take of PowerOP. Pleas=
e =

check to make sure that you are looking at the very latest PowerOP code =

submitted for discussion. Latest PowerOP take gets rid of all parsing. Late=
st =

patches do not contain x86 patch yet but omap PM core reference code is =

supplied.  So please use  omap code for the discussion. FYI, forward portin=
g of =

x86 patches to the latest POwerOP is on the way.

Thanks,
	Eugeny
> =

> Thanks,
> 	Dominik
> =
