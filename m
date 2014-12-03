From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Wed, 03 Dec 2014 21:35:34 +0100
Message-ID: <2596381.rFt35NU3oS@wuerfel>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org> <547ED3BD.5090209@linaro.org> <20141203143122.GH499@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141203143122.GH499@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 03 December 2014 07:31:22 Lina Iyer wrote:
> >>>+static int __init qcom_spm_init(void)
> >>>+{
> >>>+    int ret;
> >>>+
> >>>+    /*
> >>>+     * cpuidle driver need to registered before the cpuidle device
> >>>+     * for any cpu. Register the device for the the cpuidle driver.
> >>>+     */
> >>>+    ret = platform_device_register(&qcom_cpuidle_drv);
> >>>+    if (ret)
> >>>+        return ret;
> >>Stephen pointed out that we would have the platform device lying around
> >>on a non-QCOM device when using multi_v7_defconfig.
> >
> >Perhaps I am missing the point, but this is not supposed to happen, no ?
> >
> This would happen, since the file would compile on multi_v7 and we would
> initialize and register this device regardless. The cpuidle-qcom.c
> driver probe would bail out looking for a matching compatible property.
> So we would not register a cpuidle driver but the device would lay
> around.

I think the problem is registering a platform_device. I've complained
about this before, but it still seems to get copied all over the
place. Please don't do this but have a driver that looks at DT to
figure out whether to access hardware or not.

	Arnd
