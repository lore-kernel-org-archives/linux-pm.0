From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v5 00/11] qcom: Add support for TSENS driver
Date: Thu, 05 May 2016 10:16:57 +0530
Message-ID: <572AD041.8050906@codeaurora.org>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org> <20160428000309.GD2590@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160428000309.GD2590@localhost.localdomain>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org


On 04/28/2016 05:33 AM, Eduardo Valentin wrote:
> On Thu, Apr 14, 2016 at 03:01:48PM +0530, Rajendra Nayak wrote:
>> Current set of patches apply on 4.6-rc3. nvmem apis are currently
>> broken and hence need to pull in the fixes for it as proposed here [1]
> 
> From a glance overview of your series, looks good to me, but before I
> start triggering my local scripts to check them, I want to know what is
> the path for merging this.

Hey Eduardo, sorry for the delayed response, was out a few days.
So 1/11 to 6/11 would need to go through you, and the rest (dts changes)
via Andy's tree.

> 
> If I understand correctly the above statement, merging this right now,
> means merging a non-functional driver, right?

So I see Srini has pushed fixes [1] for nvmem and Greg has them pulled in in his
-next [2]

[1] https://lkml.org/lkml/2016/4/24/103
[2] git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
