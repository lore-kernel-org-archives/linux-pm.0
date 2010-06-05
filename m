From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [SUSPECTED SPAM] Re: Proposal for a new algorithm
 for reading & writing a hibernation image.
Date: Sat, 05 Jun 2010 10:05:13 +1000
Message-ID: <4C0994B9.6070406__21174.9775255614$1275696449$gmane$org@crca.org.au>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi.

On 04/06/10 00:50, Pavel Machek wrote:
> "Nigel Cunningham"<ncunningham@crca.org.au>  wrote:
>> On 30/05/10 15:25, Pavel Machek wrote:
>>> Hi!
>>>
>>>> 2. Prior to writing any of the image, also set up new 4k page tables
>>>> such that an attempt to make a change to any of the pages we're about to
>>>> write to disk will result in a page fault, giving us an opportunity to
>>>> flag the page as needing an atomic copy later. Once this is done, write
>>>> protection for the page can be disabled and the write that caused the
>>>> fault allowed to proceed.
>>>
>>> Tricky.
>>>
>>> page faulting code touches memory, too...
>>
>> Yeah. I realise we'd need to make the pages that are used to record the
>> faults be unprotected themselves. I'm imagining a bitmap for that.
>>
>> Do you see any reason that it could be inherently impossible? That's
>> what I really want to know before (potentially) wasting time trying it.
>
> I'm not sure it is impossible, but it certainly seems way too complex to be
> practical.

Oh. I thought this bit would actually be quite simple if it was 
technically possible. I'm more concerned about the potential for 
difficulties with restoring the state successfully.

> 2mb pages will probably present a problem, as will bat mappings on powerpc.

I have the idea that 2MB pages are only used for the kernel text and 
read only data. Is that right? If so, perhaps they can just be 
unconditionally copied (so that we can restore the image if a different 
kernel is booted) and wouldn't need any page protection. Does that sound 
right?

 From the small bit I've read about bat mappings on the powerpc, it 
looks like they could be replaced with normal ptes while doing 
hibernation. More than willing to be told I don't understand what's 
going on there :)

Nigel
