From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: Re: [PATCH] intel_powerclamp: Fix cstate counter detection.
Date: Tue, 19 Nov 2013 13:44:23 +0800
Message-ID: <CAGqt0zxhTGvj0DGt_-MHEghkhe+z8GFiQgTqOb+ESpVLHGHCXw@mail.gmail.com>
References: <1384758395-5074-1-git-send-email-yshuiv7@gmail.com>
	<528A3EC9.8060301@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:61819 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab3KSFoX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2013 00:44:23 -0500
Received: by mail-ve0-f176.google.com with SMTP id oz11so27829veb.35
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2013 21:44:23 -0800 (PST)
In-Reply-To: <528A3EC9.8060301@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jacob.jun.pan@linux.intel.com
Cc: linux-pm@vger.kernel.org

There are possibilities that the system is busy from boot so that it
doesn't enter C-state at all, right? In that situation powerclamp
won't work.

Also, pkg_state_counter is used to calculate a cstate ratio, and I
can't find any reason why powerclamp will be non-funtional when that
ratio is zero.

On Tue, Nov 19, 2013 at 12:22 AM, Arjan van de Ven
<arjan@linux.intel.com> wrote:
> On 11/17/2013 11:06 PM, Yuxuan Shui wrote:
>>
>> Having all zero cstate count doesn't necesserily mean the cstate
>> counter is no functional.
>>
>
> ... but it does mean that powerclamp will be non-functional
>
> but you had a reason to make this patch.
> Can you expand a little bit on what you were seeing that made you
> decide this patch was needed ?
>
