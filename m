From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: CPUs do not go idle - excessive energy consumption
Date: Thu, 19 Oct 2017 17:16:00 -0700
Message-ID: <000001d34938$9d012310$d7036930$@net>
References: <000001d3436e$b9b58160$2d208420$@net> 2fn5expvk3OTt2fn6eOG4c 2gTken1Ckt1L52gTmefPL5 30gVe635D3OTt30gXeUUCy
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta19.telus.net ([209.171.16.92]:50637 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbdJTAQG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Oct 2017 20:16:06 -0400
In-Reply-To: 30gVe635D3OTt30gXeUUCy
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: 'Linux PM' <linux-pm@vger.kernel.org>

On 2017.10.13 07:10 Doug Smythies wrote:
> On 2017.10.12 09:36 Doug Smythies wrote:
>> On 2017.10.12 08:53 Rafael J. Wysocki wrote:
>>> On Thu, Oct 12, 2017 at 5:28 PM, Doug Smythies <dsmythies@telus.net> wrote:
>>>>
>>>> I am observing higher than nominal processor package power consumption, under
>>>> some conditions. The worst case, so far, was an extra 6.3 watts or 25%, however
>>>> more typically it is between 0 and 4 watts (over 1 minute sampling intervals).
>>>>
>> ...[snip]...
>>
>>> For starters, you can try to apply this patch
>>> https://patchwork.kernel.org/patch/9866841/ and see if it makes any
>> difference.
>>
>> Oh darn, I missed the importance and relevance of that e-mail (but I did get it),
>> which might have saved me a lot of time.
>> It sounds like it is exactly the same issue.
>> I'll try it as soon as I can either resolve the conflicts, or go back
>> and apply it to whatever kernel version would result in no conflicts.
>>
>> I'll report back once I have some test results.

I'll report back by replying to the above referenced e-mail.

> The patch did not solve the problem.

The patch did not work as it was sent.
The changes I had to make will also be in the above mentioned reply.

The patch still doesn't solve this particular problem.
Merely disabling idle state 0 does solve the problem.
I have been trying to demonstrate a downside to disabling
idle state 0, and haven't found one. pipe-test is something we used
before, but I don't see any difference on my computer.

I have reviewed and reminded myself about the issues with the menu governor.

> 
> Because the test results vary, and always have, it is hard to know for
> certain of there was some improvement, but I did have a couple of 10 minute
> tests with 0 occurrences (based on my arbitrary thresholds). A one hour
> test had 530 occurrences.
>
> ... Doug
