From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq
 drivers
Date: Tue, 2 Dec 2014 09:20:13 +0100
Message-ID: <20141202092013.6017a9b0@free-electrons.com>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
	<5607434.rlEIdu4yyh@wuerfel>
	<CAKohpomsqCnEcSeuqtZcYOC6bgTrGmc8zXTm6cA72q+hr=LBsQ@mail.gmail.com>
	<3594266.ci9lGXQ9iA@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58436 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751194AbaLBIUR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 03:20:17 -0500
In-Reply-To: <3594266.ci9lGXQ9iA@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Chander Kashyap <k.chander@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "olof@lixom.net" <olof@lixom.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.in>

Dear Arnd Bergmann,

On Mon, 01 Dec 2014 15:59:14 +0100, Arnd Bergmann wrote:

> I still don't see where it does that. All I see for mvebu is
> 
> 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> 
> without any platform data. I see this patch
> http://lists.linaro.org/pipermail/linaro-kernel/2014-September/017693.html
> on the mailing list, but it's not in linux-next, and it obviously
> would not work any more with the patch I proposed. Instead I suppose
> you would use a different string to match against for the case of
> separate clocks.

Hum, right. Actually, only the cpufreq driver part has been taken, and
I forgot to resubmit the mach-mvebu part of the solution. I'll do so
today.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
