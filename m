From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 3/3] power: wm831x_power: Support USB charger
 current limit management
Date: Tue, 18 Aug 2015 14:24:47 +0100
Message-ID: <20150818132447.GD9493@ck-lbox>
References: <cover.1439866451.git.baolin.wang@linaro.org>
 <4e3447ef209fbbdc3ee1c82428be2bc19c30bd30.1439866451.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:51348 "EHLO
	m0077474.ppops.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750874AbbHROH3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2015 10:07:29 -0400
Content-Disposition: inline
In-Reply-To: <4e3447ef209fbbdc3ee1c82428be2bc19c30bd30.1439866451.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@ti.com, broonie@kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org

On Tue, Aug 18, 2015 at 07:14:21PM +0800, Baolin Wang wrote:
> Integrate with the newly added USB charger interface to limit the current
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from high
> current inputs without drawing more current than specified from others.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Sorry if you guys got a bunch of bounces, we had a bit of an
email fiasco at this end. Hopefully all fixed now.

Thanks,
Charles
