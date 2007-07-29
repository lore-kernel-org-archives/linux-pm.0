From: david@lang.hm
Subject: Re: Power Management framework proposal
Date: Sun, 29 Jul 2007 15:00:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707291456460.15835__46191.2993844182$1185746645$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185125189.2714.13.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707221130380.6350@asgard.lang.hm>
	<1185143240.2714.24.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707221946170.6350@asgard.lang.hm>
	<1185163239.2714.37.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707222105310.6350@asgard.lang.hm>
	<20070727114637.GC11895@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070727114637.GC11895@ucw.cz>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 27 Jul 2007, Pavel Machek wrote:

> Hi!
>
>>>> example 1: a laptop screen
>>>>
>>>> mode  capacity power description
>>>> 0        0        0    off
>>>> 1      100      100    full brightness
>>>> 2       70       60    half power to the backlight
>>>> 3       50       35    quarter power to the backlight
>>>> 4       30       25    eighth power to the backlight
>>>> 5        5       10    backlight off.
>>>>
>>>> example 2: a front-panel display on a server (no
>>>> variable backlight
>>>> control)
>>>>
>>>> mode capacity power description
>>>> 0       0        0   off
>>>> 1     100      100   backlight on
>>>> 2      50       10   backlight off
>>>
>>>
>>> the problem is: the person who SETS these needs to know
>>> what they mean.
>>
>> that's what the description is for. this info can be
>> provided by the driver as part of the list_modes()
>> function.
>
> That's what /sys/class/backlight/ is for :-).

yes it is, and each type of device is growing it's own, incompatible, 
interfaces for controlling things like this. I was aiming to do two 
things.

1. head this off and try and get a more common api

2. simplify the confusion that there is with multiple functions needing to 
be implemented during the suspend/resume cycle by chaning them from 
independant suspend-only functions to being just part of the device 
settings

>>> as someone who wrote (part of) a power policy manager;
>>> sorry but you
>>> take away information I need, and in addition the
>>> different API's are
>>> absolutely no big deal.
>>
>> assuming that nobody else chimes in to disagree with you
>> I'll accept your judgement and drop the issue.
>
> Just for the record, I agree with Arjan here.

oh well. sorry to take up everyone's time.

David Lang
