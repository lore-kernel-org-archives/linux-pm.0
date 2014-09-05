From: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Subject: Re: External devices
Date: Fri, 5 Sep 2014 21:43:33 +0530
Message-ID: <CAGAs2A=nmNqMYNLvzPsBbysfV3LtkxJQzEpN+SZcL1cMVdMbmQ@mail.gmail.com>
References: <CAJ2oMhKRA+0Ge_m=-zFqgTxcZbuGMNAOvBQKP=_GyWRwvfsKFw@mail.gmail.com>
	<CAGAs2Amw1jvmDxL8+uXU4XW3u6Mxr7LKP4EiP8taTNQ2OpnWNw@mail.gmail.com>
	<CAJ2oMhL=wuWA3Ga4bdeqvW0QA-cccLA0BfVRDKyLuykyChqu7w@mail.gmail.com>
	<CAJ2oMhKnQczVwLhO0hHyJHCgc6UkV5g7sc3Gnnoq+ktUVYw+pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:56454 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaIEQNe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 12:13:34 -0400
Received: by mail-pd0-f178.google.com with SMTP id y13so16127467pdi.9
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2014 09:13:33 -0700 (PDT)
In-Reply-To: <CAJ2oMhKnQczVwLhO0hHyJHCgc6UkV5g7sc3Gnnoq+ktUVYw+pQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-pm@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>

> When adding some external device to power management, doesn't it need
> to belong to power domain  ( /debug/pm_debug/count ).

Power Domains are decided by system designer. A board can be divided
into multiple power domains which can be powered on/off or
voltage/current regulated independently as each power domain is
controlled by a power regulator.

> What is the power domain of external device ?
The right person to answer this question will be your system designer.
You may look into the board schematics to find out power regulator of
your external device. Each power domain is controlled by a power
regulator.

It is not necessary for you to consider power domains if you do not
wish to power up/down or regulate the voltage /current while running
Linux on the board. Another generic way to do runtime-power management
of various devices would be to perform clock scaling/gating (assuming
you know the clock domains of your system).
