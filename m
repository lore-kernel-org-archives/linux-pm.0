From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 20:58:55 +1000
Message-ID: <18059.32111.58643.97174@cargo.ozlabs.ibm.com>
References: <20070703211227.GA28758@srcf.ucam.org>
	<200707032337.52544.rjw@sisk.pl>
	<18059.5690.908102.273897@cargo.ozlabs.ibm.com>
	<200707041242.59552.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707041242.59552.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki writes:

> Okay, so in fact you don't know.

Don't know what exactly?

It has been a while since I had my head in the USB code.  I assume
it's being maintained by competent people. :)

> And that's my point in this thread.

Well, I'd be interested in hearing from Matthew whether he has
actually been using his patch in Ubuntu, and if so, what bug reports
he has been receiving related to it?

> I won't fight for the freezer for what it's worth, but let's do things in the
> _right_ _order_.  For example, let's make sure that by making the $subject
> change we won't introduce (too many) regressions and fix the frameworks
> that don't get it right.
> 
> Using the problems with FUSE as an argument for making this change immediately
> doesn't seem to be right to me.

I can see your point, but I won't be moving powermac over to use the
generic suspend path until the freezer is gone, since I am pretty
confident that the drivers we care about behave sensibly, and I have
seen a lot of traffic on linux-pm and lkml about problems caused by
the freezer.

Also, no-one has yet answered my fundamental objection to the freezer,
which is that the very kernel threads we would want to freeze are
often the same ones that we must not freeze, namely the threads that
issue I/O requests in order to satisfy incoming I/O requests.

If there was an automatic way to construct the graph of dependencies
(including data flows) between tasks, and derive an ordering for
freezing that guarantees that all I/Os will get completed without
deadlocks, then I could accept the freezer.  But we don't have
anything like that.

Paul.
