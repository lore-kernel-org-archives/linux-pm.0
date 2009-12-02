From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Bisected: s2disk (uswsusp only) hangs just before
	poweroff
Date: Wed, 02 Dec 2009 11:11:13 +0000
Message-ID: <4B164B51.6040203__26027.3080006757$1259752332$gmane$org@tuffmail.co.uk>
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
To: Mel Gorman <mel@csn.ul.ie>, "Rafael J. Wysocki" <rjw@sisk.pl>
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

After enabling "suspend loglevel = 8" in uswsusp.conf (grr), I saw a 
pair of hung task backtraces.

<http://picasaweb.google.com/Alan.Christopher.Jenkins/Screenshots#5410594126006567282>


> would you mind trying the following patch?
> Unfortunately, it's totally untested. The intention of the patch is to
> use other PCP lists if the desired one cannot be refilled.
>
> Thanks.
>   

Sure, will do.

Thanks
Alan
