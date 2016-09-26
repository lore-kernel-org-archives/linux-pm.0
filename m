From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Mon, 26 Sep 2016 18:53:53 -0500
Message-ID: <e42f36f7-5bf4-fdc4-12a7-a2d6a645e82e@lwfinger.net>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>
 <3919370.SGLjGupePs@vostro.rjw.lan>
 <075788ab-34e0-803c-f2b4-3f370ecc6b14@lwfinger.net>
 <2477506.olat0BX4ex@vostro.rjw.lan>
 <1436996d-078b-aa51-4452-b6655d917135@lwfinger.net>
 <CAJZ5v0iEchM2ye==020gLj2bZc3ddCFa29jQZh6c+9X+OhfcoQ@mail.gmail.com>
 <594f5012-5157-bfdd-f715-bea8caa824c3@lwfinger.net>
 <CAJZ5v0g++0JaPUEaQy54_fcA5tv5TuNZw+5mbmo47OY-dD8HoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33289 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbcIZXxz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2016 19:53:55 -0400
In-Reply-To: <CAJZ5v0g++0JaPUEaQy54_fcA5tv5TuNZw+5mbmo47OY-dD8HoQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 09/26/2016 05:16 PM, Rafael J. Wysocki wrote:
>On Tue, Sep 27, 2016 at 12:09 AM, Larry Finger
<Larry.Finger@lwfinger.net> wrote:
>
> Maybe it's better to try diagnose the problem instead of spending more
> time on bisection.

In my original post, I asked for such help, but nothing until today. I had no 
idea what to check, but now I have a better idea.

> I'd like to know whether or not 4.7 was definitely good, though.

I never saw this problem with 4.7, but given the difficulty in triggering the 
problem, my tests may not have been definitive.
>
>> If it is one of them, it may be a while before I dare call this one "good".
>> In one respect, that is good as I will be traveling tomorrow and Wednesday.
>
> What does "cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver" say?

intel_pstate

Larry


