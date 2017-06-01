From: Martin Steigerwald <martin@lichtvoll.de>
Subject: [REGRESSION] [4.11/4.12-rc3] Hang on Suspend to RAM
Date: Thu, 01 Jun 2017 11:43:43 +0200
Message-ID: <748157628.hqj47iI04h@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:60829 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdFAJvv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2017 05:51:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hello.

I live with that linux kernels since about 2-3 years at least or even longer 
occasionally hang on hibernation to disk on this ThinkPad T520 with 
Sandybridge. It happens so rarely and if usually leaves me without any easy 
way to gather any debug information, that I just put up with it. The hang is 
as follows: Power LED of ThinkPad T520 dims on and off like it does during a 
hibernation or suspend cycle. Screen is black. And thats it. Sometimes it 
eventually completed the process after a few minutes, but usually it is stuck 
there for 10 minutes or more and I give up waiting then. Actually maybe even 
it was with Nigel Cunningham´s Tux On Ice when hibernation worked reliably. I 
remember uptimes of 100-200 days for some old workstation and even my laptop 
back then made 40 days or more. I never see this with any kind of somewhat 
recent kernel on my current laptop.

Since 4.11 I have it quite often that a hang like this even happens on suspend 
to RAM (standby) as well. And even quite often about 1 time of of 2-3 suspend 
attempts. The hang symptoms are similar. Power LED dims on and off. Screen is 
black.

Since this is my holidays and this again does not happen all of the time and 
thus would be considerable effort to bisect, I think I am out here now. Unless 
you have something I can test easily.

It seems I am much better off with opting out out of kernel testing as I tend 
to usually get the nasty "I hang and I won´t tell you any hint as about why I 
do so and do so only sometimes" kind of bugs that are too much effort for me 
to provide any usable debug information about.

At least the most nasty i915 bugs in 4.9 and 4.10 seem to be gone meanwhile – 
will close my reports about them today. So maybe I look back at 4.11 and 4.12 
with ten or more stable releases. Seems current release candidates and even 
releases by Linus are just to unstable for me to bear with. Which hints at a 
lack of testing… but then testing for me (and quite some others?) just seems 
to be too much of an hassle and effort…

so draw your own conclusions from there.

I still wanted to provide feedback on these quality issues, as no feedback can 
easily be interpreted as "works correctly".

If you have any idea of useful information I can provide to you *easily* and 
in a *short amount of time*, then feel free to share it. I have holidays 
tough, so I am especially picky about the easily and short amount of time 
part. 

Switching back to 4.10, last known working kernel, now.

Thanks,
-- 
Martin
