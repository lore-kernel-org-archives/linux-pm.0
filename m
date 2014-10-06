From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/4] cpufreq: allow driver-specific flags
Date: Mon, 6 Oct 2014 20:55:24 +0200
Message-ID: <20141006205524.4a843d4b@free-electrons.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57664 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753011AbaJFSza (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 14:55:30 -0400
In-Reply-To: <20141006183624.4379.26437@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mike.turquette@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>

Dear Mike Turquette,

On Mon, 06 Oct 2014 11:36:24 -0700, Mike Turquette wrote:

> Thomas,
> 
> Does such a solution solve your problem? Do you still need to create a
> platform_device if you can easily get at the driver flags with this
> function?

Hum, I'm not sure to get the question: of course to instantiate cpufreq
I need to create a platform_device. The only difference between my v1
and v2 is that in v1 I was using those driver flags to pass from the
cpufreq ->probe() function to the cpufreq ->init() function that we
have independent clocks, while in v2, I'm using a new void *driver_data
field. Really, it doesn't change anything and is purely a matter of
taste.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
