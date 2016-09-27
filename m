From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Regression in 4.8 - CPU speed set very low
Date: Mon, 26 Sep 2016 20:12:38 -0700
Message-ID: <003001d2186d$02c34820$0849d860$@net>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>         <3919370.SGLjGupePs@vostro.rjw.lan>         <075788ab-34e0-803c-f2b4-3f370ecc6b14@lwfinger.net>         <2477506.olat0BX4ex@vostro.rjw.lan>         <1436996d-078b-aa51-4452-b6655d917135@lwfinger.net>         <CAJZ5v0iEchM2ye==020gLj2bZc3ddCFa29jQZh6c+9X+OhfcoQ@mail.gmail.com>         <594f5012-5157-bfdd-f715-bea8caa824c3@lwfinger.net>         <CAJZ5v0g++0JaPUEaQy54_fcA5tv5TuNZw+5mbmo47OY-dD8HoQ@mail.gmail.com>         <e42f36f7-5bf4-fdc4-12a7-a2d6a645e82e@lwfinger.net>         <CAJZ5v0hzRCqsE-Wg4aTPPF_+=o+io_P8M-D4_pu5qpDxaXAy5A@mail.gmail.com>         <2326a7dd-675f-752b-f100-5dce6e4c93fd@lwfinger.net> ohH4bKxaUa8e7ohH5blnhh
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta17.telus.net ([209.171.16.90]:36951 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933275AbcI0DMo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Sep 2016 23:12:44 -0400
In-Reply-To: ohH4bKxaUa8e7ohH5blnhh
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Larry Finger' <Larry.Finger@lwfinger.net>, "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>

On 2016.09.26 18:31 Srinivas Pandruvada wrote:
> On Mon, 2016-09-26 at 19:48 -0500, Larry Finger wrote:
>> On 09/26/2016 07:21 PM, Rafael J. Wysocki wrote: 
>>> On Tue, Sep 27, 2016 at 1:53 AM, Larry Finger wrote:
>>> But for both we need a reproducer anyway.
>> I do not have a reliable reproducer. The condition has always
>> happened when 
>> running a high-compute job such as a 'make -j8' on the kernel, or
>> building the 
>> RPM for openSUSE's implementation of VirtualBox. The latter is what
>> I'm using 
>> for most of my testing.

Run some CPU stressor and get all your CPU's going at 100% load.
And watch your core temperatures while you do so.

> 
>>> It also would be good to rule out the thermal throttling (as per
>>> the Srinivas' comments).

It is almost certainly thermal throttling, or similar causing
Clock modulation, of it seems 50%.

>>> 
>>> For now, please tell me what's in
>>> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
>> 800000
> Your effective freq is lower than 800MHz. One of the possible reason is
> thermal throttling.
>
> What distro you are using?

And what make and model of LapTop?



