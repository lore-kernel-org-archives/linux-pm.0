From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 08/21] cpuidle: use cpuidle_disabled() instead of "off"
Date: Thu, 26 Sep 2013 10:36:44 +0530
Message-ID: <CAKohpon6fgCp2StW1=6JUua1xuZW8iS=0VLVCTsTD6JS027meg@mail.gmail.com>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
	<19979ce88726285c72dd6fe3d7b370d53669443c.1379779777.git.viresh.kumar@linaro.org>
	<52435B05.9030201@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44]:59820 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab3IZFGp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 01:06:45 -0400
Received: by mail-qe0-f44.google.com with SMTP id 3so465069qeb.31
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 22:06:44 -0700 (PDT)
In-Reply-To: <52435B05.9030201@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 26 September 2013 03:22, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 09/22/2013 03:21 AM, Viresh Kumar wrote:
>> We have a routine for getting value of "off", better call that instead of using
>> "off" directly.
>
> We are in the fast path, I am not sure invoking a function here is
> better than using directly the static variable.

I only did it for consistency as we have this routine specifically for reading
value of "off" and so we better don't use off directly..

Probably we can make it static inline and move it into
drivers/cpuidle/cpuidle.h?
