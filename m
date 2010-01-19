From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
 suspend/resume (was: Re: Memory allocations in .suspend became very
 unreliable)
Date: Wed, 20 Jan 2010 10:17:51 +1100
Message-ID: <1263943071.724.540.camel__9045.51124335757$1263943196$gmane$org@pasglop>
References: <20100118110324.AE30.A69D9226@jp.fujitsu.com>
	<201001182155.09727.rjw@sisk.pl>
	<20100119101101.5F2E.A69D9226@jp.fujitsu.com>
	<1263871194.724.520.camel@pasglop>
	<195c7a901001190104x164381f9v4a58d1fce70b17b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <195c7a901001190104x164381f9v4a58d1fce70b17b6@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bastien ROUCARIES <roucaries.bastien@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-01-19 at 10:04 +0100, Bastien ROUCARIES wrote:
> Instead of masking bit could we only check if incompatible flags are
> used during suspend, and warm deeply. Call stack will be therefore
> identified, and we could have some metrics about such problem.
> 
> It will be a debug option like lockdep but pretty low cost.

I still believe it would just be a giant can of worms to require every
call site of memory allocators to "know" whether suspend has been
started or not.... Along the same reasons why we added that stuff for
boot time allocs.

Cheers,
Ben.
