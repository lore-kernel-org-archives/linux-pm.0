From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [TuxOnIce-devel] [SUSPECTED SPAM] Re: Proposal for a
 new algorithm for reading & writing a hibernation image.
Date: Tue, 08 Jun 2010 07:31:04 +1000
Message-ID: <4C0D6518.7000603__1487.58094660497$1275946315$gmane$org@crca.org.au>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
	<4C0C843D.6030008@crca.org.au>
	<201006071507.56259.Martin@lichtvoll.de>
	<201006072328.21878.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006072328.21878.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

On 08/06/10 07:28, Rafael J. Wysocki wrote:
> On Monday 07 June 2010, Martin Steigerwald wrote:
>> Am Montag 07 Juni 2010 schrieb Nigel Cunningham:
>>> Hi.
>>
>> Hi Nigel and Rafael, hi everyone else involved,
>>
>>> On 07/06/10 05:04, Rafael J. Wysocki wrote:
>>>> On Sunday 06 June 2010, Maxim Levitsky wrote:
>>>>> On Sun, 2010-06-06 at 15:57 +0200, Rafael J. Wysocki wrote:
>>>>>> On Sunday 06 June 2010, Maxim Levitsky wrote:
>>>> ...
>>>>
>>>>>> So how TuxOnIce helps here?
>>>>>
>>>>> Very simple.
>>>>>
>>>>> With swsusp, I can save 750MB (memory) + 250 Vram (vram)
>>>>> With full memory save I can save (1750 MB of memory) + 250 MB of
>>>>> vram....
>>>>
>>>> So what about being able to save 1600 MB total instead of the 2 GB
>>>> (which is what we're talking about in case that's not clear)?  Would
>>>> it be _that_ _much_ worse?
>>>
>>> That all depends on what is in the 400MB you discard.
>>>
>>> The difference is "Just as if you'd never hibernated" vs something
>>> closer to "Just as if you'd only just started up". We can't make
>>> categorical statements because it really does depend upon what you
>>> discard and what you want to do post-resume - that is, how useful the
>>> memory you discard would have been. That's always going to vary from
>>> case to case.
>>
>> Nigel and Rafael, how about just testing it?
>
> ISTR that can be done to some extent using TuxOnIce as is, becuase there is a
> knob that you can use to limit the image size.

Yes.

>> Whats needed to have 80% of the memory saved instead of 50%?
>>
>> I think its important to go the next steps towards a better snapshot in
>> mainline kernel even when you do not agree on the complete end result yet.
>>
>> What about
>>
>> - Rafael, you review the async write patches of Nigel. If they are good,
>> IMHO they should go in as soon as possible.
>
> Yes, I'm going to do that.

Great.

>> - Nigel and/or Rafael, you look at whats needed to save 80% instead of 50%
>> of the memory and develop a patch for it
>
> That would be my suggestion as well.

It would be no problem to merge most of the TuxOnIce code without even 
thinking further about this two-part image issue, because TuxOnIce also 
has a tuneable to disable the second part of the image. We could even 
merge the two part stuff and make it off by default, but I'm not sure 
Rafael would accept that option.

Regards,

Nigel
