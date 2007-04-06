From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Fri, 6 Apr 2007 02:02:13 +0200
Message-ID: <200704060202.13597.rjw@sisk.pl>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060130.52885.rjw@sisk.pl>
	<1175815737.3489.37.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1175815737.3489.37.camel@johannes.berg>
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
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, 6 April 2007 01:28, Johannes Berg wrote:
> On Fri, 2007-04-06 at 01:30 +0200, Rafael J. Wysocki wrote:
> =

> > Well is this possible to do something like
> > =

> > if (pm_ops->do_something_before_disabling_irqs)
> > 	pm_ops->do_something_before_disabling_irqs()
> > local_irq_save(flags);
> > if (pm_ops->do_something_after_disabling_irqs)
> > 	pm_ops->do_something_after_disabling_irqs()
> > =

> > and analogously for enabling the IRQs?
> =

> Ultimately yes, but is it worth the added complexity? Somebody mucking
> with pm_ops has to know what he's doing anyway.

Well, this seems to be more natural ("if you want to do something before/af=
ter
disabling the IRQs, define it" instead of "you can do something instead of
calling local_irq_save(), but please remember to disable the IRQs yourself
in that case").

BTW, it need not be in pm_ops (actually, why should it be there?).
Alternatively, you can define something like arch_prepare_for_disabling_irq=
s()
and/or arch_prepare_device_power_down() that will be empty on x86, for
example.

BTW2, I think BUG_ON(irqs_enabled) is needed after the arch does something
instead of or after local_irq_save().

Rafael
