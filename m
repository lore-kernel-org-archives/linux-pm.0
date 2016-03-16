From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Thu, 17 Mar 2016 00:48:04 +0100
Message-ID: <CAJZ5v0i1=jE=ek7hxSo7923ABmyxu-0Xe7YuF6m6qss=EPH0Fw@mail.gmail.com>
References: <20160316150053.GG6980@mtj.duckdns.org>
	<Pine.LNX.4.44L0.1603161127020.2250-100000@iolanthe.rowland.org>
	<CAJZ5v0j4DGEiKzKwnw4vc2gD-6XXKt2H656Q1kGrRD==y-s5Fw@mail.gmail.com>
	<20160316163554.GK6980@mtj.duckdns.org>
	<CAJZ5v0i=BUSGx6ZKMS8QFeO6ybhbqekzBY+qV2Gn01yTw2DcWg@mail.gmail.com>
	<alpine.LNX.2.00.1603170017280.3656@cbobk.fhfr.pm>
	<CAJZ5v0i=7Sz17yr1_1fLiJq6oWRDRHOFukkzn3N=y3empshVGw@mail.gmail.com>
	<alpine.LNX.2.00.1603170036310.3656@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35757 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755678AbcCPXsG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 19:48:06 -0400
Received: by mail-lf0-f43.google.com with SMTP id v130so3767348lfd.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 16:48:05 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1603170036310.3656@cbobk.fhfr.pm>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, Mar 17, 2016 at 12:42 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Thu, 17 Mar 2016, Rafael J. Wysocki wrote:
>
>> >> Well, is there any point where they come together?  Say somebody
>> >> communicates with user space over mmaped address range and writes to
>> >> that go to hardware.  What do we do then?
>> >
>> > There are no more writes happening to that region after userspace has been
>> > frozen. And we're definitely not getting rid of userspace freezing.
>> >
>> > Or have I missed the point of your question?
>>
>> I thought Tejun was talking about getting rid of userspace freezing.
>> Sorry if that was not the case.
>
> Oh, I definitely belive that the current "holy grail" is to get rid of
> ktrehad / kernel code freezing. Userspace is a completely different story,
> I agree.
>
>> As I've already said for multiple times, I think that the freezing
>> should really be limited to user space as a rule.  And in particular, if
>> freezing of any kernel threads or workqueues etc causes problems to
>> happen, the code using those freezable things is simply buggy and needs
>> to be fixed.  Most likely by getting rid of the freezing from it.
>
> I am (slowly) working towards this goal. First I am trying to make sure
> that all the kernel is using the kthread freezing API in a well-defined
> way (which is currently not the case at all).
>
> Before this is done, it is more or less impossible to analyse the current
> users and make any decisions on top of that.
>
> Once some kind of analysis is possible, I am pretty sure that we'll be
> able to get rid of most kthread freezing by introducing fs freezing during
> suspend (and fixing a lot of currently existing bugs as a nice
> side-effect), and perhaps eventually ditch the kthread freezer altogether.

Sounds good! :-)
