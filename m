From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 03/15] drivers: devfreq: Drop unlikely before
 IS_ERR(_OR_NULL)
Date: Mon, 3 Aug 2015 11:17:58 +0530
Message-ID: <20150803054758.GA16589@linux>
References: <1641980442.342501438578642999.JavaMail.weblogic@epmlwas06d>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35165 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbbHCFsD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 01:48:03 -0400
Received: by pasy3 with SMTP id y3so6015603pas.2
        for <linux-pm@vger.kernel.org>; Sun, 02 Aug 2015 22:48:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1641980442.342501438578642999.JavaMail.weblogic@epmlwas06d>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>

On 03-08-15, 05:10, MyungJoo Ham wrote:
> > IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
> > is no need to do that again from its callers. Drop it.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> @ from include/linux/err.h
> #define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
> ...
> static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
> {
> 	return !ptr || IS_ERR_VALUE((unsigned long)ptr);
> }
> 
> "!ptr" appears not covered with IS_ERR_OR_NULL.
> (only the IS_ERR part seems covered)

Right, the first patch of the series has fixed that.

http://permalink.gmane.org/gmane.linux.kernel/2009151

-- 
viresh
