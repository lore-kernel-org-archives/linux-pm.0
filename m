From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PM / sleep: Make suspend-to-idle-specific code depend on CONFIG_SUSPEND
Date: Mon, 18 May 2015 23:50:45 +0200
Message-ID: <1528857.MjezJ3Xqem@vostro.rjw.lan>
References: <7138791.PFSSF2gqXk@vostro.rjw.lan> <2270439.0UMhzsTGM1@vostro.rjw.lan> <alpine.DEB.2.11.1505181649270.4225@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51046 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750801AbbERVZ1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 17:25:27 -0400
In-Reply-To: <alpine.DEB.2.11.1505181649270.4225@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>

On Monday, May 18, 2015 04:49:43 PM Thomas Gleixner wrote:
> On Sat, 16 May 2015, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Since idle_should_freeze() is defined to always return 'false'
> > for CONFIG_SUSPEND unset, all of the code depending on it in
> > cpuidle_idle_call() is not necessary in that case.
> > 
> > Make that code depend on CONFIG_SUSPEND too to avoid building it
> > when it is not going to be used.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ACK for the tick part.

Thanks!

