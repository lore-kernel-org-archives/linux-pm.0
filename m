From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Fri, 20 Apr 2007 23:08:51 +0200
Message-ID: <200704202308.52534.rjw@sisk.pl>
References: <1176980411.6141.83.camel@johannes.berg>
	<200704202236.28982.rjw@sisk.pl>
	<1177102268.5902.36.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177102268.5902.36.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 20 April 2007 22:51, Johannes Berg wrote:
> On Fri, 2007-04-20 at 22:36 +0200, Rafael J. Wysocki wrote:
> 
> > Well, I can't say why exactly suspend_enter() usues irq_save/restore, but it
> > looks like that's not needed.
> 
> powerpc works fine just with local_irq_disable/enable, never did
> anything else and my new patches just ignore the *flags argument.
> 
> > For the suspend to disk we call
> > local_irq_disable/enable() in the corresponding places and, for example,
> > acpi_pm_enter apparently uses irq_save/restore() itself too.
> 
> Why would acpi_pm_enter do that? It can always assume irqs are disabled.
> Or does it need to enable them for something (hey, that would mean Ben
> is right in that it probably wants to use these new hooks...)
> 
> > > The only users of this function are in the power management core code (main.c
> > > and user.c) and they certainly always call it with interrupts enabled, the
> > > entry point for other users is pm_suspend() and that surely cannot be called 
> > > with interrupts disabled. Rafael?
> > 
> > That's correct, plus pm_suspend() also uses enter_state().
> 
> Sure, but it can't be called with interrupts disabled.
> 
> > In fact suspend_enter() has been made extern so that we can call it from
> > kernel/power/user.c and no one else is supposed to use it.
> 
> Right.
> 
> So, any argument against re-spinning this patch, removing the unsigned
> long *flags stuff and using local_irq_disable/enable?

Not from me.

Rafael
