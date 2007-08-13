From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] [443/2many] MAINTAINERS - HIBERNATION (aka
	Software Suspend, aka swsusp):
Date: Mon, 13 Aug 2007 23:38:24 +0200
Message-ID: <200708132338.25925.rjw@sisk.pl>
References: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe@perches.com>
	<200708132325.04810.rjw@sisk.pl>
	<1187040080.10249.323.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1187040080.10249.323.camel@localhost>
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
To: Joe Perches <joe@perches.com>, pavel@suse.cz
Cc: linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, 13 August 2007 23:21, Joe Perches wrote:
> On Mon, 2007-08-13 at 23:25 +0200, Rafael J. Wysocki wrote:
> > + include/linux/suspend.h
> > + include/linux/freezer.h
> > + include/linux/pm.h
> > + include/asm-*/suspend.h
> > 
> > Hm, they are also relevant for suspend to RAM, so perhaps one common
> > list of files for suspend to RAM and hibernation would be better?
> 
> Maybe just collapse the 2 maintainers blocks into one?
> 
> HIBERNATION (aka Software Suspend, aka swsusp) and SUSPEND TO RAM:
> P:	Pavel Machek
> M:	pavel@suse.cz
> P:	Rafael J. Wysocki
> M:	rjw@sisk.pl
> L:	linux-pm@lists.linux-foundation.org
> S:	Supported

Then I think it should be "Maintained".

> F:	Documentation/power/swsusp*

F: Documentation/power/

> F:	arch/i386/kernel/acpi/
> F:	arch/i386/power/
> F:	arch/x86_64/kernel/acpi/
> F:	arch/x86_64/kernel/suspend_asm.S
> F:	arch/x86_64/kernel/suspend.c
> F:	drivers/base/power/
> F:	kernel/power/
> F:	include/linux/suspend.h
> F:	include/linux/freezer.h
> F:	include/linux/pm.h
> F:	include/asm-*/suspend.h

Pavel, what do you think?


-- 
"Premature optimization is the root of all evil." - Donald Knuth
