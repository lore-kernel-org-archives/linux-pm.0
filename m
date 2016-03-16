From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Do not schedule policy update work in
 cpufreq_resume()
Date: Wed, 16 Mar 2016 11:52:09 +0700
Message-ID: <20160316045209.GC16250@vireshk-mac-ubuntu>
References: <5379622.iJjZa2C2Nq@vostro.rjw.lan>
 <20160315061059.GB13831@vireshk-mac-ubuntu>
 <CAJZ5v0iW7mkKTdgLm953nPAWVu4Cbx_P-E9bDg9WXwQtjDwb5A@mail.gmail.com>
 <CAJZ5v0j3T37SooAmm+3qRb53HXXXomFz-h+BN0pG0zfpENk_cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32933 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbcCPEwO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 00:52:14 -0400
Received: by mail-pf0-f182.google.com with SMTP id 124so58934579pfg.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Mar 2016 21:52:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j3T37SooAmm+3qRb53HXXXomFz-h+BN0pG0zfpENk_cA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 16-03-16, 01:51, Rafael J. Wysocki wrote:
> OK, so the problem with doing that in syscore ops is that the I2C bus
> needed for it may not be available at that point, which is fair
> enough.

Not just that. We wouldn't call syscore-ops for the boot-cpu. It never went
away.

> Still, though, the way it is done now is really awful and has to go.
> 
> I guess something along the lines of cpufreq_update_policy() might be
> done in cpufreq_resume() before governors are started, but it might
> even be better to set policy->cur from scratch when starting the
> governors.  Just do driver->get() and set policy->cur to what that
> returns (or just use the average of min and max if ->get is not
> available).  And that unconditionally, regardless of the reason why
> the governors are started.

I think doing it from a somewhat centric location would make more sense then
pushing this for the governors. Maybe the beginning of cpufreq_resume() is good
enough for that.

-- 
viresh
