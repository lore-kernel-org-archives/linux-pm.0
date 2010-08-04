From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 16:39:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008041634560.6545__14489.269819069$1280965346$gmane$org@asgard.lang.hm>
References: <20100801210548.23f77ff6@infradead.org>
	<201008042231.51901.rjw@sisk.pl>
	<alpine.DEB.2.00.1008041600060.6545@asgard.lang.hm>
	<201008050126.20812.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008050126.20812.rjw@sisk.pl>
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
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel <linux-kernel@vger.kernel.org>, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Aug 2010, Rafael J. Wysocki wrote:

> On Thursday, August 05, 2010, david@lang.hm wrote:
>> On Wed, 4 Aug 2010, Rafael J. Wysocki wrote:
>>
>>> Subject: Re: Attempted summary of suspend-blockers LKML thread
>>>
>>> On Wednesday, August 04, 2010, david@lang.hm wrote:
>>>> On Wed, 4 Aug 2010, Rafael J. Wysocki wrote:
>>>>> In the suspend case, when you have frozen all applications, you can
>>>>> sequentially disable all interrupts except for a few selected ("wakeup") ones
>>>>> in a safe way.   By disabling them, you ensure that the CPU will only be
>>>>> "revived" by a limited set of events and that allows the system to stay
>>>>> low-power for extended time intervals.
>>>>
>>>> the benifit of this will depend on what wakeups you are able to avoid by
>>>> putting the hardware to sleep. Depending on the hardware, this may be not
>>>> matter that much.
>>>
>>> That's correct, but evidently it does make a difference with the hardware
>>> Android commonly runs on.
>>
>> Ok, but is there a way to put some of this to sleep without involving a
>> full suspend?
>
> Technically, maybe, but we have no generic infrastructure in the kernel for that.
> There may be SoC-specific implementations, but nothing general enough.

well, I know that we have specific cases of this (drive spin-down, cpu 
speed, display backlight for a few examples), is it worth trying to define 
a generic way to do this sort of thing? or should it be left as a 
per-device thing (with per-device knobs to control it)

I thought I had seen discussion on how to define such a generic power 
management interface, and I thought the results had been acceptable.


David Lang
