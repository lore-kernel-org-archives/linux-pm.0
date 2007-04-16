From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Mon, 16 Apr 2007 09:32:49 +0200
Message-ID: <20070416073249.GA2057@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz>
	<200704140009.33298.rjw@sisk.pl>
	<1176503122.5764.109.camel@localhost.localdomain>
	<20070413223922.GS28264@elf.ucw.cz>
	<1176506383.5764.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176506383.5764.129.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Ok, PowerPC Decrementer 101

(Thanks for explanation).

> Now, in addition to that, we have some weird motherboard stuff we need
> to turn off/on, which has to be done after drivers (because it renders
> various busses inaccessible in some cases, and might cause DMA snooping
> to stop working, I'm not 100% sure, but I know for sure it has to be
> done late) but can't be done as a sysdev because we need some
> infrastructure like the i2c stuff (and others) that requires semaphores
> and timers. It's based on something remotely akin to AML in that we have
> to execute "scripts" provided by the firmware and the code to do so need
> to run in an environment where scheduler & timers are operating.

Does the "weird motherboard" stuff need to be suspended/resumed for
swsusp memory snapshot?

> For all those reasons, I do think that the proper, clean and incremental
> approach to get our stuff working is to have that pair of hooks allowing
> us to "replace" the local_irq_disable/enable calls...
> =

> Now it does not need to be pm_ops. I'm fine with arch_pm_irq_quiesce()
> kind of thing (or find a better name if you can, maybe

Well, I guess arch_pm_irq_quiesce_for_s2ram() would be
acceptable... but that would be only called for s2ram... which should
be enough for decrementer AFAICT.

> It's basically about quiescing the scheduler/timers, which on powerpc
> (bcs of the way the DEC operates) requires a little bit more than just a
> call to local_irq_disable. And once the hook is there, use it for some
> other arch specific bits that we can't quite fit anywhere else at the
> moment.

As decrementer is special for s2ram, we can add the hook. (It is
single hook). If we need to do something for snapshots, too... well,
we can still add arch_pm_irq_quiesce_for_snapshot() and
arch_pm_irq_quiesce_for_powerdown() etc, but it would get ugly fast.

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
