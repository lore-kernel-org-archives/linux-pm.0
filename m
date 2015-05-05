From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Wed, 6 May 2015 01:51:49 +0200
Message-ID: <CAJZ5v0h0w9YDT+1pESxw2tNbA+=Sdg0WE82E5UPSDZPcxA=vbQ@mail.gmail.com>
References: <CAJFHJrp=h=jxSNLTyszYs3Ac3PoZKFy-dVJXLehO36r-4p-8=w@mail.gmail.com>
	<Pine.LNX.4.44L0.1505051532000.1639-100000@iolanthe.rowland.org>
	<CAJFHJrpFAvQ7zZMj-Ap6rYU24Gy0fwca6WqqNSg6-rrS0mxASA@mail.gmail.com>
	<1524218.bZcVRu7XR6@vostro.rjw.lan>
	<alpine.DEB.2.02.1505051634140.2429@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36024 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbbEEXvv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2015 19:51:51 -0400
In-Reply-To: <alpine.DEB.2.02.1505051634140.2429@nftneq.ynat.uz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Lang <david@lang.hm>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Chirantan Ekbote <chirantan@chromium.org>, Alan Stern <stern@rowland.harvard.edu>, John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, May 6, 2015 at 1:38 AM, David Lang <david@lang.hm> wrote:
> On Wed, 6 May 2015, Rafael J. Wysocki wrote:
>
>>> You are, of course, correct.  Ultimately the only requirement we have
>>> is that there exists a way for userspace to determine if the system
>>> woke up because of a user-triggered event.  The actual mechanism by
>>> which this determination is made isn't something I feel strongly
>>> about.  The reason I had been focusing on exposing the actual wakeup
>>> event to userspace is because classifying wakeup events as
>>> user-triggered or not feels to me like a policy decision that should
>>> be left to userspace.  If the kernel maintainers are ok with doing
>>> this work in the kernel instead and only exposing a binary yes/no bit
>>> to userspace for user-triggered wakeups, that's perfectly fine because
>>> it still meets our requirements.
>>
>>
>> Well, please see the message I've just sent.
>>
>> All wakeup devices have a wakeup source object associated with them.  In
>> principle, we can expose a "priority" attribute from that for user space
>> to
>> set as it wants to.  There may be two values of it, like "normal" and
>> "high"
>> for example.
>>
>> Then, what only remains is to introduce separate wakeup counts for the
>> "high"
>> priority and "normal" priority wakeup sources and teach the power manager
>> to
>> use them.
>>
>> That leaves no policy in the kernel, but it actually has a chance to work.
>
>
> how about instead of setting two states and defining that one must be a
> subset of the other you instead have the existing feed of events and then
> allow software that cares to define additional feeds that take the current
> feed and filter it. We allow bpf filters in the kernel, so use those to
> filter what events the additional feed is going to receive.
>
> remember that the interesting numbers in CS are 0, 1, and many, not 2 :-)
>
> don't limit things to two feeds with one always being a subset of the other,
> create a mechanism to allow an arbitrary number of feeds that can be
> filtered in different ways

In my example above "high" is not a subset of "normal".  They are
separate sets.  Each of them is a subset of the set of all wakeup
sources, but that's obvious.

And yes, you can create more of them, but then you'll need an
interface to manipulate them which will probably be overkill for the
use case at hand.

Do you envision a use case where more than two sets would be necessary?

Rafael
