From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 0/2] cpufreq: Introduce LAB cpufreq governor.
Date: Wed, 10 Apr 2013 11:14:01 +0100
Message-ID: <20130410101400.GA4981@e102568-lin.cambridge.arm.com>
References: <1364804657-16590-1-git-send-email-jonghwa3.lee@samsung.com>
 <CAOh2x=nPJa0GReiN=OHLG=m4Gq51F=4VppdaQL20xi-aUa8x2Q@mail.gmail.com>
 <20130409123719.7399d5ad@amdc308.digital.local>
 <CAKohpomL-mdx6DdFiGwJzDSeWr6Gw-_F4T-D-Jz9TNH5MSgjbw@mail.gmail.com>
 <20130409184440.4cd87c1b@amdc308.digital.local>
 <CAKfTPtD6MK9ogq7mOijSxLSsH0n65Xra48XfRSB3DFs35GT=2g@mail.gmail.com>
 <20130410104452.661902af@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130410104452.661902af@amdc308.digital.local>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "sw0312.kim@samsung.com" <sw0312.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 10, 2013 at 09:44:52AM +0100, Lukasz Majewski wrote:

[...]

> > Have you also looked at the power clamp driver that have similar
> > target ?
> 
> I might be wrong here, but in my opinion the power clamp driver is a bit
> different:
> 
> 1. It is dedicated to Intel SoCs, which provide special set of
> registers (i.e. MSR_PKG_Cx_RESIDENCY [*]), which forces a processor to
> enter certain C state for a given duration. Idle duration is calculated
> by per CPU set of high priority kthreads (which also program [*]
> registers). 
> 

Those registers are used for compensation (ie user asked a given idle
ratio but HW stats show a mismatch) and they are not "programmed"
they are just read. That code is Intel specific but it can be easily ported
to ARM, I did that and most of the code is common with zero dependency
on the architecture.

> 2. ARM SoCs don't have such infrastructure, so we depend on SW here.

Well, it is true that most of the SoCs I am working on do not have
a programming interface to monitor C-state residency, granted, this is
a problem. If those stats can be retrieved somehow (I did that on our TC2
platform) then power clamp can be used on ARM with minor modifications.

Lorenzo
