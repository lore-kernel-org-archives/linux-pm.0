From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH v2] power: new trace event to print device suspend and
 resume time
Date: Wed, 17 Jul 2013 17:10:06 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E6173CBA5@sisaex02sj>
References: <1374076659-3444-1-git-send-email-shuah.kh@samsung.com>
 <1374077325.1949.94.camel@joe-AO722>
 <B8EFE96D1287C24090BAD9D858E15E6173CA8D@sisaex02sj>
 <1374079268.1949.102.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]:49211 "EHLO
	usmailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780Ab3GQRKJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2013 13:10:09 -0400
Content-language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>

On 07/17/2013 10:41 AM, Joe Perches wrote:

> I think the easiest way to "fix" it is to change
> the TP_printk format to:
>
> 	TP_printk("%s %s parent=%s state=%s ops=%susecs=%lld err=%d",

I will just adjust for the space and add a comment.

>
>> Hence, I chose to leave the extra space in. I also
>> didn't want to propagate that assumption that there is an extra space
>> into this new tracepoint.
>
> It's a big deal, it just seemed untidy.
>
> There are a couple of places in drivers/base/power/main.c
> where info is set to NULL.  I didn't look hard to see if
> any of those are propagated through to this point, but
> there are uses of 'info ?: ""' for some of the logging
> messages.  That _might_ an issue.
>
> It looks like all the other logging message uses of info
> have "%s%s" so that proper word spacing is done when
> info is "" or NULL.
>

Yeah that would be bad. The safe thing might me to add a info null 
check. Working on v3 that includes Steve's review comment as well.

thanks,
-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
