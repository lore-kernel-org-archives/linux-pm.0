From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [RFC 1/7] thermal: qcom: tsens: Add a skeletal tsens drivers
Date: Mon, 08 Jun 2015 09:32:38 +0530
Message-ID: <557513DE.2050505@codeaurora.org>
References: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>	<1429796773-7151-2-git-send-email-rnayak@codeaurora.org> <7hpp59zpfv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32991 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbFHECp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 00:02:45 -0400
In-Reply-To: <7hpp59zpfv.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org

Hi Kevin,

>
> I was trying this series on linux-next with Srini's eeprom v4 and my
> first attempt was to build the eeprom, qfprom and tsens drivers as
> built-in.  Unfortunately, the tsens driver probed before the
> eeprom/qfprom driver so failed here with the "calibration failed"
> message.
>
> Building things as modules worked better, but you might want to take a
> look at possibly using -EPROBE_DEFER here?

The driver does return -EPROBE_DEFER in case the calibration fails
when tsens is probed before qfprom. It does however also show the
error message "calibration failed" which is a little misleading and
needs fixing. What target were you trying this on? I will give it a
try again to make sure things work.

regards,
Rajendra

