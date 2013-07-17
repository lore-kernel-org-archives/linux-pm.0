From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH v2] power: new trace event to print device suspend and
 resume time
Date: Wed, 17 Jul 2013 16:30:38 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E6173CA8D@sisaex02sj>
References: <1374076659-3444-1-git-send-email-shuah.kh@samsung.com>
 <1374077325.1949.94.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]:10451 "EHLO
	usmailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab3GQQal convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2013 12:30:41 -0400
Content-language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>, "rjw@sisk.pl" <rjw@sisk.pl>
Cc: "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>

On 07/17/2013 10:09 AM, Joe Perches wrote:
> On Wed, 2013-07-17 at 09:57 -0600, Shuah Khan wrote:
>> A new trace event is added to pm events to print time it takes to suspend and
>> resume a device. It generates trace message that includes device, driver,
>> parent information in addition to the type of pm ops invoked as well as the
>> pm event and error status from the pm ops. Example trace below:
>>
>> bash-2484  [001] ....   907.330148: device_pm_report_time: backlight acpi_video0 parent=0000:00:02.0 state=freeze ops=class  usecs=0 err=0
>>
>> bash-2484  [001] ....   909.906743: device_pm_report_time: backlight acpi_video0 parent=0000:00:02.0 state=restore ops=class  usecs=0 err=0
>

Hi Joe,

> Hi again Shuah.
>
> A few things:
>
>> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> []
>> +	TP_printk("%s %s parent=%s state=%s ops=%s usecs=%lld err=%d\n",
>
> As I wrote before, do not end a TP_printk with "\n",
>
> All TP_printks are self-contained and are not possible
> to use a thing like pr_cont so no newline is ever used.
>
> Use:
>
> 	TP_printk("%s %s parent=%s state=%s ops=%s usecs=%lld err=%d",

Sorry. Missed that one. Not intentional, just an oversight. :) I should 
fix that one.

>
> Given the data is in nsecs, why use usecs for the time?
> I think full resolution would be better.

My intent to was to match the time units to the original pm_print_times.

Rafael! Do you have any preference as to usecs vs. nsecs?

>
> Why are there two spaces after "ops=class"? One would be more normal.
>
>

This one is tough. The ops string that gets generated in conditionals in 
__device_suspend() and device_resume() routines, has an extra space at 
the end. I am not sure why that was done and the subsequent pr_* that 
print that string also depend on that extra space at the end. I don't 
have an easy way to fix it without changing lots of code where this 
string is generated. Hence, I chose to leave the extra space in. I also 
didn't want to propagate that assumption that there is an extra space 
into this new tracepoint.

I could truncate the string before I pass it to the new tracepoint 
routine, however I don't like that idea. One thing I can do is, generate 
separate patch that fixes the extra space issue. That would address the 
extra space in all cases.

-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
