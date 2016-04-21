From: "Nayak, Rajendra" <rnayak@codeaurora.org>
Subject: Re: [PATCH v5 00/11] qcom: Add support for TSENS driver
Date: Thu, 21 Apr 2016 16:19:34 +0530
Message-ID: <5718B03E.8040500@codeaurora.org>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
 <20160420235127.GC2558@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48563 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbcDUKtq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 06:49:46 -0400
In-Reply-To: <20160420235127.GC2558@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com, srinivas.kandagatla@linaro.org

Hi Eduardo,

On 4/21/2016 5:21 AM, Eduardo Valentin wrote:
> On Thu, Apr 14, 2016 at 03:01:48PM +0530, Rajendra Nayak wrote:
>> Current set of patches apply on 4.6-rc3. nvmem apis are currently
>> broken and hence need to pull in the fixes for it as proposed here [1]
>
>
> Could you please clarify this a bit?
>
> Do I understand properly that we need to wait until [1] gets merged to
> get the driver functional again after applying this series?

Yes, thats correct. We need the nvmem apis to be functional for this
series to work.
I have added Srini who is working on fixing it and reworking [1] as
Mark wasn't happy with the current approach.

regards,
Rajendra
