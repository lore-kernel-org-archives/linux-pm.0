From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: periodic wakeup
Date: Wed, 23 Sep 2015 03:26:17 +0200
Message-ID: <10308402.fOLRNmgkbM@vostro.rjw.lan>
References: <CANMsd01MpXbfxm5Lnba8eTJJXs8ac23ffCWC-4UB9jbaF9Jzjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53628 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752323AbbIWA6H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 20:58:07 -0400
In-Reply-To: <CANMsd01MpXbfxm5Lnba8eTJJXs8ac23ffCWC-4UB9jbaF9Jzjw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: linux-pm@vger.kernel.org

On Wednesday, September 23, 2015 04:15:30 AM Ryan wrote:
> Hi,
> 
> I want to measure the standby time of a device. The device goes to
> suspend. How can i make the device wake up periodically (every 15 mins
> or so) so that i can log the serial console prints to find out how
> much time the battery lasts.

Use the RTC wakealarm.

Thanks,
Rafael

