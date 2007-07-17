From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Mon, 16 Jul 2007 21:37:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707162134040.19248@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707161045520.3410-100000@iolanthe.rowland.org>
	<200707161951.35225.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707161951.35225.a1426z@gawab.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Jul 2007, Al Boldi wrote:

> Alan Stern wrote:
>> On Mon, 16 Jul 2007, Al Boldi wrote:
>>> From a kexec'd hibernation kernel pov, both S3 and S4 look conceptually
>>> exactly the same.  The only difference is, in S3 the memory is in memory
>>> and in S4 the memory is on storage.  All device handling is exactly the
>>> same, so if there is a problem with device handling between the kexec'd
>>> hibernation kernel and the normal kernel, then that would have made
>>> itself visible.
>>
>> You have contradicted yourself.  "In S3 the memory is in memory and in
>> S4 the memory is on storage".  How does the memory get onto storage?
>> The kexec'd hibernation kernel writes it there.  To do so it accesses a
>> storage device.
>>
>> Consequently the device handling _cannot_ be exactly the same in S3 and
>> S4.
>
> Ok, you should have read this in the context of suspending/resuming from/to
> the normal kernel, and in that case they are exactly the same, i.e. kexec -e
> for suspend and kexec -j for resume.
>
> BTW, it would be really helpful if people would actually try the kexec
> hibernation patches, as this may yield a much more constructive discussion.

I would love to, but so far I don't see the nessasary pieces

once I kexec to the new kernel, how can it find out what pages of memory 
(and swap) need to be saved?

If i knew that then I could write a trivial perl program to save those 
pages with the appropriate headers to make a suspend file.

however, I'm now being told that that suspend file won't work if the 
machine is actually powered off, so there's a need to something more for 
the wake-up side of things as well.

David Lang
