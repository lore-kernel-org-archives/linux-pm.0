From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Wed, 12 Aug 2015 14:49:14 +0530
Message-ID: <20150812091914.GH16445@linux>
References: <CAKohponhkk9BK6-7ScHeZa4R43iooWQFV8YoPLv6LjO40GNq=A@mail.gmail.com>
 <20150518185645.GA28053@n2100.arm.linux.org.uk>
 <2574268.XBqpdL2VLI@vostro.rjw.lan>
 <20150811170357.GA24529@n2100.arm.linux.org.uk>
 <20150812051659.GI32049@linux>
 <20150812072129.GD7557@n2100.arm.linux.org.uk>
 <20150812073530.GA16445@linux>
 <20150812074925.GG7557@n2100.arm.linux.org.uk>
 <20150812081257.GC16445@linux>
 <20150812090857.GJ7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35090 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbbHLJTT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 05:19:19 -0400
Received: by pacgr6 with SMTP id gr6so10698886pac.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2015 02:19:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150812090857.GJ7557@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Yadwinder Singh Brar <yadi.brar@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12-08-15, 10:08, Russell King - ARM Linux wrote:
> And now generate versions for all the stable kernels inbetween.  Now
> your problem.  I'm sick of this.

Haha.. There wouldn't be many. 3.19 got large number of changes (from
me) and so we required a newer version. But after that should be
somewhat stable.

-- 
viresh
