From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [SUSPECTED SPAM] Re: Proposal for a new algorithm
 for reading & writing a hibernation image.
Date: Mon, 07 Jun 2010 15:31:41 +1000
Message-ID: <4C0C843D.6030008__28579.957856755$1275888837$gmane$org@crca.org.au>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>	<201006061557.20482.rjw@sisk.pl>	<1275839650.5331.2.camel@maxim-laptop>
	<201006062104.55869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006062104.55869.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi.

On 07/06/10 05:04, Rafael J. Wysocki wrote:
> On Sunday 06 June 2010, Maxim Levitsky wrote:
>> On Sun, 2010-06-06 at 15:57 +0200, Rafael J. Wysocki wrote:
>>> On Sunday 06 June 2010, Maxim Levitsky wrote:
> ...
>>> So how TuxOnIce helps here?
>> Very simple.
>>
>> With swsusp, I can save 750MB (memory) + 250 Vram (vram)
>> With full memory save I can save (1750 MB of memory) + 250 MB of
>> vram....
>
> So what about being able to save 1600 MB total instead of the 2 GB
> (which is what we're talking about in case that's not clear)?  Would it
> be _that_ _much_ worse?

That all depends on what is in the 400MB you discard.

The difference is "Just as if you'd never hibernated" vs something 
closer to "Just as if you'd only just started up". We can't make 
categorical statements because it really does depend upon what you 
discard and what you want to do post-resume - that is, how useful the 
memory you discard would have been. That's always going to vary from 
case to case.

Regards,

Nigel
