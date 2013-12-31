From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: how to know how long it takes on suspend/resume for platform
 usb driver
Date: Tue, 31 Dec 2013 12:24:05 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1312311217470.4169-100000@netrider.rowland.org>
References: <CANudz+v2LP5nUYa8gosm_sXdin7C4R3kP7xBT0C61yd2Zsd6mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:39306 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753931Ab3LaRYH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 Dec 2013 12:24:07 -0500
In-Reply-To: <CANudz+v2LP5nUYa8gosm_sXdin7C4R3kP7xBT0C61yd2Zsd6mQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: loody <miloody@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Tue, 31 Dec 2013, loody wrote:

> hi all:
> I am implementing platform layer suspend/resume usb driver.
> Is there kernel configuration or module parameter I can used to
> calculate suspend/resume time spend?

Turn on CONFIG_PM_SLEEP_DEBUG, and before starting your test, do

	echo 1 >/sys/power/pm_print_times

Alan Stern

