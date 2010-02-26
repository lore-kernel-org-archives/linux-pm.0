From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: s2disk hang update
Date: Fri, 26 Feb 2010 09:26:37 +0000
Message-ID: <9b2b86521002260126g5acabb79uae961dd8668b3c09__33236.4123467871$1267176677$gmane$org@mail.gmail.com>
References: <9b2b86521001020703v23152d0cy3ba2c08df88c0a79@mail.gmail.com>
	<201002242152.55408.rjw@sisk.pl>
	<9b2b86521002250510m75c8b314o37388a04b53a2b67@mail.gmail.com>
	<201002252104.51187.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002252104.51187.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, hugh.dickins@tiscali.co.uk, pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On 2/25/10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday 25 February 2010, Alan Jenkins wrote:
>> On 2/24/10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Wednesday 24 February 2010, Alan Jenkins wrote:
> ...
>>
>> > -	while (to_free_normal > 0 && to_free_highmem > 0) {
>> > +	while (to_free_normal > 0 || to_free_highmem > 0) {
>>
>> Yes, that seems to do it.  No more hangs so far (and I can still
>> reproduce the hang with too many applications if I un-apply the
>> patch).
>
> OK, great.  Is this with or without the NOIO-enforcing patch?

With.

>> I did see a non-fatal allocation failure though, so I'm still not sure
>> that the current implementation is strictly correct.
>>
>> This is without the patch to increase "to_free_normal".  If I get the
>> allocation failure again, should I try testing the "free 20% extra"
>> patch?
>
> Either that or try to increase SPARE_PAGES.  That should actually work with
> the last patch applied. :-)
>
> Rafael

<grin>, OK.
