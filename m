From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 16 Dec 2014 15:39:31 +0100
Message-ID: <5335513.NAdy3tNNVt@wuerfel>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org> <2519415.GklIQeMgWR@wuerfel> <20141205154526.GC2995@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141205154526.GC2995@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 05 December 2014 08:45:26 Lina Iyer wrote:
> On Thu, Dec 04 2014 at 11:20 -0700, Arnd Bergmann wrote:
> >On Thursday 04 December 2014 09:28:34 Lina Iyer wrote:

> >Having all cpuidle code generally live in drivers/cpuidle is still a good
> >idea IMO, but using a platform device just for the purpose of passing
> >data between some platform specific code and another platform specific
> >driver hasn't worked out that well here.
> >
> To achieve both, I cant think of a better way to initialize the cpuidle
> driver without the use of reference count (0 ==>
> platform_driver_register).
> 
> I tried creating dummy platform device in the DT but something or
> another gives in to an ugly implementation.
> 
> Any other ideas?

Hi Lina,

sorry for missing your mail earlier, I just replied to Daniel on this
topic, when the thread popped up again.
	
	Arnd
