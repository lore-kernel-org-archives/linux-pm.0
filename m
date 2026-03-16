Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4624E4AF;
	Mon, 16 Mar 2026 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647682; cv=none; b=UtmQsf+n0CSBGNGuAqB/0/p0oGxUXW8hAXPio0+ioQaNlUMUiBOMSovj/GyfbwrNTy8nsVzlh1erPSP9bviCaNigT/owiUUncHzf/SkTWwhfGxYMIw2M0l1e2y97VbN/hEGiOLtDjE6BrQsIvOHFG9kT2wV24wyb1SpXmUEj0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647682; c=relaxed/simple;
	bh=xeKoaLy28vZY0IB4shX0/EVzeFo7xiJ2NrBnfAOAmvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGuJIGTZzpWWpVlaRLkbvevhwyn9J3YmWxqfBZm5fJpWLdLVYr/I6/X0sDlolRMZZiEfQBJbJkrI3W83kqGKIMsbDie4b5+/Rmxx6OzncR0sMl88vnv3NtsI/Ly/k2B6NkSoanTMvlaf1DEI40ntgyT3mIahK6auGNK6gVEjxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jdNe8BBY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jdNe8BBY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FFkMKO077903;
	Mon, 16 Mar 2026 07:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0FVA3T
	Xq20rSO035ojYHOh8hGDPnn5US3uqjG+vCU1Q=; b=jdNe8BBYVi1INYl0orWYNF
	kl46NOUNdF6IMraKfQqr+EucDdIGkuva0MV1gig9tMLLV1KMcUmbEZ6TTOxqFoDb
	Ljh1g9MJNZb5GUDDewLl/RLCi+/sWdgXHuA1Q1XMlgynYXeumOqg0Q6sgEeQe+I7
	X5eVl8DqDKYB7D4X01nknIkD7zDMu/GhsW4Vg71Ngh8fp6/0IPNk2Zsl8Q0NajPE
	W4ZmOm2CLVR0SEMUBDys8DqXlj1+w46obAz9qPZQ35Eey1EWioYrBquj7vLWVQ1R
	bmcOhGqdhD0VbF2R1/+L9O1qbZFp+CYwXir6ngGxCgyKhvyrMOedMA1Bi8DswCXQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cphkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 07:54:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G4AN0W004737;
	Mon, 16 Mar 2026 07:54:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s42hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 07:54:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62G7s89N49545486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 07:54:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E920620043;
	Mon, 16 Mar 2026 07:54:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5296920040;
	Mon, 16 Mar 2026 07:54:05 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.43.40.241])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 07:54:05 +0000 (GMT)
Message-ID: <8af73ded803f36dd940411e1fa8919a741471d98.camel@linux.ibm.com>
Subject: Re: [PATCH v1] sched: idle: Consolidate the handling of two special
 cases
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef
 <qyousef@layalina.io>,
        Christian Loehle	 <christian.loehle@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Aboorva Devarajan
 <aboorvad@linux.ibm.com>
Date: Mon, 16 Mar 2026 13:24:04 +0530
In-Reply-To: <4741364.LvFx2qVVIh@rafael.j.wysocki>
References: <4741364.LvFx2qVVIh@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b7b722 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=QyXUC8HyAAAA:8
 a=VnNF1IyMAAAA:8 a=BDRg9pTkFPxzGgAR9HQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA1OCBTYWx0ZWRfXwF7nSAQupkzo
 3oiJ2ZdwcF9/PDr4eli95+dCE/YCJujodWSo1+vXyI5EshYhmnh6PTGCuJ7PHoCs/npN+yZR2PH
 TYVyWsuW9QnyIrKONvaThI8cEgGe+4yZmp+ZExtC31CW1y/3utSUl8GqVKnnWU3MpnHVre08+Xx
 bsSwXNcD4vCY5Psf51bYEy8QtnIhUjBQu/eoL3NZI3msNWIAVLoyayLWzr/7kl2QzbuqAG2LR7h
 Juf47pdgkW1z2ArEmJ5hjj5b9rJL8ml55PRmHwp0SduUZTpZgIiO1qFXAtQtvC2O4Q5OwBXdJWo
 ginSFzS9BF+QoDwOqAP2QWNAwMkUci9PXyajadZOnoQJZNp2+4Th5iMpMHjRrQjTK0kwEBwpyrZ
 BIpHVeSCcwLjZbypn4swWuXL6WNJlsVaihQCUV2IqWEr8ELNUYukyTu+xWxOkQwcuM72n2anAf3
 2G8czjbjM4PTBPFV2Kw==
X-Proofpoint-GUID: OV1SQYwGQVttq20JIlyNzM2hHJ-bC3fE
X-Proofpoint-ORIG-GUID: OV1SQYwGQVttq20JIlyNzM2hHJ-bC3fE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160058

