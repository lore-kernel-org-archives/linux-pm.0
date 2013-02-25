From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2][RFC] time : set broadcast irq affinity
Date: Mon, 25 Feb 2013 23:50:23 +0100
Message-ID: <512BEAAF.1070500@linaro.org>
References: <5123C299.3080005@linaro.org> <1361484083-5906-1-git-send-email-daniel.lezcano@linaro.org> <1361484083-5906-2-git-send-email-daniel.lezcano@linaro.org> <20130222095530.377fd218@chromoly>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33701 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932380Ab3BYWuY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Feb 2013 17:50:24 -0500
Received: by mail-wg0-f48.google.com with SMTP id 16so2909891wgi.27
        for <linux-pm@vger.kernel.org>; Mon, 25 Feb 2013 14:50:23 -0800 (PST)
In-Reply-To: <20130222095530.377fd218@chromoly>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, fweisbec@gmail.com, john.stultz@linaro.org, linaro-kernel@lists.linaro.org

On 02/22/2013 06:55 PM, Jacob Pan wrote:
> On Thu, 21 Feb 2013 23:01:23 +0100
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>=20
>> +/*
>> + * Set broadcast interrupt affinity
>> + */
>> +static void tick_broadcast_set_affinity(struct clock_event_device
>> *bc, int cpu) +{
>> +	struct cpumask cpumask;
>> +
>> +	if (!(bc->features & CLOCK_EVT_FEAT_DYNIRQ))
>> +		return;
>> +
>> +	cpumask_clear(&cpumask);
>> +	cpumask_set_cpu(cpu, &cpumask);
>> +	irq_set_affinity(bc->irq, &cpumask);
> would it be more efficient to keep track of the current bc->irq affin=
ity
> via cpumask then set it only if it is different?

Do you mean a cpumask static variable ? and something like:

if (!cpumask_test_cpu(cpu, &affinitymask)) {
	cpumask_set_cpu(cpu, &affinitymask);
	irq_set_affinity(bc->irq, &affinitymask)
}




--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

