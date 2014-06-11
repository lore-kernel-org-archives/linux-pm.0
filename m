From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Wed, 11 Jun 2014 20:28:49 +0200
Message-ID: <CAJZ5v0hEFp8sQH3iB6SUeVVEmdYA6ZK1kvc9NM+7sbS-LTW6nQ@mail.gmail.com>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr>
	<009b01cf857a$d5032090$7f0961b0$@net>
	<539862DB.9060905@semaphore.gr>
	<00a001cf8586$24eb5c70$6ec21550$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:39323 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbaFKS2u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 14:28:50 -0400
In-Reply-To: <00a001cf8586$24eb5c70$6ec21550$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org, dirk.j.brandewie@intel.com

On Wed, Jun 11, 2014 at 5:02 PM, Doug Smythies <dsmythies@telus.net> wr=
ote:
>
> On 2104.06.11 07:08 Stratos Karafotis wrote:
>> On 11/06/2014 04:41 =CE=BC=CE=BC, Doug Smythies wrote:
>>
>> No.
>>
>> The intent was only ever to round properly the pseudo floating point=
 result of the divide.
>> It was much more important (ugh, well 4 times more) when FRACBITS wa=
s still 6, which also got changed to 8 in a recent patch.
>>
>
> Are you sure?
>
> Yes.
>
>> This rounding was very recently added.
>> As far as I can understand, I don't see the meaning of this rounding=
, as is.
>> Even if FRAC_BITS was 6, I think it would have almost no improvement=
 in
>> calculations.
>
> Note: I had not seen this e-mail when I wrote a few minutes ago:
>
> You may be correct.
> If Dirk agrees, I will re-analyse the entire driver for rounding effe=
cts soon.

Well, can you please do it if that's not a problem?

Rafael
