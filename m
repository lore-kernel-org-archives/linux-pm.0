From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCHv v3] power: Include additional information in pm_print_times
Date: Tue, 18 Jun 2013 14:54:57 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E6172A0CB@sisaex02sj>
References: <Pine.LNX.4.44L0.1306171618430.1684-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]:15431 "EHLO
	usmailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab3FROzB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2013 10:55:01 -0400
Content-language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>, "len.brown@intel.com" <len.brown@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "joe@perches.com" <joe@perches.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>

On 06/17/2013 02:24 PM, Alan Stern wrote:
> On Mon, 17 Jun 2013, Shuah Khan wrote:
>
>> Change __device_suspend() path to include driver name and the ops that
>> get run for a device. This additional information helps associate the
>> driver and the type of pm_ops the device uses in the suspend path very
>> quickly, which will aid in debugging problems in suspend and resume paths.
>> Changed both start and end debug messages to include pm_ops information
>> and use dev_info() instead of pr_info(). Changed the end message to include
>> parent device information and have the same format as the start message.
>>

>>
>> [  546.087069] rtc_cmos 00:05: Start: legacy bus pm ops @ 2391, parent: pnp0
>> [  546.087084] rtc_cmos 00:05: End  : legacy bus pm ops @ 2391, parent: pnp0 time(11 usecs) err(0)
>
> If you don't mind a little more bike-shedding, I suggest formatting the
> return value and time in a shorter format, like this:
>
> [  545.987650] usb 1-1: End  : type pm ops @ 68, parent: usb1 -> 0, 2184 us
>
> Alan Stern
>
>

I am leaning towards leaving it the way it is for clarity, even though 
it is a bit longer? Changing it would make it too cryptic especially 
error return.

thanks,
-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
