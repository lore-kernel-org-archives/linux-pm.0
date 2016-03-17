From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Do not schedule policy update work in
 cpufreq_resume()
Date: Thu, 17 Mar 2016 13:44:53 +0700
Message-ID: <20160317064453.GD14898@vireshk-mac-ubuntu>
References: <5379622.iJjZa2C2Nq@vostro.rjw.lan>
 <20160315061059.GB13831@vireshk-mac-ubuntu>
 <CAJZ5v0iW7mkKTdgLm953nPAWVu4Cbx_P-E9bDg9WXwQtjDwb5A@mail.gmail.com>
 <CAJZ5v0j3T37SooAmm+3qRb53HXXXomFz-h+BN0pG0zfpENk_cA@mail.gmail.com>
 <20160316045209.GC16250@vireshk-mac-ubuntu>
 <CAJZ5v0jYdyDaPQ157iP5P3HRoufD=7TbcpBdEvRkFtA87A9y6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33473 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbcCQGo7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 02:44:59 -0400
Received: by mail-pf0-f171.google.com with SMTP id 124so107943505pfg.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 23:44:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jYdyDaPQ157iP5P3HRoufD=7TbcpBdEvRkFtA87A9y6w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 16-03-16, 13:29, Rafael J. Wysocki wrote:
> On Wed, Mar 16, 2016 at 5:52 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Not just that. We wouldn't call syscore-ops for the boot-cpu. It never went
> > away.
> 
> Yes, we would.
> 
> We actually call syscore ops *only* on that CPU.

Ahh, I thought you are talking about subsys-callbacks which we use while
registering cpufreq drivers.

> >> Still, though, the way it is done now is really awful and has to go.
> >>
> >> I guess something along the lines of cpufreq_update_policy() might be
> >> done in cpufreq_resume() before governors are started, but it might
> >> even be better to set policy->cur from scratch when starting the
> >> governors.  Just do driver->get() and set policy->cur to what that
> >> returns (or just use the average of min and max if ->get is not
> >> available).  And that unconditionally, regardless of the reason why
> >> the governors are started.
> >
> > I think doing it from a somewhat centric location would make more sense then
> > pushing this for the governors.
> 
> I'm not talking about doing that in governors, but in
> cpufreq_governor() when the event is _START.

Yeah, that shall be fine.

-- 
viresh
