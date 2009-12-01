From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Bisected: s2disk (uswsusp only) hangs just before
	poweroff
Date: Tue, 01 Dec 2009 20:27:21 +0000
Message-ID: <4B157C29.6090805__30700.2669935629$1259699310$gmane$org@tuffmail.co.uk>
References: <4B1575AC.6080904@tuffmail.co.uk> <4B157B81.9050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B157B81.9050703@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: Mel Gorman <mel@csn.ul.ie>, pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Justin P. Mattock wrote:
> On 12/01/09 11:59, Alan Jenkins wrote:
>> Hi
>>
>> Suspend to disk is (sometimes) hanging for me in 2.6.32-rc. I finally
>> got around to bisecting it, which blamed the following commit by Mel:
>>
>> 5f8dcc2 "page-allocator: split per-cpu list into 
>> one-list-per-migrate-type"
>>
>> I was able to confirm this by reverting the commit, which fixed the
>> hang. I had to revert one other commit first to avoid a conflict:
>>
>> a6f9edd "page-allocator: maintain rolling count of pages to free from
>> the PCP"
>>
>> -- detail --
>>
>> When I suspend my EeePc 701 to disk, it sometimes hangs after writing
>> out the hibernation image. The system is still able to resume from this
>> image (after working around the hang by pressing the power button).
>> This is specific to s2disk from the uswsusp package (which is now
>> installed by default on debian unstable). It doesn't happen if I
>> uninstall uswsusp and use the in-kernel suspend instead.
>>
>> The hang doesn't happen if I boot with "init=/bin/bash" and run s2disk.
>> Nor does it happen if I boot normally, then switch to single user mode
>> ("telinit 12").
>>
>> It only happens if I've logged in to KDE. In the past, this has
>> indicated a problem in a network driver, since NetworkManager only made
>> a connection once I logged in. But it still hangs if I remove both ath5k
>> and atl2 before I log into KDE. (I actually tried removing as many
>> modules as possible: atl2, ath5k, usbcore, snd-hda-intel, psmouse,
>> pcspkr, battery, ac, themal, fan, and eeepc-laptop). Perhaps it's
>> something to do with the size of the hibernation image.
>>
>> -- confidence in the bisection result --
>>
>> The randomness was a bit annoying, but it's not too bad. The hang would
>> normally show up in the first 3 hibernation cycles; I don't remember
>> having to wait more than 6.
>>
>> I wrote a script to do s2disk + rtcwake so I could leave it testing
>> without constantly hitting the power button. This let me test 2.6.32-rc8
>> with the reverts for at least 20 hibernation cycles.
>>
>> Regards
>> Alan
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at http://www.tux.org/lkml/
>>
>
> hmm.. maybe this is what I'm seeing over here
> i.g. on my macbook(ati gpu) the first s2ram will
> lagg for about 30/40 secs before waking up
> then every other cycle afterwards reacts as it should.
> Threw in kernels 2.6.30,31 before doing anything
> but showed the same results, leading me to beleive maybe
> I have some userspace issue(libx86)going on.
>
> I'll try reverting that commit to see.
>
> Thanks
>
> Justin P. Mattock

I don't expect so.  My problem doesn't affect s2ram.  And as far as I 
can tell, my hang is forever... it's more than just 40 seconds.

Regards
Alan
