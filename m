From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH 4/4] time: rtc-lib: Add CONFIG_RTC_SHOW_TIME_RTC
Date: Thu, 20 Jul 2017 10:52:39 -0700
Message-ID: <d3dce8d2-145a-d4ff-39cc-3b11e59ec921@android.com>
References: <20170719195012.30187-1-salyzyn@android.com>
 <20170720082620.GB14149@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:38514 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755477AbdGTRwl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 13:52:41 -0400
Received: by mail-pg0-f43.google.com with SMTP id s4so17759095pgr.5
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2017 10:52:41 -0700 (PDT)
In-Reply-To: <20170720082620.GB14149@amd>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, prarit@redhat.com, andy.shevchenko@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On 07/20/2017 01:26 AM, Pavel Machek wrote:
>> +#if defined(CONFIG_RTC_SHOW_TIME_RTC)
>> +	{
>> +		struct rtc_time tm;
>> +
>> +		rtc_time64_to_tm(ts.tv_sec, &tm);
>> +		pr_info("%s %d-%02d-%02d %02d:%02d:%02d.%09lu UTC\n",
>> +			prefix_msg ? prefix_msg : "Time:",
>> +			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
>> +			tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
>> +	}
>> +#else
>
> This was NAKed before. Are you even listening, or are you trying to
> flood us with enough mail so that someone applies your patches by
> mistake?
> 									Pavel

It was NAKed in the group, I put it aside in its own patch to keep from 
throwing out the baby with the bathwater. Was hoping that a private 
CONFIG_RTC_SHOW_TIME_RTC would be acceptable.

I guess not, topic is dead. A refresh is being tested that addresses 
many of the other concerns.

-- Mark
