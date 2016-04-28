From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Thu, 28 Apr 2016 08:15:22 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1604280813570.3941@nanos>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com> <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com> <alpine.DEB.2.11.1604221834430.3941@nanos>
 <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com> <alpine.DEB.2.11.1604251018090.3941@nanos> <CAJFUiJjSvzv65sHApE5Gcp9oWA-j5j7JLb6b0=1eETrA4uQLkQ@mail.gmail.com> <alpine.DEB.2.11.1604271216400.3941@nanos>
 <CAJFUiJir_zvQDXub=1zwPKJoZm_AnWNpGXuSUiCeHAEwEEUCMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55908 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbcD1GRF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2016 02:17:05 -0400
In-Reply-To: <CAJFUiJir_zvQDXub=1zwPKJoZm_AnWNpGXuSUiCeHAEwEEUCMQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 27 Apr 2016, Lianwei Wang wrote:
> Yes. In our project, there is a kernel driver which register a pm
> notifier. On some conditions this pm notifier will return an error and
> abort the suspend process. The counter will be unbalanced in case it
> happened.

So what? You wreckaged your driver, so you fix it and be done with it.
