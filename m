From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] ARM64: powernv: remove redundant
 cpuidle_idle_call()
Date: Thu, 6 Feb 2014 15:20:46 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402061520340.21991@ionos.tec.linutronix.de>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org> <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, 6 Feb 2014, Nicolas Pitre wrote:

> The core idle loop now takes care of it.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
