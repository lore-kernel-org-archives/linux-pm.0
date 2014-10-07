From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: allow driver-specific flags
Date: Tue, 7 Oct 2014 08:57:16 +0530
Message-ID: <CAKohpon24x0yOp1aiRwx3QK0YCqMsc8FDkLdDHGz3mfYrh5isw@mail.gmail.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1410342112-13264-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKohpom4=nbg510bUb20C6rsG8r184YQ0SiPmPkxj8_8Y04+Bg@mail.gmail.com>
	<20140927224434.19023.35708@quantum>
	<CAKohpo=8ernJ=bMJKB5K90nsvy4UpJH67dOnFCi80uyRR3EDvw@mail.gmail.com>
	<20141005004102.4379.42626@quantum>
	<CAKohpokiKnXe+UiQBJnyry+FqWT=HgyijLNFWZ0tUj6DygzELQ@mail.gmail.com>
	<20141006183624.4379.26437@quantum>
	<20141006205524.4a843d4b@free-electrons.com>
	<CAPtuhTi3ncQS+FhBVZE9F1fUWp0ZVRs3PNNGLcZf+BhbxH1z4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAPtuhTi3ncQS+FhBVZE9F1fUWp0ZVRs3PNNGLcZf+BhbxH1z4g@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

On 7 October 2014 03:14, Mike Turquette <mturquette@linaro.org> wrote:
> Poorly worded question. I was asking if the above patch would work for
> you and it seems the answer is yes.
>
> The reason I care is that I am working on a governor that needs to
> know a driver flag. It would be painful for the machine-independent
> governor to understand a machine-specific private data structure from
> the driver. The flags are listed in cpufreq.h so it makes life easy.

This patch isn't required anymore by thomas. All he needs is a flag
local to cpufreq-cpu0 driver and we didn't wanted to abuse cpufreq_driver's
flag field for that..

So this patch is just for your work..
