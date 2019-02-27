From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 8/9] PM / Domains: Support IRQ safe PM domains
Date: Wed, 27 Feb 2019 01:00:35 +0100
Message-ID: <CAPDyKFq1xma+vi_T0qyPo0FNUEUOSiog2WGhEkgZLN4j-0z6aQ@mail.gmail.com>
References: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
 <1477347668-41901-9-git-send-email-lina.iyer@linaro.org>
 <CAMuHMdVDtP=Y=FWfy56d+azW4bJ=3ihmmwdVkzEX-K3W6Wc9zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdVDtP=Y=FWfy56d+azW4bJ=3ihmmwdVkzEX-K3W6Wc9zA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Brendan Jackman <brendan.jackman@arm.com>, Lina Iyer <lina.iyer@linaro.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 26 Feb 2019 at 16:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Lina,
>
> Yes, this is a reply to an old patch.
> But it seems there are no upstream users of GENPD_FLAG_IRQ_SAFE yet...

Correct. But I are working on adding the first ones, as you probably know.

>
> On Tue, Oct 25, 2016 at 12:21 AM Lina Iyer <lina.iyer@linaro.org> wrote:
> > Generic Power Domains currently support turning on/off only in process
> > context. This prevents the usage of PM domains for domains that could be
> > powered on/off in a context where IRQs are disabled. Many such domains
> > exist today and do not get powered off, when the IRQ safe devices in
> > that domain are powered off, because of this limitation.
> >
> > However, not all domains can operate in IRQ safe contexts. Genpd
> > therefore, has to support both cases where the domain may or may not
> > operate in IRQ safe contexts. Configuring genpd to use an appropriate
> > lock for that domain, would allow domains that have IRQ safe devices to
> > runtime suspend and resume, in atomic context.
> >
> > To achieve domain specific locking, set the domain's ->flag to
> > GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that genpd
> > should use a spinlock instead of a mutex for locking the domain. Locking
> > is abstracted through genpd_lock() and genpd_unlock() functions that use
> > the flag to determine the appropriate lock to be used for that domain.
> >
> > Domains that have lower latency to suspend and resume and can operate
> > with IRQs disabled may now be able to save power, when the component
> > devices and sub-domains are idle at runtime.
> >
> > The restriction this imposes on the domain hierarchy is that non-IRQ
> > safe domains may not have IRQ-safe subdomains, but IRQ safe domains may
> > have IRQ safe and non-IRQ safe subdomains and devices.
> >
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/domain.c | 111 ++++++++++++++++++++++++++++++++++++++++----
> >  include/linux/pm_domain.h   |  10 +++-
> >  2 files changed, 110 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 1ad42f2..07ed835 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -74,11 +74,70 @@ static const struct genpd_lock_ops genpd_mtx_ops = {
> >         .unlock = genpd_unlock_mtx,
> >  };
> >
> > +static void genpd_lock_spin(struct generic_pm_domain *genpd)
> > +       __acquires(&genpd->slock)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&genpd->slock, flags);
> > +       genpd->lock_flags = flags;
> > +}
> > +
> > +static void genpd_lock_nested_spin(struct generic_pm_domain *genpd,
> > +                                       int depth)
> > +       __acquires(&genpd->slock)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave_nested(&genpd->slock, flags, depth);
> > +       genpd->lock_flags = flags;
>
> I don't think this is correct: during the second or any subsequent call,
> the old genpd->lock_flags will be overwritten by the new one.
> As interrupts are already disabled when doing a second call, the new
> flags will reflect this, and calling genpd_unlock_spin() below will
> never re-enable interrupts again.

That seems like a correct observation, at least as far as I can tell.
Thanks for looking into this!

>
> Note that changing the above to
>
>     if (!depth)
>             genpd->lock_flags = flags;
>
> won't help, as that means the first call to genpd_unlock_spin() will
> re-enable interrupts, which is too early.
>
> Using a single genpd->lock_flags can work only in case interrupts were
> already disabled before the first call.  But perhaps that's guaranteed?

So far, the only user case I have been playing with, is for CPUs. In
that case, this code in executed in the cpuidle path and thus IRQs are
disabled, so yes then it works.

>
> Apart from that, given depth is used as a lockdep subclass, and the
> following comment in include/linux/lockdep.h:
>
>     /*
>      * For trivial one-depth nesting of a lock-class, the following
>      * global define can be used. (Subsystems with multiple levels
>      * of nesting should define their own lock-nesting subclasses.)
>      */
>     #define SINGLE_DEPTH_NESTING                 1
>
> I'm wondering if depth > 1 actually works as expected.
>
> Am I missing something?

I don't think so, we need to fix this problem, in one way or the other.

Clearly this code hasn't been executed enough, probably only by me and
Lina and for CPUs. Ideally, we should try to make it work for the
generic case, as I think there are more potential users of it.

[...]

Kind regards
Uffe
