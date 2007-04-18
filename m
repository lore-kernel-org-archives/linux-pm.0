From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Wed, 18 Apr 2007 17:50:56 +1000
Message-ID: <1176882656.7639.10.camel@localhost.localdomain>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz> <200704140009.33298.rjw@sisk.pl>
	<1176503122.5764.109.camel@localhost.localdomain>
	<20070413223922.GS28264@elf.ucw.cz>
	<1176506383.5764.129.camel@localhost.localdomain>
	<20070416073249.GA2057@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070416073249.GA2057@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-04-16 at 09:32 +0200, Pavel Machek wrote:

> Does the "weird motherboard" stuff need to be suspended/resumed for
> swsusp memory snapshot?

I don't think so... I need to get into the details to verify, it might
make sense to run some of the "resume" bits of it when resuming a STD
kernel but I doubt it. It won't harm tho.

> Well, I guess arch_pm_irq_quiesce_for_s2ram() would be
> acceptable... but that would be only called for s2ram... which should
> be enough for decrementer AFAICT.

That's a pretty ugly name :-0 I'd be fine just having
arch_pm_irq_quiesce() and only call it from the right s2ram call sites,
or pass it an argument indicating the type of suspend and let the arch
decide what to do. I fail to see the point in being so overly
restrictive on something which will in the long run have little to no
impact.

> As decrementer is special for s2ram, we can add the hook. (It is
> single hook). If we need to do something for snapshots, too... well,
> we can still add arch_pm_irq_quiesce_for_snapshot() and
> arch_pm_irq_quiesce_for_powerdown() etc, but it would get ugly fast.

Which is why I think we should stick with the pair

arch_pm_irq_quiesce() and arch_pm_irq_activate() or whatever name you
come up with, and either have them only called for s2ram or pass the
suspend type to them, I don't like the over long weird names you are
coming up with but that's a detail :-)

Ben.
