From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 04 Jul 2007 07:14:49 +1000
Message-ID: <1183497290.3388.4.camel__33112.2259529822$1183497625$gmane$org@localhost.localdomain>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031608.06348.nigel@nigel.suspend2.net>
	<1183447184.10386.102.camel@localhost.localdomain>
	<200707031456.40890.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707031456.40890.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> >  - For STR, don't do the freezer thing.
> 
> In the long run, I agree.
> 
> Still, can you please read this post from Alan Stern:
> 
> https://lists.linux-foundation.org/pipermail/linux-pm/2007-June/012847.html
> 
> ?  I don't think I'm able to repeat the arguments given in there in a
> convincing way.

That's the same crackpot I've been hearing for the past 3 years or
so ...

Both Paulus and I think the freezer is just a way to try to put your
head in the sand and ignore the problem. It causes as many problems as
it solves on its own, and is just not a solution that will be of any use
once you start implementing dynamic PM schemes etc...

In many cases, having proper support for "live" suspend of devices is
just a matter of having a couple of helpers in whatever subsystem those
drivers hookup with. In the case of network, for example, it's mostly
trivial (stop the queue). For block, it's not terribly hard neither,
though you want to have some orderign/atomicity between the blocking of
the incoming request queue and the sending of things like spindown &
flush commands to the disk. For old-style IDE, that was fairly easily
solved by piping suspend/resume command down the request queue itself
and have the queue block/unblbock itself after processing them. Some of
that logic could maybe be moved to the block layer for all block drivers
to benefit.

But yes, overall, there is work to do on drivers and I'm doing the ones
I hit on the platforms I use. I don't think the freezer is any kind of
remotely good solution, just a way to continue avoiding the problem.

Ben.
