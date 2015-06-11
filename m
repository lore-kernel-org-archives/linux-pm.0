From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq, Fix overflow in busy_scaled due to long delay
Date: Thu, 11 Jun 2015 09:17:38 -0700
Message-ID: <000901d0a462$239b6080$6ad22180$@net>
References: <1433942325-6610-1-git-send-email-prarit@redhat.com> <2049134.oxrPdGJl10@vostro.rjw.lan> <000301d0a456$09333d00$1b99b700$@net> <5579A29B.8050304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta16.telus.net ([209.171.16.89]:40249 "EHLO cmta16.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914AbbFKQRo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Jun 2015 12:17:44 -0400
In-Reply-To: <5579A29B.8050304@redhat.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Prarit Bhargava' <prarit@redhat.com>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, 'Kristen Carlson Accardi' <kristen@linux.intel.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org


On 2015.06.11 08:01 Prarit Bhargava wrote:
> On 06/11/2015 10:51 AM, Doug Smythies wrote:
>> 
>> On 2015.06.10 16:46 Rafael J. Wysocki wrote:
>>> On Wednesday, June 10, 2015 09:18:45 AM Prarit Bhargava wrote:
>>>> I looked into switching to div64_s64() instead of the 32-bit version in
>>>> div_fp(), however, this would result in sample_ratio and core_busy returning
>>>> 0 which is something we don't want.
>> 
>> ???
>> Due to a great many overflow related issues, div_fp() was changed to div64_s64()
>> a long time ago.

> Doug,
>
> Nope -- in a linux.git tree (up-to-date as of 7:00AM ET this AM)
>
> static inline int32_t div_fp(int32_t x, int32_t y)
> {
>        return div_s64((int64_t)x << FRAC_BITS, y);
> }

> If we do want this to be div64_s64, I can make that change, however, I feel that
> a long delay like this should be ignored in the performance calculations in the
> driver and that's why I chose to go the direction I did.

Prarit,

Apologies to you and the list for the distraction. I mis-read "div_s64" as "div64_s64".
Your suggestion is a good one.

I do maintain that my point about the duration method being flawed is valid.
I proposed a fix for that some time ago.


