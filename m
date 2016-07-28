From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [query]suspend failed when working together with rpm
Date: Thu, 28 Jul 2016 16:48:57 +0200
Message-ID: <1623045.Fc7rGHkFpD@vostro.rjw.lan>
References: <CAN2waFtdKaqRhrMkgAuYpRryc+5hnfiPSOmwq97aH0cRkHwkRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47960 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758655AbcG1Onx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2016 10:43:53 -0400
In-Reply-To: <CAN2waFtdKaqRhrMkgAuYpRryc+5hnfiPSOmwq97aH0cRkHwkRA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@linaro.org>

On Thursday, July 28, 2016 05:55:36 PM Zhaoyang Huang wrote:
> Hi folks,
> I run across a bug where the xhci_suspend failed and caused kernel
> panic[1] when suspend.
> 
> According to our USB engineer, it is because usb host has been
> disabled(power down?) by its rpm functions, while the suspend_ops
> operate it again when suspend. It is can be reproduced by 'echo mem >
> /sys/power/state' to a console under kernel4.4.
> 
> I want to know if it is a bug or not and how should we sync between
> suspend and rpm ops in one device? Thank you!

There is a bug somewhere, but I'm not sure where it is at this point.

If the host was suspended before system suspend, it either should be
resumed during the "prepare" phase, or its ->prepare callback should
return a positive value (meaning "skip that device going forward"
roughly), or its own PM callbacks should be able to deal with this
situation.

Thanks,
Rafael

