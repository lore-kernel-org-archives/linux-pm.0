From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] PM / sleep: Make suspend-to-idle-specific code depend
 on CONFIG_SUSPEND
Date: Mon, 18 May 2015 16:49:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505181649270.4225@nanos>
References: <7138791.PFSSF2gqXk@vostro.rjw.lan> <2270439.0UMhzsTGM1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49526 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbbEROte (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 10:49:34 -0400
In-Reply-To: <2270439.0UMhzsTGM1@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>

On Sat, 16 May 2015, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since idle_should_freeze() is defined to always return 'false'
> for CONFIG_SUSPEND unset, all of the code depending on it in
> cpuidle_idle_call() is not necessary in that case.
> 
> Make that code depend on CONFIG_SUSPEND too to avoid building it
> when it is not going to be used.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

ACK for the tick part.

