From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Fri, 6 Apr 2007 01:30:52 +0200
Message-ID: <200704060130.52885.rjw@sisk.pl>
References: <1175810054.3489.34.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1175810054.3489.34.camel@johannes.berg>
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

On Thursday, 5 April 2007 23:54, Johannes Berg wrote:
> For powermac, we need to do some things between suspending devices and
> device_power_off, for example setting the decrementer. This patch
> introduces pm_ops.irq_off and pm_ops.irq_on which will be called instead
> of disabling/enabling irqs so platforms can do a bit more work there if
> necessary.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> =

> ---
> My previous patches moving to the pm_ops interface for powermac were
> buggy due to exactly this issue, but the bug never surfaced on my
> machine, only on machines with an Apple Desktop Bus (or an emulation
> thereof)
> =

> Does this look ok to you? Would you want different names? Should I stick
> in a BUG_ON(interrupts_enabled()) or such?

Well is this possible to do something like

if (pm_ops->do_something_before_disabling_irqs)
	pm_ops->do_something_before_disabling_irqs()
local_irq_save(flags);
if (pm_ops->do_something_after_disabling_irqs)
	pm_ops->do_something_after_disabling_irqs()

and analogously for enabling the IRQs?

Rafael
