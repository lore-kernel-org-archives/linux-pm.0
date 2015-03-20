From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V3 0/8] ARM: cpuidle: Unify the ARM64/ARM DT approach
Date: Fri, 20 Mar 2015 18:31:11 +0000
Message-ID: <20150320183111.GA8891@red-moon>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41022 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbbCTSbK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Mar 2015 14:31:10 -0400
Content-Disposition: inline
In-Reply-To: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>

Hi Daniel,

On Fri, Mar 20, 2015 at 11:43:53AM +0000, Daniel Lezcano wrote:
> There is a big number of cpuidle drivers for the ARM architecture.
> 
> These drivers have been cleaned up and grouped into the drivers/cpuidle
> directory to keep track of the changes more easily and ensure the code
> is following the same scheme across the drivers.
> 
> That had the benefit of simplifying the code and factor out a lot of common
> parts. Beside that, as the drivers belong to the 'drivers' directory, we had
> to split the arch specific bits and the generic code in order to keep
> everything self contained. The platform driver paradigm was used for this
> purpose.
> 
> Unfortunately, this approach is now no longer accepted and a different solution
> must be provided to reach the same goal: one example is the Qualcomm cpuidle
> driver upstreaming attempt.
> 
> In the meantime, ARM64 developed a generic cpuidle driver based on DT definition.
> 
> The DT definition provides an 'enable-method' to specify one of the cpu
> operations (PSCI, ...).
> 
> This patchset unify this driver with ARM32, using the same DT definition.
> 
> Thanks with this patchset we can use the 'enable-method' to specify a cpu
> operations, hence get rid of the platform driver approach and go further in the
> cpuidle driver flexibility via the DT.

I had a look and the series seems fine, if you have a branch I can pull from
I will test on arm64 and add the required tags.

Thank you,
Lorenzo
