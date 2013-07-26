From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle
 driver
Date: Fri, 26 Jul 2013 11:00:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1307261058510.15022@syhkavp.arg>
References: <1374750866-750-1-git-send-email-lorenzo.pieralisi@arm.com> <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:33640 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759139Ab3GZPAv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2013 11:00:51 -0400
Received: by mail-qe0-f46.google.com with SMTP id i11so377989qej.5
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2013 08:00:51 -0700 (PDT)
In-Reply-To: <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jon Medhurst <tixy@linaro.org>

On Thu, 25 Jul 2013, Lorenzo Pieralisi wrote:

> +static int notrace bl_powerdown_finisher(unsigned long arg)
> +{
> +	/* MCPM works with HW CPU identifiers */
> +	unsigned int mpidr = read_cpuid_mpidr();
> +	unsigned int cluster = (mpidr >> 8) & 0xf;
> +	unsigned int cpu = mpidr & 0xf;

You probably want to use the MPIDR_AFFINITY_LEVEL() macro here.


Nicolas
