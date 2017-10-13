From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: CPUs do not go idle - excessive energy consumption
Date: Fri, 13 Oct 2017 07:10:04 -0700
Message-ID: <000001d3442c$f8c44b20$ea4ce160$@net>
References: <000001d3436e$b9b58160$2d208420$@net> 2fn5expvk3OTt2fn6eOG4c 2gTken1Ckt1L52gTmefPL5
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta20.telus.net ([209.171.16.93]:33680 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758262AbdJMOKI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Oct 2017 10:10:08 -0400
In-Reply-To: 2gTken1Ckt1L52gTmefPL5
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: 'Linux PM' <linux-pm@vger.kernel.org>

On 2017.10.12 09:36 Doug Smythies wrote:
> On 2017.10.12 08:53 Rafael J. Wysocki wrote:
>> On Thu, Oct 12, 2017 at 5:28 PM, Doug Smythies <dsmythies@telus.net> wrote:
>>>
>>> I am observing higher than nominal processor package power consumption, under
>>> some conditions. The worst case, so far, was an extra 6.3 watts or 25%, however
>>> more typically it is between 0 and 4 watts (over 1 minute sampling intervals).
>>>
> ...[snip]...
>
>> For starters, you can try to apply this patch
>> https://patchwork.kernel.org/patch/9866841/ and see if it makes any
>. difference.
>
> Oh darn, I missed the importance and relevance of that e-mail (but I did get it),
> which might have saved me a lot of time.
> It sounds like it is exactly the same issue.
> I'll try it as soon as I can either resolve the conflicts, or go back
> and apply it to whatever kernel version would result in no conflicts.
>
> I'll report back once I have some test results.

The patch did not solve the problem.

Because the test results vary, and always have, it is hard to know for
certain of there was some improvement, but I did have a couple of 10 minute
tests with 0 occurrences (based on my arbitrary thresholds). A one hour
test had 530 occurrences.

... Doug
