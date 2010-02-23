From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] PM: Add arch_suspend_disable_nonboot_cpus
Date: Tue, 23 Feb 2010 17:49:00 +0100
Message-ID: <20100223164900.GG6220@elf.ucw.cz>
References: <201002211631.o1LGVsw8022630@d01av02.pok.ibm.com>
	<201002212337.10462.rjw@sisk.pl>
	<4B81B7C5.5060301@linux.vnet.ibm.com>
	<201002222014.07280.rjw@sisk.pl>
	<4B8313D4.4050802@linux.vnet.ibm.com>
	<20100223154359.GA6220@elf.ucw.cz>
	<4B84053D.60703@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B84053D.60703@linux.vnet.ibm.com>
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

> > (Please wrap at column 80)
> > 
> > This patch is already way better than the original one, but... Why do
> > you want enable/disable_nonboot_cpus to be noped out?
> 
> Today for PPC_PSERIES, PM_SLEEP_SMP is never defined, so for all the
> current code paths that call enable/disable_nonboot_cpus (power off,
> kexec), these functions are noops. I don't want to change that
> behavior.

Why not?

> I figured I can just use the prepare_late and wake pm functions to do
> the work I need to do. Let me know if you think this is a reasonable
> approach and I'll be happy to resend the patch with an appropriate
> subject line and description.

No, I do not think that's reasonable approach. Please just implement
enable/disable_nonboot_cpus; that's the clean fix.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
