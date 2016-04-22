From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 00/11] qcom: Add support for TSENS driver
Date: Fri, 22 Apr 2016 10:07:09 +0100
Message-ID: <5719E9BD.6090805@linaro.org>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
 <20160420235127.GC2558@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38230 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbcDVJHM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 05:07:12 -0400
Received: by mail-wm0-f47.google.com with SMTP id u206so16490622wme.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2016 02:07:12 -0700 (PDT)
In-Reply-To: <20160420235127.GC2558@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Rajendra Nayak <rnayak@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com



On 21/04/16 00:51, Eduardo Valentin wrote:
> On Thu, Apr 14, 2016 at 03:01:48PM +0530, Rajendra Nayak wrote:
>> Current set of patches apply on 4.6-rc3. nvmem apis are currently
>> broken and hence need to pull in the fixes for it as proposed here [1]
>
>
> Could you please clarify this a bit?
>
> Do I understand properly that we need to wait until [1] gets merged to
> get the driver functional again after applying this series?

I think nvmem regression fixes should not stop TSENS driver from going 
to mainline.

I think you can take these patches if you are happy with them, I will 
take care of the nvmem fixes.

thanks,
srini
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
