From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Freescale IMX6 active cooling
Date: Tue, 17 Nov 2015 13:53:17 +0530
Message-ID: <CAKohpokaTV0HqqpM9nG4OSscvcfuX6nz=sZaqqzDDy2O93E1xQ@mail.gmail.com>
References: <CABH3fy-He02iVU7FzqcPApPemeoqQP15+gr9+Hx87-OEBuHvCg@mail.gmail.com>
	<CABH3fy_KHmOWRDdLYO8_4vpXpD_dJTamDa4GVPY8nSbddgw+Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:36531 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbKQIXS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 03:23:18 -0500
Received: by iofh3 with SMTP id h3so11172689iof.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 00:23:17 -0800 (PST)
In-Reply-To: <CABH3fy_KHmOWRDdLYO8_4vpXpD_dJTamDa4GVPY8nSbddgw+Jw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Crenguta <catalin.crenguta@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Cc'ing Eduardo, as he can provide the most appropriate solution,

On 17 November 2015 at 11:42, Catalin Crenguta
<catalin.crenguta@gmail.com> wrote:
> I'm trying to use a GPIO Fan to cool down a Riotboard (I.MX6 Solo).

So, that's a cooling device.

> I've read [0], investigated the driver which provides the on-die
> temperature ( fsl,imx6q-tempmon [1]) but it seems to provide the
> temperature by creating a thermal zone (relevant dts: [2][3][4]).

That's right, on the other hand that driver also registers cpu-cooling
device as well..

> I don't know how I should proceed:
> 1) Should I research how can I attach a cooling device to this already
> existing thermal zone? (I believe it involves modifying the existing
> driver by adding new device tree handles)

Perhaps you need to write another cooling device driver for the gpio+fan
support. That will bind to the framework and to the thermal-zone as well.

Perhaps, there can be multiple cooling devices for the same thermal zone,
I am not sure how we pick only one of them at once, Eduardo can tell
better :)

--
viresh
