From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
Date: Tue, 23 Jun 2015 08:16:47 +0100
Message-ID: <20150623071647.GD3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
 <20150623025031.GD16776@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34899 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbbFWHQv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 03:16:51 -0400
Received: by wgbhy7 with SMTP id hy7so1222002wgb.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 00:16:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150623025031.GD16776@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

Thanks for your timely review Viresh.

On Tue, 23 Jun 2015, Viresh Kumar wrote:
> On 22-06-15, 16:43, Lee Jones wrote:
> > +config ARM_ST_CPUFREQ
> > +	bool "ST CPUFreq support"
>=20
> Isn't using ST just too generic? There are multiple SoCs ST has been
> involved with, I have worked on a completely different series.
> Probably a more relative string is required here, like stih407 ?

This is ST's only CPUFreq implementation and is pretty board
agnostic.  This particular driver only currently supports the STiH407
family, but internally it supports some others too.  I'll have a chat
and see if we can make it more specific somehow.

> > +	depends on SOC_STIH407

[...]

> > +static int st_cpufreq_get_dvfs_info(struct platform_device *pdev)
> > +{
> > +	struct st_cpufreq_ddata *ddata =3D platform_get_drvdata(pdev);
> > +	struct st_dvfs_tab *dvfs_tab =3D &ddata->dvfs_tab[0];
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	struct device_node *opplist, *opp;
> > +	unsigned int minor =3D 0, major =3D 0;
> > +	int err, ret =3D 0;
> > +
> > +	opplist =3D of_get_child_by_name(np, "opp-list");
>=20
> st,opp-list ?

Sure.

[...]

> > +out:
> > +	of_node_put(opplist);
> > +
> > +	if (!ddata->dvfs_tab_count) {
> > +		dev_err(&pdev->dev, "No suitable AVS table found\n");
>=20
> Why is this an error? I thought in this case you will go ahead with
> the normal OPP-table.

I've written it so it's an error within this function, as it makes the
function fail, but is downgraded by the caller to a warning and
gracefully bypassed to still allow frequency scaling.

> > +		return -EINVAL;

[...]

> > +	for (i =3D 0; i < ddata->dvfs_tab_count; i++, dvfs_tab++) {
> > +		unsigned int f =3D dvfs_tab->freq * 1000;
> > +		unsigned int v =3D dvfs_tab->avs * 1000;
> > +
> > +		opp =3D dev_pm_opp_find_freq_exact(cpu_dev, f, false);
> > +
> > +		/* Remove existing voltage-less OPP entry */
> > +		if (!IS_ERR(opp))
> > +			dev_pm_opp_remove(cpu_dev, f);
> > +
> > +		/* Supply new fully populated OPP entry */
> > +		ret =3D dev_pm_opp_add(cpu_dev, f, v);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Failed to add OPP %u\n", f);
> > +			return ret;
> > +		}
> > +	}
>=20
> So you have added new OPPs here, but cpufreq-dt will try to add old
> OPPs. You must be getting lots of warnings ?

Yes, we recieve the 'duplicate OPPs detected' warning, but there is
nothing we can do about that.

> > +
> > +	return 0;
> > +}

[...]

> > +static const struct reg_field sti_stih407_dvfs_regfields[DVFS_MAX_=
REGFIELDS] =3D {
> > +	[PCODE]		=3D REG_FIELD(0, 16, 19),
> > +	[SUBSTRATE]	=3D REG_FIELD(0, 0, 2),
> > +};
> > +
> > +static struct of_device_id sti_cpufreq_of_match[] =3D {
> > +	{
> > +		.compatible =3D "st,stih407-cpufreq",
> > +		.data =3D &sti_stih407_dvfs_regfields,
> > +	},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, sti_cpufreq_of_match);
> > +
> > +/* Find process code -- calibrated per-SoC */
> > +static void sti_cpufreq_get_pcode(struct platform_device *pdev)
> > +{
> > +	struct st_cpufreq_ddata *ddata =3D platform_get_drvdata(pdev);
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	const struct reg_field *reg_fields;
> > +	const struct of_device_id *match;
> > +	int pcode_offset;
> > +	int ret;
> > +
> > +	ddata->regmap_eng =3D syscon_regmap_lookup_by_phandle(np, "st,sys=
cfg-eng");
> > +	if (IS_ERR(ddata->regmap_eng)) {
> > +		dev_warn(&pdev->dev, "\"st,syscfg-eng\" not supplied\n");
> > +		goto set_default;
> > +	}
> > +
> > +	ret =3D of_property_read_u32_index(np, "st,syscfg-eng",
> > +					 PCODE_INDEX, &pcode_offset);
> > +	if (ret) {
> > +		dev_warn(&pdev->dev, "Process code offset is required\n");
> > +		goto set_default;
> > +	}
> > +
> > +	match =3D of_match_node(sti_cpufreq_of_match, np);
>=20
> Are you planning to add more entries to this table? We are here as
> probe() is called only after matching for this string.

Yes, when new platforms are enabled.  The information stored in .data
will be different.

> > +	if (!match) {
> > +		dev_warn(&pdev->dev, "Failed to match device\n");
> > +		goto set_default;
> > +	}
> > +	reg_fields =3D match->data;
> > +
> > +	ddata->pcode =3D st_cpufreq_fetch_regmap_field(pdev, reg_fields,
> > +						     pcode_offset,
> > +						     PCODE);
> > +	if (ddata->pcode < 0)
> > +		goto set_default;
> > +
> > +	ddata->substrate =3D st_cpufreq_fetch_regmap_field(pdev, reg_fiel=
ds,
> > +							 pcode_offset,
> > +							 SUBSTRATE);
> > +	if (ddata->substrate < 0)
> > +		goto set_default;
>=20
> Maybe:
>=20
> 	if (ddata->substrate >=3D 0)
>                 return;

0 is a valid substrate value.

> > +
> > +	return;
> > +
> > +set_default:
> > +	dev_warn(&pdev->dev,
> > +		 "Setting pcode to highest tolerance/voltage for safety\n");
> > +	ddata->pcode =3D 0;
> > +	ddata->substrate =3D 0;
> > +}

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
