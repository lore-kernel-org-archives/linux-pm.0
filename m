From: david@lang.hm
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec
 based hibernation
Date: Wed, 18 Jul 2007 20:30:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707182026130.19248__35862.2296866544$1184816398$gmane$org@asgard.lang.hm>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070718180420.02352d4f.akpm@linux-foundation.org>
	<200707191215.05245.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707191215.05245.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@suspend2.net
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, 19 Jul 2007, Nigel Cunningham wrote:

> Hi.
>
> On Thursday 19 July 2007 11:04:20 Andrew Morton wrote:
>> On Sun, 15 Jul 2007 15:13:13 +0800
>> "Huang, Ying" <ying.huang@intel.com> wrote:
>>
>>>
>>> The changelog between v1 and v2
>>>
>>> 1. The kexec jump implementation is put into the kexec/kdump
>>>    framework instead of software suspend framework. The device
>>>    and CPU state save/restore code of software suspend is called
>>>    when needed.
>>>
>>> 2. The same code path is used for both kexec a new kernel and jump
>>>    back to original kernel.
>>
>> I like the idea but I think I'll let people chat about it a bit more
>> before looking at merging the patches, OK?
>
> Please wait until you see a complete implementation that actually works. I'm
> sitting here quietly, following (and now breaking) the "If you can't say
> anything positive, don't say anything at all" line because I think that the
> more into the implementation details people get, the uglier this is going to
> show itself to be. I'm perfectly willing to be proven wrong, but haven't seen
> anything so far that's even begun to convince me otherwise.

as someone who's eager to have this work, I have to agree with Nigel that 
it's premature to talk about merging anything.

the only exception I could see is if there are other uses for this 
functionality. but even then, let things settle out a little bit.

David Lang
