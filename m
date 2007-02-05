From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/10] powerpc: fix comment in kernel/irq.c
Date: Tue, 06 Feb 2007 10:53:47 +1100
Message-ID: <1170719627.2620.157.camel@localhost.localdomain>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185836.099816000@sipsolutions.net>
	<1170716376.2620.141.camel@localhost.localdomain>
	<20070205151816.d841633b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070205151816.d841633b.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-02-05 at 15:18 -0800, Andrew Morton wrote:
> On Tue, 06 Feb 2007 09:59:36 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> =

> > On Mon, 2007-02-05 at 19:30 +0100, Johannes Berg wrote:
> > > plain text document attachment (irq-comment.patch)
> > > kernel/irq.c contains a comment that speaks of -1 and -2 as interrupt
> > > numbers. Replace by NO_IRQ and NO_IRQ_IGNORE.
> > > =

> > > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> > > Cc: Andrew Morton <akpm@osdl.org>
> > =

> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> =

> I hope that wasn't acked at me.  I was only copied on half this patch
> series and I only picked up swsusp-dont-copy-pages-that-arent-ram.patch a=
nd
> windfarm-dont-die-on-suspend-thread-signal.patch.

This one is really independant of the rest, so it can be picked up by
either you or paulus or both, whoever jumps on it first :-) I wrote the
code this comment refers to so I just reviewed & acked :-)

Ben.
