From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: thermal: uevent/netlink with step_wise?
Date: Thu, 2 Apr 2015 05:28:47 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB590912D402@BGSMSX101.gar.corp.intel.com>
References: <20150331224348.GZ32500@ld-irv-0074>
 <20150401211718.GA32500@ld-irv-0074>
 <4D68720C2E767A4AA6A8796D42C8EB590912C2CD@BGSMSX101.gar.corp.intel.com>
 <20150402051100.GF19571@brian-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49219 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828AbbDBFaX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 01:30:23 -0400
In-Reply-To: <20150402051100.GF19571@brian-ubuntu>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>

>-----Original Message-----
>From: Brian Norris [mailto:computersforpeace@gmail.com]
>Sent: Thursday, April 2, 2015 10:41 AM
>To: R, Durgadoss
>Cc: linux-pm@vger.kernel.org; Brown, Len; Lukasz Majewski; Eduardo Valentin; Zhang, Rui
>Subject: Re: thermal: uevent/netlink with step_wise?
>
>Hi Durga,
>
>On Thu, Apr 02, 2015 at 04:28:16AM +0000, R, Durgadoss wrote:
>> >-----Original Message-----
>> >From: Brian Norris [mailto:computersforpeace@gmail.com]
>> >Sent: Thursday, April 2, 2015 2:47 AM
>> >To: linux-pm@vger.kernel.org
>> >Cc: R, Durgadoss; Brown, Len; Lukasz Majewski; Eduardo Valentin
>> >Subject: Re: thermal: uevent/netlink with step_wise?
>> >
>> >On Tue, Mar 31, 2015 at 03:43:48PM -0700, Brian Norris wrote:
>> >> Particularly, I'm looking right now at using the uevent/netlink
>> >> notification mechanism. It seems that this is only active when we use
>> >> the 'user_space' governor, meaning I can't get any user-space
>> >> notifications when using the in-kernel governor. Am I missing something,
>> >> or is this a known limitation? Is there any reason we can't enable both?
>>
>> When we use an in-kernel governor, we expect that the governor takes care of
>> all the required throttling etc. Hence, we did not add notification for
>> in-kernel governors.
>>
>> And we let the user space decide the actions when user space governor
>> is selected and this requires notification.
>
>OK, thanks for the explanation. I guess that matches my reading of the
>code.
>
>> That said,
>> I do not think we have a hard rule saying we should not notify
>> User space in in kernel governors. I think you can add it in your
>> driver if you need it..
>
>OK. I suppose I may do that if I decide I need that. But if I'm going to
>be doing other general thermal management aspects from user space, I may
>just defer entirely to user-space instead, and ignore the in-kernel
>governor. I'm now trying to determine if there are many (any?) downsides
>to that.

AFAIK, there are no downsides. You can very well do that..

Thanks,
Durga

>
>> >> For the user-space side, I'd mostly be interested in being a consumer;
>> >> e.g., display warnings in high-temperature scenarios; although I might
>> >> also use it to trigger some user-space cooling mechanisms.
>> >
>> >I'm noticing two additional interesting details.
>> >
>> >1. There's a separate netlink event mechanism that has never been used.
>> >See generate_netlink_event(), from this commit:
>> >
>> >commit 4cb18728709683c91a5f6f8d5f337bfb498b089a
>> >Author: R.Durgadoss <durgadoss.r@intel.com>
>> >Date:   Wed Oct 27 03:33:29 2010 +0530
>> >
>> >    thermal: Add event notification to thermal framework
>>
>> This netlink notification was added much before we had the
>> UEvent reporting.
>
>Right, it looked that way.
>
>> Once we had UEvent reporting, We even
>> discussed about removing this one. Afraid of breaking any
>> user space depending on this, we have not done that.
>
>But no one calls this function, so how would it break user space? Or is
>Intel maintaining a body of out-of-tree code that uses this?
>
>Thanks for your comments.
>
>Brian
