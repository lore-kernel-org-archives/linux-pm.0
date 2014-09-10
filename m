From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 0/4] cpufreq-dt, platform_data based proposal
Date: Wed, 10 Sep 2014 12:30:08 +0200
Message-ID: <20140910123008.3430cd3f@free-electrons.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<2947757.7VG6XCG6t9@wuerfel>
	<20140910121002.148194af@free-electrons.com>
	<3121183.jngnFR1Zm6@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <3121183.jngnFR1Zm6@wuerfel>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Lior Amsalem <alior@marvell.com>, Rob Herring <rob.herring@linaro.org>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Tawfik Bayouk <tawfik@marvell.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Rafael Wysocki <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Thomas Abraham <thomas.ab@samsung.com>, Mike Turquette <mike.turquette@linaro.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sachin Kamat <spk.linux@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Arnd,

On Wed, 10 Sep 2014 12:19:41 +0200, Arnd Bergmann wrote:

> the driver for every new platform we want to support. It would
> be better to find a way that lets you add new platforms using just
> new dts files that work with the existing driver.

What do you call a "platform" ? A board or a SoC ? The top-level
compatible string contain both references to the board and the SoC, and
my idea was obviously that the cpufreq driver would match against the
SoC compatible string, not the board one. This definitely allows to
support additional boards by adding more dts without touching the code.

Of course, it however means that when a new SoC shows up, you'll need
to adjust the cpufreq driver. But you generally anyway need some kernel
changes to support a new SoC: .dtsi changes are rarely sufficient to
completely support a new chip.

> > In the mean time, would it be possible to realize that the existing
> > generic cpufreq driver simply isn't generic enough, and that we should
> > accept machine-specific cpufreq drivers for the time being?
> 
> That would work for me, to get things going for 3.18, but it's really
> up to the cpufreq maintainers. Your platform_data based patch set
> seems like a better solution to me than separate drivers, but I haven't
> looked at the details.

I personally don't really care: using platform_data, adding a
machine-specific driver, having two platform_driver for cpufreq-dt with
different names.

Viresh ?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
