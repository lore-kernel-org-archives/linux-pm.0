From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Bisected: s2disk (uswsusp only) hangs just before
	poweroff
Date: Wed, 02 Dec 2009 08:57:05 +0000
Message-ID: <4B162BE1.7070709__32903.6036892377$1259744363$gmane$org@tuffmail.co.uk>
References: <4B1575AC.6080904@tuffmail.co.uk> <20091201214529.GA1457@csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091201214529.GA1457@csn.ul.ie>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mel Gorman <mel@csn.ul.ie>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Mel Gorman wrote:
> On Tue, Dec 01, 2009 at 07:59:40PM +0000, Alan Jenkins wrote:
>   
>> Hi
>>
>> Suspend to disk is (sometimes) hanging for me in 2.6.32-rc.  I finally  
>> got around to bisecting it, which blamed the following commit by Mel:
>>
>> 5f8dcc2 "page-allocator: split per-cpu list into one-list-per-migrate-type"
>>
>> I was able to confirm this by reverting the commit, which fixed the  
>> hang.  I had to revert one other commit first to avoid a conflict:
>>
>> a6f9edd "page-allocator: maintain rolling count of pages to free from  
>> the PCP"
>>
>>     
>
> Which RC kernel? Specifically, are the commits
>
> cc4a6851466039a8a688c843962a05689059ff3b always wake kswapd when restarting an allocation attempt
> 9d0ed60fe9cd1fbf57f755cd27a23ae9114d7210 Do not allow interrupts to use ALLOC_HARDER
>
> applied?
>
> The latter one in particular might make a difference if s2disk is
> pushing the system far below the watermarks. I don't suppose you know
> where it's hanging? i.e. is it hanging in the allocator itself?
>
> If those patches are applied, then one difference that 5f8dcc2 makes is
> that pages on the PCP lists but not of the right migratetype are not
> used. Prior to that commit, an allocation might succeed even if the
> buddy lists were empty because one of the other PCP page types would be
> used.
>
>   
>> -- detail --
>>
>> When I suspend my EeePc 701 to disk, it sometimes hangs after writing  
>> out the hibernation image.  The system is still able to resume from this  
>> image (after working around the hang by pressing the power button). 
>>
>> This is specific to s2disk from the uswsusp package (which is now  
>> installed by default on debian unstable).  It doesn't happen if I  
>> uninstall uswsusp and use the in-kernel suspend instead.
>>
>>     
>
> This leads me to believe that uswsusp is able to push available pages
> far below what is expected. It's a total guess though, I have no idea
> how uswsusp is implemented or how it differs from what is in kernel.
>
>   
>> The hang doesn't happen if I boot with "init=/bin/bash" and run s2disk.   
>> Nor does it happen if I boot normally, then switch to single user mode  
>> ("telinit 12").
>>
>> It only happens if I've logged in to KDE.  In the past, this has  
>> indicated a problem in a network driver, since NetworkManager only made  
>> a connection once I logged in.  But it still hangs if I remove both  
>> ath5k and atl2 before I log into KDE.  (I actually tried removing as  
>> many modules as possible: atl2, ath5k, usbcore, snd-hda-intel, psmouse,  
>> pcspkr, battery, ac, themal, fan, and eeepc-laptop).  Perhaps it's  
>> something to do with the size of the hibernation image.
>>
>>     
>
> I believe you are correct in that it's something to do with the size of
> the hibernation image and how close to the edge the kernel gets pushed
> as a result.
>
> Please confirm first that the two commits I mentioned above are in your
> kernel. If not, would you mind trying the following patch?
> Unfortunately, it's totally untested. The intention of the patch is to
> use other PCP lists if the desired one cannot be refilled.
>
> Thanks.
>   

The hang happens on 2.6.32-rc8, which includes the two commits above.

Thanks!
Alan
