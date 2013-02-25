From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 2/2][RFC] time : set broadcast irq affinity
Date: Mon, 25 Feb 2013 15:00:35 -0800
Message-ID: <20130225150035.7ddf6643@chromoly>
References: <5123C299.3080005@linaro.org>
	<1361484083-5906-1-git-send-email-daniel.lezcano@linaro.org>
	<1361484083-5906-2-git-send-email-daniel.lezcano@linaro.org>
	<20130222095530.377fd218@chromoly>
	<512BEAAF.1070500@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33535 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518Ab3BYXAr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Feb 2013 18:00:47 -0500
In-Reply-To: <512BEAAF.1070500@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, fweisbec@gmail.com, john.stultz@linaro.org, linaro-kernel@lists.linaro.org

On Mon, 25 Feb 2013 23:50:23 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> Do you mean a cpumask static variable ? and something like:
> 
> if (!cpumask_test_cpu(cpu, &affinitymask)) {
> 	cpumask_set_cpu(cpu, &affinitymask);
> 	irq_set_affinity(bc->irq, &affinitymask)
> }
yeah. but i think you can use the cpumask in struct clock_event_device.

-- 
Thanks,

Jacob
