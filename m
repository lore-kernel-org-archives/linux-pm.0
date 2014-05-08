From: Ryan <ryanphilips19@googlemail.com>
Subject: powertop usage
Date: Fri, 9 May 2014 00:35:45 +0530
Message-ID: <CANMsd02rYJpqVf72Yn7R9kHyZhNuYhvRLeY0e27jTfAhhr62gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:61009 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094AbaEHTFq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 May 2014 15:05:46 -0400
Received: by mail-qa0-f43.google.com with SMTP id m5so2955605qaj.16
        for <linux-pm@vger.kernel.org>; Thu, 08 May 2014 12:05:46 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,

I am trying to use powertop to find out what is causing wakeups.

Have 3 columns
usage, events/second and description

Can i have something like this:
<run powertop for 1 min> and play "usage scenerio" (a game) in the background
But, powertop values keep changing every second.

Is there a way of finding out what all things caused wakeups for the 1
min duration
and not for a second (which keeps changing)

Is this the way - Powertop is used?

Also, what does usage and events/second suggest. can anyone describe
with a example and how it can be used to debug and identify issues.

i see any "timers" in description - why is this?
and why dont i get complete kworker details ( I see only something called kwork)
in the description i cant find out which kworker is waking up so much.

Thanks,
Ryan
