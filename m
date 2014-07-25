From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH] irq: Rework IRQF_NO_SUSPENDED
Date: Fri, 25 Jul 2014 15:55:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1407251552160.23352@nanos>
References: <20140724212620.GO3935@laptop> <13290270.IfKaUSRMLR@vostro.rjw.lan> <alpine.DEB.2.10.1407251109390.23352@nanos> <2634160.AMXQm5EuML@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57181 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932866AbaGYNzI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jul 2014 09:55:08 -0400
In-Reply-To: <2634160.AMXQm5EuML@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>

On Fri, 25 Jul 2014, Rafael J. Wysocki wrote:
> If the face of your remark about the level-triggered interrupts that's all moot.

It's not only level. That you notice right away.

But for edge you lose the edge and some devices will wait forever that
their irq is handled. Not fun to debug :)

Thanks,

	tglx
