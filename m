From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix processing for turbo
 activation ratio
Date: Mon, 25 Apr 2016 23:44:50 +0200
Message-ID: <CAJZ5v0jBBGnDJbws-0Uzj=7H8i3CU3vUeafWmnKZ594vWBjwng@mail.gmail.com>
References: <1461380039-13804-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<CAJZ5v0hnf32+012i9tDskFNrHzEeJgGp+e00rGHH17ooN5qSPw@mail.gmail.com>
	<1461601710.8946.209.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35876 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965118AbcDYVov (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 17:44:51 -0400
Received: by mail-lf0-f44.google.com with SMTP id u64so25164477lff.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2016 14:44:51 -0700 (PDT)
In-Reply-To: <1461601710.8946.209.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Apr 25, 2016 at 6:28 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Mon, 2016-04-25 at 15:48 +0200, Rafael J. Wysocki wrote:
>> On Sat, Apr 23, 2016 at 4:53 AM, Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com> wrote:
>> >
>> > When the config TDP level is not nominal (level = 0), the MSR
>> > values for
>> > reading level 1 and level 2 ratios contain power in low 14 bits and
>> > actual
>> > ratio bits are at bits [23:16]. The current processing for level 1
>> > and
>> > level 2 is wrong as there is no shift done to get actual ratio.
>> >
>> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
>> > .com>
>> Since this is a fix, do we need it in v4.6?
>>
> This impact the display of turbo_pct in Intel P-state sysfs. So if not
> too late, I prefer for v4.6.
>
>> Do we want it in -stable too and in what -stable if so?
> 4.4 onward.

OK

I also added a Fixes: tag to the commit.
