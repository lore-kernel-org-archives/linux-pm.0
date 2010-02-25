From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: s2disk hang update
Date: Thu, 25 Feb 2010 21:04:51 +0100
Message-ID: <201002252104.51187.rjw__8615.34290384061$1267128318$gmane$org@sisk.pl>
References: <9b2b86521001020703v23152d0cy3ba2c08df88c0a79@mail.gmail.com>
	<201002242152.55408.rjw@sisk.pl>
	<9b2b86521002250510m75c8b314o37388a04b53a2b67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9b2b86521002250510m75c8b314o37388a04b53a2b67@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, hugh.dickins@tiscali.co.uk, pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 25 February 2010, Alan Jenkins wrote:
> On 2/24/10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday 24 February 2010, Alan Jenkins wrote:
...
> 
> > -	while (to_free_normal > 0 && to_free_highmem > 0) {
> > +	while (to_free_normal > 0 || to_free_highmem > 0) {
> 
> Yes, that seems to do it.  No more hangs so far (and I can still
> reproduce the hang with too many applications if I un-apply the
> patch).

OK, great.  Is this with or without the NOIO-enforcing patch?

> I did see a non-fatal allocation failure though, so I'm still not sure
> that the current implementation is strictly correct.
> 
> This is without the patch to increase "to_free_normal".  If I get the
> allocation failure again, should I try testing the "free 20% extra"
> patch?

Either that or try to increase SPARE_PAGES.  That should actually work with
the last patch applied. :-)

Rafael
