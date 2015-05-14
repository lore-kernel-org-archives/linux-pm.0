From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter() failures
Date: Thu, 14 May 2015 02:16:11 +0200
Message-ID: <1842725.60y5FMGEPh@vostro.rjw.lan>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com> <2919083.VPTOth98op@vostro.rjw.lan> <7h7fsc2idw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54770 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751612AbbEMXvA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 19:51:00 -0400
In-Reply-To: <7h7fsc2idw.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, peterz@infradead.org, tglx@linutronix.de, rafael.j.wysocki@intel.com, rlippert@google.com, linux-pm@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com, linuxppc-dev@lists.ozlabs.org, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wednesday, May 13, 2015 03:59:55 PM Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> [...]
> 
> > Second, quite honestly, I don't see a connection to genpd here.
> 
> The connection with genpd is because the *reason* the timer was
> shutdown/stopped is because it shares power with the CPU, which is why
> the timer stops when the CPU hits ceratin low power states.  IOW, it's
> in the same power domain as the CPU.

Well, what if you don't have genpd on that system?  Is the problem at hand not
relevant then magically?

Rafael

