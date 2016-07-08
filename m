From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v7 09/11] cpuidle/powernv: cleanup
 powernv_add_idle_states
Date: Fri, 08 Jul 2016 12:42:35 +1000
Message-ID: <1467945755.27479.160.camel@neuling.org>
References: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
	 <1467924432-29003-10-git-send-email-shreyas@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:39290 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbcGHCmi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2016 22:42:38 -0400
In-Reply-To: <1467924432-29003-10-git-send-email-shreyas@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org

> =C2=A0		/*
> @@ -230,7 +238,7 @@ static int powernv_add_idle_states(void)
> =C2=A0			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");
> =C2=A0			powernv_states[nr_idle_states].flags =3D CPUIDLE_FLAG_TIMER_=
STOP;
> =C2=A0			powernv_states[nr_idle_states].target_residency =3D 300000;
> -			powernv_states[nr_idle_states].enter =3D &fastsleep_loop;
> +			powernv_states[nr_idle_states].enter =3D fastsleep_loop;

You can change this code too with the same thing.

static struct cpuidle_state powernv_states[CPUIDLE_STATE_MAX] =3D {
	{ /* Snooze */
		.name =3D "snooze",
		.desc =3D "snooze",
		.exit_latency =3D 0,
		.target_residency =3D 0,
		.enter =3D &snooze_loop },
};

Mikey