On Fri, 2026-03-13 at 13:25 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> There are two special cases in the idle loop that are handled
> inconsistently even though they are analogous.
>=20
> The first one is when a cpuidle driver is absent and the default CPU
> idle time power management implemented by the architecture code is used.
> In that case, the scheduler tick is stopped every time before invoking
> default_idle_call().
>=20
> The second one is when a cpuidle driver is present, but there is only
> one idle state in its table.=C2=A0 In that case, the scheduler tick is ne=
ver
> stopped.
>=20
> Since each of these approaches leads to suboptimal choices in some
> cases, reconcile them with the help of one simple heuristic.=C2=A0 Namely=
,
> stop the tick if the CPU has been woken up by it in the previous
> iteration of the idle loop, or let it tick otherwise.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> Based on today's mainline.
>=20
> ---
> =C2=A0kernel/sched/idle.c |=C2=A0=C2=A0 30 +++++++++++++++++++++---------
> =C2=A01 file changed, 21 insertions(+), 9 deletions(-)
>=20
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
> =C2=A0	return cpuidle_enter(drv, dev, next_state);
> =C2=A0}
> =C2=A0
> +static void idle_call_stop_or_retain_tick(bool stop_tick)
> +{
> +	if (stop_tick || tick_nohz_tick_stopped())
> +		tick_nohz_idle_stop_tick();
> +	else
> +		tick_nohz_idle_retain_tick();
> +}
> +
> =C2=A0/**
> =C2=A0 * cpuidle_idle_call - the main idle function
> =C2=A0 *
> @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
> =C2=A0 * set, and it returns with polling set.=C2=A0 If it ever stops pol=
ling, it
> =C2=A0 * must clear the polling bit.
> =C2=A0 */
> -static void cpuidle_idle_call(void)
> +static void cpuidle_idle_call(bool stop_tick)
> =C2=A0{
> =C2=A0	struct cpuidle_device *dev =3D cpuidle_get_device();
> =C2=A0	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (cpuidle_not_available(drv, dev)) {
> -		tick_nohz_idle_stop_tick();
> +		idle_call_stop_or_retain_tick(stop_tick);
> =C2=A0
> =C2=A0		default_idle_call();
> =C2=A0		goto exit_idle;
> @@ -222,17 +230,19 @@ static void cpuidle_idle_call(void)
> =C2=A0		next_state =3D cpuidle_find_deepest_state(drv, dev, max_latency_n=
s);
> =C2=A0		call_cpuidle(drv, dev, next_state);
> =C2=A0	} else if (drv->state_count > 1) {
> -		bool stop_tick =3D true;
> +		/*
> +		 * stop_tick is expected to be true by default by cpuidle
> +		 * governors, which allows them to select idle states with
> +		 * target residency above the tick period length.
> +		 */
> +		stop_tick =3D true;
> =C2=A0
> =C2=A0		/*
> =C2=A0		 * Ask the cpuidle framework to choose a convenient idle state.
> =C2=A0		 */
> =C2=A0		next_state =3D cpuidle_select(drv, dev, &stop_tick);
> =C2=A0
> -		if (stop_tick || tick_nohz_tick_stopped())
> -			tick_nohz_idle_stop_tick();
> -		else
> -			tick_nohz_idle_retain_tick();
> +		idle_call_stop_or_retain_tick(stop_tick);
> =C2=A0
> =C2=A0		entered_state =3D call_cpuidle(drv, dev, next_state);
> =C2=A0		/*
> @@ -240,7 +250,7 @@ static void cpuidle_idle_call(void)
> =C2=A0		 */
> =C2=A0		cpuidle_reflect(dev, entered_state);
> =C2=A0	} else {
> -		tick_nohz_idle_retain_tick();
> +		idle_call_stop_or_retain_tick(stop_tick);
> =C2=A0
> =C2=A0		/*
> =C2=A0		 * If there is only a single idle state (or none), there is
> @@ -268,6 +278,7 @@ exit_idle:
> =C2=A0static void do_idle(void)
> =C2=A0{
> =C2=A0	int cpu =3D smp_processor_id();
> +	bool got_tick =3D false;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Check if we need to update blocked load
> @@ -338,8 +349,9 @@ static void do_idle(void)
> =C2=A0			tick_nohz_idle_restart_tick();
> =C2=A0			cpu_idle_poll();
> =C2=A0		} else {
> -			cpuidle_idle_call();
> +			cpuidle_idle_call(got_tick);
> =C2=A0		}
> +		got_tick =3D tick_nohz_idle_got_tick();
> =C2=A0		arch_cpu_idle_exit();
> =C2=A0	}
> =C2=A0
>=20

This unifies the special-case tick handling with a heuristic,
affecting only the no-driver and single-state paths while leaving the
common multi-state governor path behaviorally unchanged.

So,

Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Thanks,
Aboorva
