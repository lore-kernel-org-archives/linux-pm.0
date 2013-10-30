From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq support for the big.LITTLE switcher
Date: Wed, 30 Oct 2013 12:47:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.03.1310301246440.18059@syhkavp.arg>
References: <1382500691-634-1-git-send-email-nicolas.pitre@linaro.org> <5107459.zGbYpZKUI5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5107459.zGbYpZKUI5@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh.kumar@linaro.org, sudeep.karkadanagesha@arm.com, dave.martin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Wed, 30 Oct 2013, Rafael J. Wysocki wrote:

> On Tuesday, October 22, 2013 11:58:09 PM Nicolas Pitre wrote:
> > This is the third and final set of patches towards a fully functional
> > and production quality switcher solution for big.LITTLE systems,
> > establishing a landmark to compare against for any scheduler based
> > solution meant to eventually surpass the switcher's power efficiency
> > available in the mainline kernel.
> > 
> > Rationale for this code: http://lwn.net/Articles/481055/
> > 
> > The first and second patch sets have already been merged by RMK.  They
> > implement the core switcher mechanism.  This set adds the necessary code
> > to drive the switcher based on cpufreq governor decisions.
> 
> Patch [1/2] doesn't apply any more after all of the recent changes from Viresh.
> 
> Please rebase on top of linux-pm/linux-next and resend.

I just resent those patches after some testing.

Thanks!


Nicolas
