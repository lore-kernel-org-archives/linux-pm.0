From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: tests: Providing cpufreq regression test
Date: Thu, 07 Aug 2014 00:50:23 +0200
Message-ID: <3078797.FIBUCqEiQa@vostro.rjw.lan>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com> <3777635.Nvoh2EpFlu@vostro.rjw.lan> <20140724090402.1f981470@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20140724090402.1f981470@amdc2363>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Abraham <ta.omasab@gmail.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <spk.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, July 24, 2014 09:04:02 AM Lukasz Majewski wrote:
> Hi Rafael,
> 
> > On Monday, July 21, 2014 09:02:34 AM Lukasz Majewski wrote:
> > > This commit adds first regression test "cpufreq_freq_test.sh" for
> > > the cpufreq subsystem.
> > 
> > First of all, I'm not seeing any explanation why this script should be
> > shipped with the kernel.
> 
> OK.
> 
> > 
> > What regressions it tests against in particular and 
> 
> Do you require SHA's/commit messages of commits which were developed to
> fix issues spotted with this test script?

No.  I want information about what kind of bugs can be catched with the
help of this script.

> > how it does that.
> 
> Is this information required in the commit message or can it stay in
> the README file created in the same commit?

There should be *some* information in the changelog too.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
