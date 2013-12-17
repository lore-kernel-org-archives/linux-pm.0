From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: 3.12: ethernet controller missing after resuming from suspend
 to RAM
Date: Tue, 17 Dec 2013 09:05:20 +0100
Message-ID: <52B005C0.1010401@gmail.com>
References: <52A96D01.1050503@gmail.com> <4421787.xvooIB0ROV@vostro.rjw.lan> <52A9F5A7.8030305@gmail.com> <55495319.9jUzi5g5UA@vostro.rjw.lan> <52AA0BB8.6070908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:63405 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab3LQIEl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2013 03:04:41 -0500
In-Reply-To: <52AA0BB8.6070908@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hello Rafael,

Could you see something in the logs ?

Thanks

On 12/12/2013 08:17 PM, Francis Moreau wrote:
> On 12/12/2013 06:58 PM, Rafael J. Wysocki wrote:
>> On Thursday, December 12, 2013 06:43:03 PM Francis Moreau wrote:
> 
> [...]
> 
>>>
>>> Actually I can see this now:
>>>
>>> [   42.400974] r8169 0000:03:00.2: System wakeup disabled by ACPI
>>
>> This should be harmless.
>>
>> Please run lspci -vv before and after suspend and send both results.
> 
> Please find them attached.
> 
> Thanks.
> 

