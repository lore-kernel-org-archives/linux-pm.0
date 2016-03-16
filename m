From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Thu, 17 Mar 2016 00:24:57 +0100
Message-ID: <CAJZ5v0i=7Sz17yr1_1fLiJq6oWRDRHOFukkzn3N=y3empshVGw@mail.gmail.com>
References: <20160316150053.GG6980@mtj.duckdns.org>
	<Pine.LNX.4.44L0.1603161127020.2250-100000@iolanthe.rowland.org>
	<CAJZ5v0j4DGEiKzKwnw4vc2gD-6XXKt2H656Q1kGrRD==y-s5Fw@mail.gmail.com>
	<20160316163554.GK6980@mtj.duckdns.org>
	<CAJZ5v0i=BUSGx6ZKMS8QFeO6ybhbqekzBY+qV2Gn01yTw2DcWg@mail.gmail.com>
	<alpine.LNX.2.00.1603170017280.3656@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33842 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933155AbcCPXZL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 19:25:11 -0400
Received: by mail-lf0-f49.google.com with SMTP id e138so29357673lfe.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 16:24:58 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1603170017280.3656@cbobk.fhfr.pm>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, Mar 17, 2016 at 12:18 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 16 Mar 2016, Rafael J. Wysocki wrote:
>
>> > That's what we're doing now.  What I'm suggesting is that we should be
>> > plugging the point where they come together instead of the sources of
>> > which there can be many.  Freezing does block a lot of those sources
>> > but not all.
>>
>> Well, is there any point where they come together?  Say somebody
>> communicates with user space over mmaped address range and writes to
>> that go to hardware.  What do we do then?
>
> There are no more writes happening to that region after userspace has been
> frozen. And we're definitely not getting rid of userspace freezing.
>
> Or have I missed the point of your question?

I thought Tejun was talking about getting rid of userspace freezing.
Sorry if that was not the case.

As I've already said for multiple times, I think that the freezing
should really be limited to user space as a rule.  And in particular,
if freezing of any kernel threads or workqueues etc causes problems to
happen, the code using those freezable things is simply buggy and
needs to be fixed.  Most likely by getting rid of the freezing from
it.
