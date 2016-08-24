From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Can't enable/switch to 'schedutil' governor with kernel 4.7.2 ?
Date: Wed, 24 Aug 2016 16:51:26 -0700
Message-ID: <002401d1fe62$6ea9d8d0$4bfd8a70$@net>
References: <1471969523.3010993.703762385.6A0277B5@webmail.messagingengine.com> <000f01d1fd84$9fd127d0$df737770$@net> <1472068841.1982612.705147345.1DDE879C@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta16.telus.net ([209.171.16.89]:34935 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754911AbcHYEqd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Aug 2016 00:46:33 -0400
In-Reply-To: <1472068841.1982612.705147345.1DDE879C@webmail.messagingengine.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lists@ssl-mail.com
Cc: linux-pm@vger.kernel.org

On 2016.08.24  13:01 lists@ssl-mail.com wrote:
> On Tue, Aug 23, 2016, at 02:23 PM, Doug Smythies wrote:
>> On 2016.08.23 09:25 lists@ssl-mail.com wrote:
>> 
>>> Can't enable/switch to 'schedutil' governor
>>> I'm running 
>>>	uname -rm
>>>		4.7.2-1.g34ba8d6-default x86_64
>>>
>>> I'm trying to set/use the 'schedutil' governor.
>>
>> ...[cut]...
>> 
>> Please try not using cpupower or any other utility.
>> Please try using the primitive commands directly.

> as a general rule?

That is up to you. Myself, I never use other utilities
or tools if I can avoid it (and this issue is a good
example as to why).

> or in this case?

Yes, in this case as a way to separate the variables.
If you use a separate tool then you don't know if the
problem is in the tool or the kernel.

> IT appears the problem's actually a kernel bug:
>
> Bug 135391 - cpupower does not change the governor anymore 
> https://bugzilla.kernel.org/show_bug.cgi?id=135391

No, that looks to me like a bug in the tool/utility and not
the kernel itself.

> AFAICT the fix isn't in the 4.7.X tree, just in the 4.8.X one.


