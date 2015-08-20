From: Yan Pashkovsky <yanpaso@gmail.com>
Subject: Re: API for querying the resume cause
Date: Fri, 21 Aug 2015 00:44:44 +0300
Message-ID: <55D64A4C.5000604@gmail.com>
References: <55D5BE6B.5070805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:36279 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbbHTVor (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2015 17:44:47 -0400
Received: by lagz9 with SMTP id z9so30665226lag.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2015 14:44:46 -0700 (PDT)
Received: from [10.0.2.127] (broadband-5-228-84-134.nationalcablenetworks.ru. [5.228.84.134])
        by smtp.googlemail.com with ESMTPSA id m7sm1610632laf.35.2015.08.20.14.44.45
        for <linux-pm@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2015 14:44:45 -0700 (PDT)
In-Reply-To: <55D5BE6B.5070805@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi, I have subscribed to linux-pm@lists.linux-foundation.org and 
Majordomo@vger.kernel.org (linux-pm). I've written you earlier, hope you 
received my message. I haven't received any replies, so I send this 
message again, cause I think my message was declined.

20.08.2015 14:47, Yan wrote you:
 > Dear developers,
 >
 > My name is Yan and I was redirected here from kernel bugzilla
 > (bugzilla.kernel.org/show_bug.cgi?id=102991). I would like to discuss
 > API for supporting delayed hibernation.
 >
 > Original post:
 >
 >     Please add API for querying the resume cause
 >     The purpose of this API - is support of delayed hibernation (feature
 >     that works for a long time in Windows). A laptop first Suspend to
 >     RAM, then after a time save state to disk and power off completely.
 >     But system must know the reason of waking up (was it user or turning
 >     into hibernation). RTC wakeup event isn't reliable.
 >     SystemD needs such API, see more at
 >     github.com/systemd/systemd/issues/926
 >
 >
 > I was discussing it earlier with Lennart Poettering, he said he can't
 > rely on rtc timer, he needs some API.
 > Lennart(github.com/systemd/systemd/issues/926):
 >
 >     On Linux we have no API for querying the resume cause. Patching
 >     around this sounds like a gigantic hack... Especially as RTC-based
 >     wakeups are not really reliable on many systems... On such systems
 >     where the RTC wakeup is missed and the user resumes the machine
 >     manually later on the system will immediately go to hiberantion,
 >     which is clearly not a good idea.
 >
 >     Sorry, but I am really not convinced this could be any more than a
 >     gigantic hack.
 >
 >     Please before looking into something like this, let's at least get a
 >     proper API into the kernel that reports the precise wakeup reason to
 >     userspace. If we have that, then we can consider hooking this up
 >     from userspace. Will close this for now, as I don't think we should
 >     hack something up like this without proper kernel support for such a
 >     logic.
 >
 >
 > PS I use mailing list system for the first time. Am I to subscribe to it
 > somewhere? Will feedback be delivered to my email address after sending
 > this email, without any actions?
 >
 > King regards,
 > Yan
