From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Wed, 16 Mar 2016 17:39:30 +0100
Message-ID: <CAJZ5v0i=BUSGx6ZKMS8QFeO6ybhbqekzBY+qV2Gn01yTw2DcWg@mail.gmail.com>
References: <20160316150053.GG6980@mtj.duckdns.org>
	<Pine.LNX.4.44L0.1603161127020.2250-100000@iolanthe.rowland.org>
	<CAJZ5v0j4DGEiKzKwnw4vc2gD-6XXKt2H656Q1kGrRD==y-s5Fw@mail.gmail.com>
	<20160316163554.GK6980@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34315 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652AbcCPQjc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 12:39:32 -0400
Received: by mail-lb0-f171.google.com with SMTP id k12so51645133lbb.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 09:39:31 -0700 (PDT)
In-Reply-To: <20160316163554.GK6980@mtj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, florian@mickler.org, jkosina@suse.cz, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Wed, Mar 16, 2016 at 5:35 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Rafael.
>
> On Wed, Mar 16, 2016 at 05:31:23PM +0100, Rafael J. Wysocki wrote:
>> Essentially, every device interface that might be accessed by user
>> space would have to be intercepted somehow.
>
> That's what we're doing now.  What I'm suggesting is that we should be
> plugging the point where they come together instead of the sources of
> which there can be many.  Freezing does block a lot of those sources
> but not all.

Well, is there any point where they come together?  Say somebody
communicates with user space over mmaped address range and writes to
that go to hardware.  What do we do then?

Thanks,
Rafael
