From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] PM-Trace: add pm-trace support for suspending phase
Date: Sun, 15 Feb 2015 10:36:24 +0800
Message-ID: <54E00628.8080304@linux.intel.com>
References: <54DB6A81.3040706@linux.intel.com> <5368734.2g4GXN33HR@vostro.rjw.lan> <54DC3086.5030603@linux.intel.com> <3110302.hjQJaaphe1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34348 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380AbbBOCgd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 14 Feb 2015 21:36:33 -0500
In-Reply-To: <3110302.hjQJaaphe1@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


On 2015/2/13 6:24, Rafael J. Wysocki wrote:
> On Thursday, February 12, 2015 12:48:06 PM Fu, Zhonghui wrote:
>> On 2015/2/11 23:25, Rafael J. Wysocki wrote:
>>> On Wednesday, February 11, 2015 10:43:13 PM Fu, Zhonghui wrote:
>>>> From 2626594c03ca3b9884dd44073385c36f99a3651d Mon Sep 17 00:00:00 2001
>>>> From: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>>>> Date: Wed, 11 Feb 2015 16:20:21 +0800
>>>> Subject: [PATCH] PM-Trace: add pm-trace support for suspending phase
>>> Can you please avoid putting the above header lines into your patches?
>>>
>>> The only one that may be necessary is the From: line, but that's only
>>> needed if you submit from a different address.
>>>
>>> Also please don't send To: mailing lists.  Use CC instead.  In fact, there
>>> should be *one* address in the To: field when you're submitting a patch:
>>> The address of the maintainer you want to apply the patch for you.
>> Thanks for your guidance, and I will re-send this patch.
>>
>>>> Occasionally, the system can't come back up after suspend/resume
>>>> due to problems of device suspending phase. This patch make
>>>> PM_TRACE infrastructure cover device suspending phase of
>>>> suspend/resume process, and the information in RTC can tell
>>>> developers which device suspending function make system hang.
>>> Do you have any examples of when this helped and no other debug methods did?
>>>
>>> It seems odd to me that no one has ever asked for this for several years and
>>> now you need it.
>> We ever run into some system hang during suspending some devices on BayTrail-T
>> platform such as DMA, audio, etc. So, extending PM-Trace to suspend phase should
>> be helpful.
> Well, did you actually use this particular patch for debugging that?
Yes, I ever used this method to debug suspending process of some devices.

BTW, I have re-sent this patch with -M so that the rename and changes can be reviewed much easier. The subject is "[PATCH v2] PM-Trace: add pm-trace support for suspending phase".


Thanks,
Zhonghui
>
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

