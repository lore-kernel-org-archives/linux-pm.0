From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V3 4/4] cpufreq: Add Kconfig option to enable/disable have_multiple_policies
Date: Wed, 13 Mar 2013 22:41:36 +0100
Message-ID: <3174774.7AKCbYrzc6@vostro.rjw.lan>
References: <cover.1362381470.git.viresh.kumar@linaro.org> <1687194.MelaMkNoiM@vostro.rjw.lan> <CAKohpompsA5bR6TauM7Wa6ciLxYYc7GdpN1NXdHF_WbP2ki=qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpompsA5bR6TauM7Wa6ciLxYYc7GdpN1NXdHF_WbP2ki=qA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 12, 2013 08:55:12 AM Viresh Kumar wrote:
> On 12 March 2013 07:38, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > One more question before I apply it.
> >
> > Is there any architecture/platform that will set
> > CONFIG_CPU_FREQ_HAVE_MULTIPLE_POLICIES and keep have_multiple_policies unset
> > at the same time?
> 
> No, they are redundant. That's why i have been forcing to drop this patch.

I see.

What about having the Kconfig option alone, however?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
