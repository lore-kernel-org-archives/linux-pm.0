From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V1 Resend 02/10] PM / OPP: Drop unlikely before
 IS_ERR(_OR_NULL)
Date: Wed, 9 Sep 2015 08:13:06 +0530
Message-ID: <20150909024306.GK7639@linux>
References: <cover.1439375087.git.viresh.kumar@linaro.org>
 <455a29a594b92b9ba06b14249d8f61a7ffbbecc1.1439375087.git.viresh.kumar@linaro.org>
 <4143341.O8kzUSgY49@vostro.rjw.lan>
 <alpine.LNX.2.00.1508281551320.25821@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35185 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbbIICnL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 22:43:11 -0400
Received: by pacfv12 with SMTP id fv12so145065198pac.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2015 19:43:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1508281551320.25821@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>

On 28-08-15, 15:52, Jiri Kosina wrote:
> With series like this, I usually wait a couple weeks and the pick the ones 
> which haven't been picked into maintainer trees (I check that by looking 
> for its presence in linux-next) through trivial.git afterwards.

Is it the right to get the remaining patches applied now?

-- 
viresh
