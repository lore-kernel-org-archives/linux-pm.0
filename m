From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/22] idle/intel: Convert to hotplug state machine
Date: Mon, 28 Nov 2016 18:29:41 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1611281828050.3512@nanos>
References: <20161126231350.10321-1-bigeasy@linutronix.de> <20161126231350.10321-5-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46536 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753585AbcK1RcV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 12:32:21 -0500
In-Reply-To: <20161126231350.10321-5-bigeasy@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org

On Sun, 27 Nov 2016, Sebastian Andrzej Siewior wrote:
> +static enum cpuhp_state hp_online;
> +
>  static int __init intel_idle_init(void)
>  {
...

> -	cpu_notifier_register_done();
> +	retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
> +				   intel_idle_cpu_online, NULL);
> +	if (retval < 0)
> +		goto hp_setup_fail;
> +	hp_online = retval;

Why do you want to store that. There is no exit function AFAICT.

Thanks,

	tglx
