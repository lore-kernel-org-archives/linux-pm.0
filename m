From: "M. Vefa Bicakci" <bicave@superonline.com>
Subject: Re: PATCH: PM / Hibernate: Avoid hitting OOM during
	preallocationof memory
Date: Sat, 11 Sep 2010 14:12:27 -0400
Message-ID: <4C8BC68B.8050002__24498.4307945289$1284228835$gmane$org@superonline.com>
References: <201009062043.37819.rjw@sisk.pl> <201009072344.53905.rjw@sisk.pl>
	<4C878818.1070705@superonline.com> <201009082334.01255.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009082334.01255.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

Hello,

Sorry for the late reply. I have been busy the past few days.

On 08/09/10 05:34 PM, Rafael J. Wysocki wrote:
> On Wednesday, September 08, 2010, M. Vefa Bicakci wrote:
>> [snip]
>>
>> I should note a few things though,
>>
>> 1) I don't think I ever changed /sys/power/image_size, so we can rule out the
>> possibility of that option changing the results.
> 
> Can you please check what value is there in this file?

It contains 524288000, so I think it is set to 500 MB. I believe that this is
the default value, but I am not sure.

>> 2) With the patch below, for the *first* hibernation operation, the computer
>> enters a "thoughtful" state without any disk activity for 6-8 (maybe 10)
>> seconds after printing "Preallocating image memory". It works properly after
>> the wait however.
> 
> That probably is a result of spending time in the memory allocator trying to
> reduce the size of the image as much as possible.

I am not sure if this is a new thing with the new patch, but the behavior
seems to continue with the later hibernation operations too, not just the
first one. I haven't confirmed if I really didn't realize the problem in
the previous version of the patch, but it is very possible that I didn't
realize it since I used to automate my tests. (I didn't automate my tests
this time.)

However, considering that the kernel needs to worry about compacting 1500 MB
of data when hibernating with my tmpfs-is-full system, I guess these wait
times are normal, even though a bit inconvenient.

>> [snip]
> 
>> 4) I made sure that I was not being impatient with the previous snapshot.c
>> patch, so I tested that on its own once again, and I confirmed that hibernation
>> hangs with the older version of the snapshot.c patch.
>>
>> I am very happy that we are getting closer to a solution. Please let me know
>> if there is anything I need to test further.
> 
> Below is the patch I'd like to apply.  It should work just like the previous
> one (there are a few fixes that shouldn't affect the functionality in it), but
> please test it if you can.

I am happy to report that it works properly by only itself when applied to
a clean 2.6.35.4 tree. I haven't had any problems (aside from the "thoughtful
state" issue I mentioned above) with my 6 consecutive hibernation attempts.

> I think the slowdown you saw in 2) may be eliminated by increasing the
> image_size value, so I'm going to prepare a patch that will compute the
> value automatically during boot so that it's approximately 50% of RAM.

I would be glad to test that patch as well, to see if it brings speed-ups.
Actually, I might test hibernation with a larger value written to
/sys/power/image_size when I have time.

> 
> Thanks,
> Rafael

I really appreciate your help. Thanks a lot!

M. Vefa Bicakci

> [patch snipped]
