From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Thu, 21 Jan 2016 11:27:42 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601211126440.3873@nanos>
References: <alpine.DEB.2.11.1601201634520.3575@nanos> <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org> <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org> <alpine.DEB.2.11.1601201847050.3575@nanos> <56A0A424.80306@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36912 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935173AbcAUK2r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 05:28:47 -0500
In-Reply-To: <56A0A424.80306@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Thu, 21 Jan 2016, Daniel Lezcano wrote:
> Just to be sure, do you suggest to put the function declaration in
> kernel/irq/internal.h and the function definition in kernel/sched/idle-sched.c
> ?

Well obviously the declarations and stub functions should be in a header which
is accessible for both.
