From: Guru Prasad <gurupras@buffalo.edu>
Subject: Linux - Android power consumption in suspend
Date: Wed, 16 Oct 2013 11:40:17 -0400
Message-ID: <CAMefCkCAsuzQiHgX3wHj78ESL13SOU_=m4psohUtALTjbofh-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:44905 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab3JPPkS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2013 11:40:18 -0400
Received: by mail-ob0-f178.google.com with SMTP id uz6so719111obc.23
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2013 08:40:18 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

I'm currently trying to compare the overhead of running Android over
bare linux on the Nexus S.
Towards this, I've built a TINY_ANDROID image that I'm using to
compare against stock AOSP (4.1.1_r4).

I noticed a discrepancy in the power consumption while the phone is suspended.
stock AOSP consumes ~1.2mA when suspended, whereas TINY_ANDROID consumes ~9mA.

The one change that was made to stock AOSP was that it was set to
airplane mode which disables the radio.
Initially I believed that the TINY_ANDROID build still has the radio
turned on and this is leading to the increased current draw.

I then put together a quick hack of the samsung_modemctl driver
(drivers/misc/samsung_modemctl) where I replaced existing
IOCTL_MODEM_RESET with calls to
dpram_modem_pwroff(mc);
modem_off(mc);

I'm not sure if this is sufficient to ensure that the radio consumes
no power, but despite doing this, I notice that the device continues
to draw ~9mA.

>From my understanding, the Android platform automatically suspends (by
using echo mem >/sys/power/state I presume) when it sees that there
are no wakelocks of the SUSPEND type being held. If the user pushes
the power button, then I believe it forcibly releases wakelocks to try
and suspend (eventually).


Could someone shed some light on what I'm missing or doing incorrectly?


Thanks
