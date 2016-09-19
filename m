From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Re: [PATCH] PM / devfreq: rockchip: add PM_DEVFREQ_EVENT dependency
Date: Mon, 19 Sep 2016 13:09:44 +0200
Message-ID: <CAJZ5v0jBb19MDzi9GNLnV7JkWetJWiByucBOkKgk8jhcpPfgjQ@mail.gmail.com>
References: <20160915154513.3006199-1-arnd@arndb.de> <CGME20160916122625epcas1p445869955222826c9500302bed51644f9@epcas1p4.samsung.com>
 <1061352963.1420884.1474271197143.JavaMail.weblogic@ep1ml103c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35172 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755806AbcISLJq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2016 07:09:46 -0400
In-Reply-To: <1061352963.1420884.1474271197143.JavaMail.weblogic@ep1ml103c>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cwchoi00@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Kyungmin Park <kyungmin.park@samsung.com>, Lin Huang <hl@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Sep 19, 2016 at 9:46 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> 2016-09-16 0:44 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> The newly added ARM_RK3399_DMC_DEVFREQ driver requires the
>> DEVFREQ_EVENT_ROCKCHIP_DFI driver and tries to turn that on through
>> a 'select' statement, and that in turn has a dependency on
>> PM_DEVFREQ_EVENT, which may be disabled here:
>>
>> warning: (ARM_RK3399_DMC_DEVFREQ) selects DEVFREQ_EVENT_ROCKCHIP_DFI which has unmet direct dependencies (PM_DEVFREQ && PM_DEVFREQ_EVENT && ARCH_ROCKCHIP)
>>
>> We probably want a 'depends on' here, but other drivers use 'select'
>> too, so for consistency I'm doing the same.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 5a893e31a636 ("PM / devfreq: rockchip: add devfreq driver for rk3399 dmc")
>
>
> Thank you.
>
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>

I've applied this one directly.

Thanks,
Rafael
