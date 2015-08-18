From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [Device-mainlining] [PATCH v2 2/3] gadget: Introduce the usb
 charger framework
Date: Tue, 18 Aug 2015 09:43:50 +0800
Message-ID: <CAMz4kuLke8NdagVhU7VLHcYAYW3c7S--NQyvMjzJ7FLd+QVrHA@mail.gmail.com>
References: <cover.1439519412.git.baolin.wang@linaro.org>
	<0c41e21239f69c4e1aa89aba020c91edfc17c4e8.1439519413.git.baolin.wang@linaro.org>
	<20150814152723.GA17892@kroah.com>
	<CAMz4kuL=6mGjNHcKHA9RYbabYqn3Lgu=rK6s8WkH5YGeV1T2+w@mail.gmail.com>
	<55D1FCDF.6060709@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55D1FCDF.6060709-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Bird <tim.bird-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sojka-Knnw/vAvyUalVyrhU4qvOw@public.gmane.org" <sojka-Knnw/vAvyUalVyrhU4qvOw@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, "yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 17 August 2015 at 23:25, Tim Bird <tim.bird-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org> wrote:
>
>
> On 08/16/2015 08:03 PM, Baolin Wang via device-mainlining wrote:
>> On 14 August 2015 at 23:27, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
>>> On Fri, Aug 14, 2015 at 05:47:45PM +0800, Baolin Wang wrote:
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License as published by
>>>> + * the Free Software Foundation; either version 2 of the License, or
>>>> + * (at your option) any later version.
>>>
>>> I have to ask, do you really mean "any later version"?
>>>
>>
>> I think I did not get your point, could you explain it detailedly?
>
> The full kernel is licensed under v2 of the GPL only, not "any later version".
> See the second paragraph at the top of the COPYING file in the root directory
> of the kernel source tree. There are differences on individual files, but
> having this file allow "any later version" makes it different from much of
> rest of the kernel.
>
> Unless you have a specific reason to allow greater-than-V2 GPL licensing on this
> file, you should change the licensing clause.  The following wording appears
> to be pretty popular:
>
> * This program is free software; you can redistribute it and/or modify
> * it under the terms of the GNU General Public License version 2 as
> * published by the Free Software Foundation.
>

Hi Tim,

Make sense of it. Thanks for your explanation.

>   -- Tim



-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
