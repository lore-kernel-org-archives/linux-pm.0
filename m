From: <ilialin@codeaurora.org>
Subject: RE: [PATCH v10 1/2] cpufreq: Add Kryo CPU scaling driver
Date: Wed, 23 May 2018 14:06:24 +0300
Message-ID: <002901d3f286$198878b0$4c996a10$@codeaurora.org>
References: <1527068454-28921-1-git-send-email-ilialin@codeaurora.org> <1527068454-28921-2-git-send-email-ilialin@codeaurora.org> <3f1ca60e-7aa8-fccc-ab1c-4b7c37731cce@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3f1ca60e-7aa8-fccc-ab1c-4b7c37731cce@arm.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Sudeep Holla' <sudeep.holla@arm.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Wednesday, May 23, 2018 13:40
> To: Ilia Lin <ilialin@codeaurora.org>; vireshk@kernel.org; nm@ti.com;
> sboyd@kernel.org; robh@kernel.org; mark.rutland@arm.com;
> rjw@rjwysocki.net; linux-pm@vger.kernel.org; =
devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Subject: Re: [PATCH v10 1/2] cpufreq: Add Kryo CPU scaling driver
>=20
>=20
>=20
> On 23/05/18 10:40, Ilia Lin wrote:
> > In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO
> > processors, the CPU frequency subset and voltage value of each OPP
> > varies based on the silicon variant in use. Qualcomm Process Voltage
> > Scaling Tables defines the voltage and frequency value based on the
> > msm-id in SMEM and speedbin blown in the efuse combination.
> > The qcom-cpufreq-kryo driver reads the msm-id and efuse value from =
the
> > SoC to provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each =
OPP
> > of
> > operating-points-v2 table when it is parsed by the OPP framework.
> >
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
>=20
> [...]
>=20
> > +	pdev =3D platform_device_register_simple("cpufreq-dt", -1, NULL, =
0);
> > +	if (!IS_ERR(pdev))
> > +		return 0;
> > +
> > +	ret =3D PTR_ERR(pdev);
> > +	dev_err(cpu_dev, "Failed to register platform device\n");
> > +
> > +free_opp:
> > +	for_each_possible_cpu(cpu) {
> > +		if (IS_ERR_OR_NULL(opp_tables[cpu]))
> > +			break;
> > +		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
> > +	}
> > +free_np:
> > +	of_node_put(np);
> > +
> > +	return ret;
> > +}
> > +late_initcall(qcom_cpufreq_kryo_driver_init);
>=20
> Any particular reason why this *has* to be late initcall ?
> Please change it to module_initcall otherwise.

The purpose is to give the cpufreq-dt the time to register the driver =
and only then my driver will add the platform device.

> Also address the of_node comments from Viresh.
>=20
> Otherwise, it looks good.
> --
> Regards,
> Sudeep
