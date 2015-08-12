From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Wed, 12 Aug 2015 13:05:30 +0530
Message-ID: <20150812073530.GA16445@linux>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <CAKohponhkk9BK6-7ScHeZa4R43iooWQFV8YoPLv6LjO40GNq=A@mail.gmail.com>
 <20150518185645.GA28053@n2100.arm.linux.org.uk>
 <2574268.XBqpdL2VLI@vostro.rjw.lan>
 <20150811170357.GA24529@n2100.arm.linux.org.uk>
 <20150812051659.GI32049@linux>
 <20150812072129.GD7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33580 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933463AbbHLHff (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 03:35:35 -0400
Received: by pabyb7 with SMTP id yb7so8908759pab.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2015 00:35:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150812072129.GD7557@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Yadwinder Singh Brar <yadi.brar@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12-08-15, 08:21, Russell King - ARM Linux wrote:
> Maybe not - I often lose track of which patches are in what state -
> tracking the state of 250+ patches over many months and in some cases
> _years_ is not easy.

I agree..

> That's still no reason for Eduardo to _completely_ ignore this thread,
> especially when Rafael explicitly tried to get comment from Eduardo.

Oh, no. I am not trying to be anybody's advocate here. I was just
highlighting the point here, that I remembered.

Even I was quite busy then and couldn't get back to it.

Lets fix this now. I believe you have a patch for this based on latest
kernel? Mind pasting that here for quick review?

-- 
viresh
