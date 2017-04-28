From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Fri, 28 Apr 2017 09:54:11 +0530
Message-ID: <20170428042411.GC21517@vireshk-i7>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
 <ead65416-4833-6f36-81bd-c1673bb71514@arm.com>
 <20170426104752.GE1928@vireshk-i7>
 <20170427162604.GB18276@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:32969 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753157AbdD1EYP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Apr 2017 00:24:15 -0400
Received: by mail-pf0-f169.google.com with SMTP id i4so6326037pfc.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2017 21:24:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170427162604.GB18276@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>

On 27-04-17, 09:26, Eduardo Valentin wrote:
> On Wed, Apr 26, 2017 at 04:17:52PM +0530, Viresh Kumar wrote:
> > On 26-04-17, 11:41, Lukasz Luba wrote:
> > > Hi Viresh,
> > > 
> > > I went through the v4 code and it looks good to me.
> > > Feel free to add for the v4 series
> > > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > 
> > Thanks a lot for testing and reviewing the series.
> > 
> > @Eduardo: Will you be able to pick it for 4.12 ?
> 
> I feel like this is late for 4.12 given that we are already -rc8. 
> Besides, it has gone through a couple of cycles of broken interactions
> with IPA (now fixed).
> 
> So, I would prefer we give this series a bit more of testing time on
> linux-next. I can pull it and put into linux-next after the coming
> merge window is closed.

Ok, sure. No hurry.

-- 
viresh
