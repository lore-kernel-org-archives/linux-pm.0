From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [SUSPECTED SPAM] Re: Proposal for a new algorithm
	for reading & writing a hibernation image.
Date: Mon, 7 Jun 2010 10:49:09 +0200
Message-ID: <201006071049.09466.rjw__46423.4833409593$1275900528$gmane$org@sisk.pl>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
	<201006062104.55869.rjw@sisk.pl> <4C0C843D.6030008@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C0C843D.6030008@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

On Monday 07 June 2010, Nigel Cunningham wrote:
> Hi.
> 
> On 07/06/10 05:04, Rafael J. Wysocki wrote:
> > On Sunday 06 June 2010, Maxim Levitsky wrote:
> >> On Sun, 2010-06-06 at 15:57 +0200, Rafael J. Wysocki wrote:
> >>> On Sunday 06 June 2010, Maxim Levitsky wrote:
> > ...
> >>> So how TuxOnIce helps here?
> >> Very simple.
> >>
> >> With swsusp, I can save 750MB (memory) + 250 Vram (vram)
> >> With full memory save I can save (1750 MB of memory) + 250 MB of
> >> vram....
> >
> > So what about being able to save 1600 MB total instead of the 2 GB
> > (which is what we're talking about in case that's not clear)?  Would it
> > be _that_ _much_ worse?
> 
> That all depends on what is in the 400MB you discard.

Well, they are discarded following the LRU algorithm and it's very much
like loading a program that takes 20% of your memory upfront.

> The difference is "Just as if you'd never hibernated" vs something 
> closer to "Just as if you'd only just started up". We can't make 
> categorical statements because it really does depend upon what you 
> discard and what you want to do post-resume - that is, how useful the 
> memory you discard would have been. That's always going to vary from 
> case to case.

Not so much.

Besides, it doesn't matter too much.

Let me reiterate, please.  Doing serious memory management behind the back
of the mm subsystem (and trying to do that so it doesn't notice) is wrong and
the reason it works is by accident.  As long as you do that, I have a problem
with TuxOnIce.

Rafael
