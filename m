From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Sun, 15 Jul 2007 16:33:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707151627270.25614__41839.8064830855$1184542894$gmane$org@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707151239.28400.rjw@sisk.pl>
	<Pine.LNX.4.64.0707151224160.25614@asgard.lang.hm>
	<200707160111.16805.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707160111.16805.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Jul 2007, Rafael J. Wysocki wrote:

> On Sunday, 15 July 2007 21:33, david@lang.hm wrote:
>> On Sun, 15 Jul 2007, Rafael J. Wysocki wrote:
>>
>>> On Saturday, 14 July 2007 23:34, david@lang.hm wrote:
>>>> On Sat, 14 Jul 2007, Rafael J. Wysocki wrote:
>>>>
>>>>> On Saturday, 14 July 2007 09:51, david@lang.hm wrote:
>>>>>> On Fri, 13 Jul 2007, Rafael J. Wysocki wrote:
>>>>>>
>>>>>>>> since people are complaining about the amount of ram that a kexec kernel
>>>>>>>> would take up I'm assuiming it's somethingmore complex then just a bitmap
>>>>>>>> of all possible pages.
>>>>>>>
>>>>>>> No, it's just bitmaps, AFAICS, and the complaints are a bit overstated, IMO. ;-)
>>>>>>
>>>>>> 1 bit for each 4k means 1m bits for 4g of ram, or 128k of bitmaps, growing
>>>>>> up to 1m of ram used for 32G of ram in the system. I guess this isn't bad
>>>>>> as long as it doesn't need to be contiguous for the new kernel to access
>>>>>> it.
>>>>>>
>>>>>> ok, that makes it a pretty trivial thing to work with. I just need to
>>>>>> learn how to find the bitmaps.
>>>>>
>>>>> They are created on the fly before the hibernation.  The format is described in
>>>>> kernel/power/snapshot.c .
>>>>
>>>> I'll look through this file, but the format of this is an abi/api to the
>>>> userspace and should be documented outside of the code.
>>>
>>> Nope.  The user space need not know anything about the image contents.
>>>
>>> The current implementation of the user space tools use the knowledge of the
>>> image header format, which is given by 'struct swsusp_info', defined in
>>> kernel/power/power.h .
>>
>> there are a couple factors here.
>>
>> 1. this needs to remain the same across different kernel versions.
>
> Not exactly.  Whatever is after the image header may change at any time and
> the user space should not rely on that not changing.  The header itself is a
> (slightly) different matter.

ok, more precisely

an image of one kernel version should be able to be fed into /dev/snapshot 
of another kernel version and work.

that's what I was meaning about it needing to be the same across different 
kernel versions

>> 2. this may or may not be created by userspace tools
>
> Well, the image header is not created by userspace tools and only read the
> image size from it.

it's not today, but maby it should be.

in the kexec approach there's nothing happening here that a perl script 
couldn't do perfectly well. it's reading a bitmap from somewhere, and 
based on that bitmap it creates a header and then reads chunks from 
/dev/oldmem or /dev/mem and writes the results somewhere (to a device, or 
a network or a userspace compress program, or ...)

>> both of these tend to imply that this is an interface to the world and
>> needs to be documented and stable.
>
> Well, it should be documented, but currently there's only one implementation
> of the userland tools and the authors of these know the format. ;-)

true today, but as the pieces get simplified and documented other 
implementations could exist.

David Lang
