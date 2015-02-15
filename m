From: Bryan Henderson <bryanh@giraffe-data.com>
Subject: Re: battery drains after shutdown
Date: 15 Feb 2015 23:36:02 +0000
Message-ID: <72477.bryanh@giraffe-data.com>
References: <1423899504.11560.128.camel@rzhang1-mobl4>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from rhino.giraffe-data.com ([174.143.232.82]:54438 "EHLO
	rhino.giraffe-data.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbbBPAKB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 15 Feb 2015 19:10:01 -0500
In-reply-to: <1423899504.11560.128.camel@rzhang1-mobl4> (rui.zhang@intel.com)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: user.anti-spam@maison.homelinux.net, linux-pm@vger.kernel.org

I don't know much about power states in general, and I can't think of any
reason that any manipulation of the hardware clock would affect the power
state to which the computer shuts down.  This is probably more of a question
for an expert on shutdown.

I've heard of setting the clock disabling the wakeup, but not setting the
clock enabling wakeup.  I think you can determine whether this is happening,
though, by looking at /proc/driver/rtc contents before and after a
hwclock --systohc.

I do have one comment: doing hwclock --systohc at shutdown is almost always
the wrong thing to do; it is a custom that made sense 20 years ago, but not
today.

-- 
Bryan Henderson                                   San Jose, California
