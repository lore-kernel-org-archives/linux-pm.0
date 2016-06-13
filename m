From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
Date: Tue, 14 Jun 2016 07:48:12 +1000
Message-ID: <1465854492.3022.30.camel@au1.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
	 <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
Reply-To: benh@au1.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62518 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1424395AbcFMVsc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2016 17:48:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5DLhntI107823
	for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2016 17:48:31 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0b-001b2d01.pphosted.com with ESMTP id 23getm5cqc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2016 17:48:31 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <benh@au1.ibm.com>;
	Tue, 14 Jun 2016 07:48:27 +1000
In-Reply-To: <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, maddy@linux.vnet.ibm.com, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linuxppc-dev@lists.ozlabs.org

On Wed, 2016-06-08 at 11:54 -0500, Shreyas B. Prabhu wrote:
>=20
> =C2=A0/*
> =C2=A0 * States for dedicated partition case.
> =C2=A0 */
> @@ -167,6 +183,8 @@ static int powernv_add_idle_states(void)
> =C2=A0	int nr_idle_states =3D 1; /* Snooze */
> =C2=A0	int dt_idle_states;
> =C2=A0	u32 *latency_ns, *residency_ns, *flags;
> +	u64 *psscr_val =3D NULL;
> +	const char *names[CPUIDLE_STATE_MAX];
> =C2=A0	int i, rc;
> =C2=A0
> =C2=A0	/* Currently we have snooze statically defined */
> @@ -199,12 +217,41 @@ static int powernv_add_idle_states(void)
> =C2=A0		goto out_free_latency;
> =C2=A0	}
> =C2=A0
> +	rc =3D of_property_read_string_array(power_mgt,
> +					=C2=A0=C2=A0=C2=A0"ibm,cpu-idle-state-names", names,
> +					=C2=A0=C2=A0=C2=A0dt_idle_states);

Ok so from this I assume that dt_idle_states is the number of entries,
which has been checked properly to be <=C2=A0CPUIDLE_STATE_MAX correct =
?

Beause ...

> +	if (rc < 0) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n=
");
> +		goto out_free_latency;
> +	}
> +
> +	/*
> +	=C2=A0* If the idle states use stop instruction, probe for psscr va=
lues
> +	=C2=A0* which are necessary to specify required stop level.
> +	=C2=A0*/
> +	if (flags[0] & (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP)) {
> +		psscr_val =3D kcalloc(dt_idle_states, sizeof(*psscr_val),
> +				=C2=A0=C2=A0=C2=A0=C2=A0GFP_KERNEL);
> +		rc =3D of_property_read_u64_array(power_mgt,
> +						"ibm,cpu-idle-state-psscr",
> +						psscr_val, dt_idle_states);

Here, psscr val is only one u64 ... shouldn't you kmalloc sizeof(..) *
dt_idle_states ?

> +		if (rc) {
> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT=
\n");
> +			goto out_free_psscr;
> +		}
> +	}
> =C2=A0	residency_ns =3D kzalloc(sizeof(*residency_ns) * dt_idle_state=
s, GFP_KERNEL);

Just like we do here

> =C2=A0	rc =3D of_property_read_u32_array(power_mgt,=C2=A0		"ibm,cpu-i=
dle-state-residency-ns", residency_ns, dt_idle_states);
> =C2=A0	for (i =3D 0; i < dt_idle_states; i++) {
> -
> +		/*
> +		=C2=A0* If an idle state has exit latency beyond
> +		=C2=A0* POWERNV_THRESHOLD_LATENCY_NS then don't use it
> +		=C2=A0* in cpu-idle.
> +		=C2=A0*/
> +		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
> +			continue;
> =C2=A0		/*
> =C2=A0		=C2=A0* Cpuidle accepts exit_latency and target_residency in =
us.
> =C2=A0		=C2=A0* Use default target_residency values if f/w does not e=
xpose it.
> @@ -216,6 +263,16 @@ static int powernv_add_idle_states(void)
> =C2=A0			powernv_states[nr_idle_states].flags =3D 0;
> =C2=A0			powernv_states[nr_idle_states].target_residency =3D 100;
> =C2=A0			powernv_states[nr_idle_states].enter =3D &nap_loop;
> +		} else if ((flags[i] & OPAL_PM_STOP_INST_FAST) &&
> +				!(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
> +			strncpy(powernv_states[nr_idle_states].name,
> +				names[i], CPUIDLE_NAME_LEN);
> +			strncpy(powernv_states[nr_idle_states].desc,
> +				names[i], CPUIDLE_NAME_LEN);
> +			powernv_states[nr_idle_states].flags =3D 0;
> +
> +			powernv_states[nr_idle_states].enter =3D stop_loop;
> +			stop_psscr_table[nr_idle_states] =3D psscr_val[i];
> =C2=A0		}
> =C2=A0
> =C2=A0		/*
> @@ -231,6 +288,16 @@ static int powernv_add_idle_states(void)
> =C2=A0			powernv_states[nr_idle_states].flags =3D CPUIDLE_FLAG_TIMER_=
STOP;
> =C2=A0			powernv_states[nr_idle_states].target_residency =3D 300000;
> =C2=A0			powernv_states[nr_idle_states].enter =3D &fastsleep_loop;
> +		} else if ((flags[i] & OPAL_PM_STOP_INST_DEEP) &&
> +				(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
> +			strncpy(powernv_states[nr_idle_states].name,
> +				names[i], CPUIDLE_NAME_LEN);
> +			strncpy(powernv_states[nr_idle_states].desc,
> +				names[i], CPUIDLE_NAME_LEN);
> +
> +			powernv_states[nr_idle_states].flags =3D CPUIDLE_FLAG_TIMER_STOP;
> +			powernv_states[nr_idle_states].enter =3D stop_loop;
> +			stop_psscr_table[nr_idle_states] =3D psscr_val[i];
> =C2=A0		}
> =C2=A0#endif
> =C2=A0		powernv_states[nr_idle_states].exit_latency =3D
> @@ -245,6 +312,8 @@ static int powernv_add_idle_states(void)
> =C2=A0	}
> =C2=A0
> =C2=A0	kfree(residency_ns);
> +out_free_psscr:
> +	kfree(psscr_val);
> =C2=A0out_free_latency:
> =C2=A0	kfree(latency_ns);
> =C2=A0out_free_flags:

