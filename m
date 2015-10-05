From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 01/17] rtc: pl031: remove misuse of IRQF_NO_SUSPEND flag
Date: Mon, 5 Oct 2015 10:49:01 +0200
Message-ID: <CACRpkdYURqgeh9kzED7yvwgR29qUPd9KgxrTAXZkAUdXazoJLA@mail.gmail.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
	<1442850433-5903-2-git-send-email-sudeep.holla@arm.com>
	<CACRpkdaa+J76vMGHrZsTZukUS-VyDQFPqwg6teV=m050a=P8Pg@mail.gmail.com>
	<560E603E.8080603@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36673 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbbJEItC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 04:49:02 -0400
Received: by obcgx8 with SMTP id gx8so123197295obc.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2015 01:49:01 -0700 (PDT)
In-Reply-To: <560E603E.8080603@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>

On Fri, Oct 2, 2015 at 12:45 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

>> Looks correct to me.
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks, while you are at it, do you know what interrupt stv2_pl031
> shares so that I can fix the TODO in the comment or the code(whichever
> applicable).

This is shared with a hardware called RTT (real-time timer) that has
no upstream driver as of now.

Yours,
Linus Walleij
