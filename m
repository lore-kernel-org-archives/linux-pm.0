From: Shuah Khan <shuah.kh@samsung.com>
Subject: pm: System date and time set incorrectly after suspend/resume to disk
Date: Tue, 18 Jun 2013 01:30:57 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E6172A070@sisaex02sj>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]:60776 "EHLO
	usmailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595Ab3FRBbA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2013 21:31:00 -0400
Content-language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@sisk.pl" <rjw@sisk.pl>, "a.zummo@towertech.it" <a.zummo@towertech.it>
Cc: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shuah Khan <shuah.kh@samsung.com>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>

I am seeing a problem on my system after a suspend to disk in reboot or 
shutdown mode. When pm_trace is 0 (which is the default), I can't 
reproduce the problem easily. I have to run a few more suspend tests 
before I see the problem. When pm_trace is disabled, the problem showed 
up when I ran suspend in platform mode in a row. However when pm_ptrace 
is enabled, problem happens on the very first spend to disk in reboot mode.

Steps to run into the issue:

echo 1 > pm_print_times
echo 1 > pm_trace
echo reboot > disk
echo disk > state

or

echo 1 > pm_print_times
echo 1 > pm_trace
echo shutdown > disk
echo disk > state

When system comes back up, system time set to incorrect time.

In this latest round of testing:

time before suspend was Mon Jun 17 16:27 MDT 2013
right after resume was Thu Oct 5 18:24:42 MDT 2028

I have NTP enabled on my system and I have to disable/re-enable NTP from 
Time and Date config menu.

rtc class suspend routine rtc_suspend() does adjustments to account for 
the time spent suspended. Is that the right one run in this case?

rtc_suspend() doesn't run because has_persistent_clock() returns true. 
rtc-cmos pnp driver suspend routines runs.

It is a possible race condition that is triggered when the conditions 
are right.

I have the following enabled in my config

CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"

Looking for tips on debugging the problem.

thanks,
-- Shuah
Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658


