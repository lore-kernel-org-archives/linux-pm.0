From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] PPC: powernv: remove redundant cpuidle_idle_call()
Date: Thu, 6 Feb 2014 15:20:30 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402061520040.21991@ionos.tec.linutronix.de>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35080 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbaBFOVA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2014 09:21:00 -0500
In-Reply-To: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org

An Thu, 6 Feb 2014, Nicolas Pitre wrote:

> The core idle loop now takes care of it.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
