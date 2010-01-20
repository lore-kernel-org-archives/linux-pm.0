From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Wed, 20 Jan 2010 12:31:17 +0100
Message-ID: <201001201231.17540.oliver__4468.47369098595$1263989932$gmane$org@neukum.org>
References: <20100118110324.AE30.A69D9226@jp.fujitsu.com>
	<195c7a901001190104x164381f9v4a58d1fce70b17b6@mail.gmail.com>
	<1263943071.724.540.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1263943071.724.540.camel@pasglop>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Bastien ROUCARIES <roucaries.bastien@gmail.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 20. Januar 2010 00:17:51 schrieb Benjamin Herrenschmidt:
> On Tue, 2010-01-19 at 10:04 +0100, Bastien ROUCARIES wrote:
> > Instead of masking bit could we only check if incompatible flags are
> > used during suspend, and warm deeply. Call stack will be therefore
> > identified, and we could have some metrics about such problem.
> > 
> > It will be a debug option like lockdep but pretty low cost.
> 
> I still believe it would just be a giant can of worms to require every
> call site of memory allocators to "know" whether suspend has been
> started or not.... Along the same reasons why we added that stuff for
> boot time allocs.

But we have the freezer. So generally we don't require that knowledge.
We can expect no normal IO to happen.
The question is in the suspend paths. We never may use anything
but GFP_NOIO (and GFP_ATOMIC) in the suspend() path. We can
take care of that requirement in the allocator only if the whole system
is suspended. As soon as a driver does runtime power management,
it is on its own.

	Regards
		Oliver
