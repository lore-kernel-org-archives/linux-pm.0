From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] PM: Add arch_suspend_disable_nonboot_cpus
Date: Tue, 23 Feb 2010 16:43:59 +0100
Message-ID: <20100223154359.GA6220@elf.ucw.cz>
References: <201002211631.o1LGVsw8022630@d01av02.pok.ibm.com>
	<201002212337.10462.rjw@sisk.pl>
	<4B81B7C5.5060301@linux.vnet.ibm.com>
	<201002222014.07280.rjw@sisk.pl>
	<4B8313D4.4050802@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B8313D4.4050802@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian King <brking@linux.vnet.ibm.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > OK
> > 
> >> Here is an alternative implementation of the patch. My test machine is
> >> currently unavailable, so it is not yet been tested. How does this one look?
> > 
> > Well, I'd like to do that cleanly from the start.
> > 
> > Now, the problem is that PM_SLEEP_SMP selects HOTPLUG_CPU, because
> > that's necessary for the other architectures to make SMP suspend work, but it's
> > not necessary on your architecture.  Moreover, you don't need to compile
> > enable_nonboot_cpus() at all.

>  At least for the architecture I am enabling this support for
> (PPC_PSERIES), upon looking closer, it looks like PM_SLEEP_SMP was
> never defined, so enable_nonboot_cpus and disable_nonboot_cpus were
> always nooped before, which I didn't previously realize. We probably
> want to retain this behavior.  >

(Please wrap at column 80)

This patch is already way better than the original one, but... Why do
you want enable/disable_nonboot_cpus to be noped out?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
