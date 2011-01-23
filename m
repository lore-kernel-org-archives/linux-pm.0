From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Occasional (too common) suspend problem
Date: Sun, 23 Jan 2011 22:29:49 +0100
Message-ID: <201101232229.49494.rjw__19543.1941109293$1295818311$gmane$org@sisk.pl>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<201101222017.40389.rjw@sisk.pl>
	<AANLkTikSZTZ+mSWcjs2LQGOTbbKY+SAb5YEjP+GDSK0+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikSZTZ+mSWcjs2LQGOTbbKY+SAb5YEjP+GDSK0+@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Jesse Barnes <jbarnes@virtuousgeek.org>, Chris Wilson <chris@chris-wilson.co.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, January 22, 2011, Linus Torvalds wrote:
> On Sat, Jan 22, 2011 at 11:17 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>
...

> But the pm-suspend scripts do still end up
> doing a lot of other things (like trying to switch vt's etc - but
> disabling that didn't do anything for me).

Well, I had a hackish patch disabling the kernel's own VT switch during
suspend if the Intel graphics driver was used with KMS.  I can dig it up if
you want to try that, so let me know.

> One more comment: when I disable the VT switching, I end up seeing the
> kernel messages during suspend, but they obviously stop at
> "suspend_console()". When I use "no_console_suspend" to show mssages,
> the last message I see before the machine needs a keypess is the one
> where we disable the i915 IRQ.
> 
> Which probably doesn't mean anything, since it's probably just a
> direct result of me saying "try to print stuff even over the suspend"
> together with the i915 driver then not being able to due to not having
> interrupts. So I suspect the "no_console_suspend" thing just doesn't
> much help - it just results in more problems for the  suspend, and it
> probably never works at all.

I think so.  My experience is that it doesn't really work with KMS drivers.

There's one more thing that may be related.  Apparently, we've made something
recently that's causing lots of problems with boot and poweroff for Asus
machines (https://lkml.org/lkml/2011/1/23/54).  The Asus BIOSes evidently
don't like something we do, but I have no idea what that may be at this point.

Rafael
