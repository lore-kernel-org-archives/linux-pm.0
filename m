From: Feng Hong <hongfeng@marvell.com>
Subject: Why rpm_idle called in rpm_resume ?
Date: Mon, 13 May 2013 00:18:31 -0700
Message-ID: <E62404B31D39064FBDD0B843ADF05A7D2DF42CF662@SC-VEXCH4.marvell.com>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
	<2a5901ce31c9$95160980$bf421c80$%kim@samsung.com>
	<CAKohpokk1Q+0gRpeW=ts0a8D+rGAUpHu62X+7ejdpfom_B6FYA@mail.gmail.com>
	<1769336.FkfMpuXqqb@vostro.rjw.lan>	<5176A807.2090005@samsung.com>
 <CAKohpomV9-JEbuHWdmp6N+bKYt+83hXXcqg4aKXSY1a5zwpW9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:45469 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753276Ab3EMHWT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 May 2013 03:22:19 -0400
In-Reply-To: <CAKohpomV9-JEbuHWdmp6N+bKYt+83hXXcqg4aKXSY1a5zwpW9Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi, All,

Recently, I'm reviewing the runtime implementation, there is one logical puzzle me a lot, can you help to explain ?

See below, if rpm_callback called with successful return in rpm_resume, rpm_idle will be called, what's the purpose on it ? The device just comeback to active, why call rpm_idle to try to suspend it ?  
static int rpm_resume(struct device *dev, int rpmflags)
{
    ...
    retval = rpm_callback(callback, dev);
    if (retval) {
        ...
    } else {
        __update_runtime_status(dev, RPM_ACTIVE)
        ...
    }
    if (!retval)
        rpm_idle(dev, RPM_ASYNC);
    ....
}
