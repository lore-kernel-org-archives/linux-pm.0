From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] [443/2many] MAINTAINERS - HIBERNATION (aka
	Software Suspend, aka swsusp):
Date: Mon, 13 Aug 2007 23:25:03 +0200
Message-ID: <200708132325.04810.rjw__23591.8633560233$1187039838$gmane$org@sisk.pl>
References: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe@perches.com>
	<200708132250.15466.rjw@sisk.pl>
	<1187038479.10249.304.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1187038479.10249.304.camel@localhost>
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
Cc: torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, 13 August 2007 22:54, Joe Perches wrote:
> On Mon, 2007-08-13 at 22:50 +0200, Rafael J. Wysocki wrote:
> > Please add
> > arch/i386/power/
> > arch/x86_64/kernel/suspend_asm.S
> > arch/x86_64/kernel/suspend.c
> > drivers/base/power/
> > There also is a couple of headers.  Do you want to list them too?
> 
> Your choice.  Just let me know.

+ include/linux/suspend.h
+ include/linux/freezer.h
+ include/linux/pm.h
+ include/asm-*/suspend.h

Hm, they are also relevant for suspend to RAM, so perhaps one common
list of files for suspend to RAM and hibernation would be better?

> HIBERNATION (aka Software Suspend, aka swsusp):
> P:	Pavel Machek
> M:	pavel@suse.cz
> P:	Rafael J. Wysocki
> M:	rjw@sisk.pl
> L:	linux-pm@lists.linux-foundation.org
> S:	Supported
> F:	Documentation/power/swsusp*
> F:	arch/i386/power/
> F:	arch/x86_64/kernel/suspend*
> F:	drivers/base/power/
> F:	kernel/power/
> 
> 
> 
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
