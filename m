From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: allow driver-specific flags
Date: Tue, 7 Oct 2014 08:55:53 +0530
Message-ID: <CAKohpo=7q9bDcHRxLehNLX6A2idGxUy3jEWvQ+EGbKOQG-MH2g@mail.gmail.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1410342112-13264-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKohpom4=nbg510bUb20C6rsG8r184YQ0SiPmPkxj8_8Y04+Bg@mail.gmail.com>
	<20140927224434.19023.35708@quantum>
	<CAKohpo=8ernJ=bMJKB5K90nsvy4UpJH67dOnFCi80uyRR3EDvw@mail.gmail.com>
	<20141005004102.4379.42626@quantum>
	<CAKohpokiKnXe+UiQBJnyry+FqWT=HgyijLNFWZ0tUj6DygzELQ@mail.gmail.com>
	<20141006183624.4379.26437@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141006183624.4379.26437@quantum>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mike Turquette <mike.turquette@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

On 7 October 2014 00:06, Mike Turquette <mike.turquette@linaro.org> wrote:
> If I change the return type to int and replace 'return 0' with 'return
> -ENODEV', would you accep this patch?

Ofcourse :)

> Does such a solution solve your problem? Do you still need to create a
> platform_device if you can easily get at the driver flags with this
> function?

Will reply to this on the last mail..
