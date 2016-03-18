From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH v8 3/6] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
Date: Sat, 19 Mar 2016 09:37:15 +1100
Message-ID: <1458340635.3107.89.camel@au1.ibm.com>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
	 <1454442102-1229-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
	 <1458273857.6622.75.camel@neuling.org>
Reply-To: benh@au1.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:57466 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbcCRWiV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 18:38:21 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <benh@au1.ibm.com>;
	Sat, 19 Mar 2016 08:38:19 +1000
In-Reply-To: <1458273857.6622.75.camel@neuling.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Neuling <mikey@neuling.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, shreyas@linux.vnet.ibm.com, rjw@rjwysocki.net, pc@us.ibm.com, viresh.kumar@linaro.org, anton@samba.org

On Fri, 2016-03-18 at 15:04 +1100, Michael Neuling wrote:
>=20
> =C2=A0static int nr_chips;
> +static DEFINE_PER_CPU(unsigned int, chip_id);
> =C2=A0
> =C2=A0/*
> =C2=A0 * Note: The set of pstates consists of contiguous integers, th=
e
> @@ -317,9 +318,7 @@ static void powernv_cpufreq_throttle_check(void
> *data)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmsr =3D get_pmspr(SP=
RN_PMSR);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < nr_chips=
; i++)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (chips[i].id =3D=3D cpu_to_chip_id(cpu))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0br=
eak;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i =3D this_cpu_read(chip_i=
d);

Except it's not a chip_id, so your patch confused me for a good 2mn ...
Call it chip_idx maybe ? ie, index.

Cheers,
Ben.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Check for Pmax Cap=
ping */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmsr_pmax =3D (s8)PMS=
R_MAX(pmsr);
> @@ -560,6 +559,7 @@ static int init_chip_info(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for_each_possible_cpu=
(cpu) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int id =3D cpu_to_chip_id(cpu);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0per_cpu(chip_id, cpu) =3D nr_chips;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (prev_chip_id !=3D id) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0prev_chip_id =3D id;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0chip[nr_chips++] =3D id;
> _______________________________________________

