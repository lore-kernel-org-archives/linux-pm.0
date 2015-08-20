From: Yan Pashkovsky <yanpaso@gmail.com>
Subject: API for querying the resume cause
Date: Thu, 20 Aug 2015 14:47:55 +0300
Message-ID: <55D5BE6B.5070805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:33981 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbbHTLr5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2015 07:47:57 -0400
Received: by laba3 with SMTP id a3so20854558lab.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2015 04:47:56 -0700 (PDT)
Received: from [10.0.2.127] (broadband-5-228-84-134.nationalcablenetworks.ru. [5.228.84.134])
        by smtp.googlemail.com with ESMTPSA id pr2sm1151640lbb.4.2015.08.20.04.47.55
        for <linux-pm@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2015 04:47:55 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Dear developers,

My name is Yan and I was redirected here from kernel bugzilla
(bugzilla.kernel.org/show_bug.cgi?id=102991). I would like to discuss
API for supporting delayed hibernation.

Original post:

     Please add API for querying the resume cause
     The purpose of this API - is support of delayed hibernation (feature
     that works for a long time in Windows). A laptop first Suspend to
     RAM, then after a time save state to disk and power off completely.
     But system must know the reason of waking up (was it user or turning
     into hibernation). RTC wakeup event isn't reliable.
     SystemD needs such API, see more at
     github.com/systemd/systemd/issues/926


I was discussing it earlier with Lennart Poettering, he said he can't
rely on rtc timer, he needs some API.
Lennart(github.com/systemd/systemd/issues/926):

     On Linux we have no API for querying the resume cause. Patching
     around this sounds like a gigantic hack... Especially as RTC-based
     wakeups are not really reliable on many systems... On such systems
     where the RTC wakeup is missed and the user resumes the machine
     manually later on the system will immediately go to hiberantion,
     which is clearly not a good idea.

     Sorry, but I am really not convinced this could be any more than a
     gigantic hack.

     Please before looking into something like this, let's at least get a
     proper API into the kernel that reports the precise wakeup reason to
     userspace. If we have that, then we can consider hooking this up
     from userspace. Will close this for now, as I don't think we should
     hack something up like this without proper kernel support for such a
     logic.


PS I use mailing list system for the first time. Am I to subscribe to it
somewhere? Will feedback be delivered to my email address after sending
this email, without any actions?

King regards,
Yan
