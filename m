From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] [443/2many] MAINTAINERS - HIBERNATION (aka
	Software Suspend, aka swsusp):
Date: Tue, 14 Aug 2007 20:14:38 +0200
Message-ID: <200708142014.39391.rjw@sisk.pl>
References: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe@perches.com>
	<200708141937.06676.rjw@sisk.pl>
	<1187114231.32555.105.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1187114231.32555.105.camel@localhost>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 14 August 2007 19:57, Joe Perches wrote:
> On Tue, 2007-08-14 at 19:37 +0200, Rafael J. Wysocki wrote:
> > (1) hibernation
> > F:      Documentation/power/
> > F:      arch/i386/power/
> > F:      arch/x86_64/kernel/suspend_asm.S
> > F:      arch/x86_64/kernel/suspend.c
> > F:      drivers/base/power/
> > F:      kernel/power/
> > F:      include/linux/suspend.h
> > F:      include/linux/freezer.h
> > F:      include/linux/pm.h
> > F:      include/asm-*/suspend.h
> > 
> > (2) suspend
> > F:      Documentation/power/
> > F:      arch/i386/kernel/acpi/
> > F:      arch/x86_64/kernel/acpi/
> > F:      arch/x86_64/kernel/suspend.c
> > F:      drivers/base/power/
> > F:      kernel/power/
> > F:      include/linux/suspend.h
> > F:      include/linux/freezer.h
> > F:      include/linux/pm.h
> > F:      include/asm-*/suspend.h
> 
> SUSPEND TO RAM:
> P:	Pavel Machek
> M:	pavel@suse.cz
> P:	Rafael J. Wysocki
> M:	rjw@sisk.pl
> L:	linux-pm@lists.linux-foundation.org
> S:	Maintained
> F:	Documentation/power/
> F:	arch/i386/kernel/acpi/
> F:	arch/x86_64/kernel/acpi/
> F:	arch/x86_64/kernel/suspend.c
> F:	drivers/base/power/
> F:	kernel/power/
> F:	include/linux/suspend.h
> F:	include/linux/freezer.h
> F:	include/linux/pm.h
> F:	include/asm-*/suspend.h
> 
> HIBERNATION (aka Software Suspend, aka swsusp)
> P:	Pavel Machek
> M:	pavel@suse.cz
> P:	Rafael J. Wysocki
> M:	rjw@sisk.pl
> L:	linux-pm@lists.linux-foundation.org
> S:	Supported
> F:	Documentation/power/
> F:	arch/i386/power/
> F:	arch/x86_64/kernel/suspend_asm.S
> F:	arch/x86_64/kernel/suspend.c
> F:	drivers/base/power/
> F:	kernel/power/
> F:	include/linux/suspend.h
> F:	include/linux/freezer.h
> F:	include/linux/pm.h
> F:	include/asm-*/suspend.h

ACK
