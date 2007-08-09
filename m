From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Fix dependencies of CONFIG_SUSPEND and
	CONFIG_HIBERNATION (updated 2x)
Date: Thu, 9 Aug 2007 15:04:50 +0200
Message-ID: <200708091504.51976.rjw__21139.2315723517$1186664280$gmane$org@sisk.pl>
References: <200708070023.27404.rjw@sisk.pl>
	<20070808150307.378bf385.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070808150307.378bf385.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thursday, 9 August 2007 00:03, Andrew Morton wrote:
> On Tue, 7 Aug 2007 00:23:26 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Dependencies of CONFIG_SUSPEND and CONFIG_HIBERNATION introduced by commit
> > 296699de6bdc717189a331ab6bbe90e05c94db06 "Introduce CONFIG_SUSPEND for
> > suspend-to-Ram and standby" are incorrect, as they don't cover the facts that
> > (1) not all architectures support suspend and (2) SMP hibernation is only
> > possible on X86 and PPC64 (if CONFIG_PPC64_SWSUSP is set).
> > 
> > Moreover, SMP suspend and hibernation are only possible if CONFIG_HOTPLUG is
> > set, because they select HOTPLUG_CPU that depends on it. __Also, since suspend
> > and hibernation don't depend on EXPERIMENTAL, arrange things so that CPU
> > hotplug can be selected if it is not set.
> 
> The version of this which I have (version eighty eight, afaict :),
> reproduced below) breaks ia64 allmodconfig:
> 
> init/Kconfig:416:error: found recursive dependency: HOTPLUG -> SUSPEND_SMP_POSSIBLE -> PM_SLEEP_SMP -> HOTPLUG_CPU -> HOTPLUG
>  -> PCCARD -> PCMCIA -> USB_ARCH_HAS_HCD -> MOUSE_APPLETOUCH -> USB -> USB_SISUS

Well, I have no idea how this is even possible.

On ia64 HOTPLUG_CPU depends only on SMP && EXPERIMENTAL and the patch doesn't
change that.  Moreover, SUSPEND_SMP_POSSIBLE cannot be set on ia64, either with the
patch or without it.

Anyway, I'm going to drop the "HOTPLUG depends on PM_SLEEP_SMP" bits and retest
with allmodconfig on everyting I can test.

BTW, the patch is needed to fix compilation problems on PPC.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
