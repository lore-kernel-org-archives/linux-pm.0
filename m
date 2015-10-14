From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 1/2] ARM: cpuidle: remove cpu parameter from the
 cpuidle_ops suspend hook
Date: Wed, 14 Oct 2015 07:42:59 -0600
Message-ID: <20151014134259.GG921@linaro.org>
References: <1444648628-24790-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1444648628-24790-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20151012145640.GF921@linaro.org>
 <20151012154054.GA23364@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36548 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbbJNNnD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 09:43:03 -0400
Received: by pabur7 with SMTP id ur7so6124630pab.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 06:43:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151012154054.GA23364@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Jisheng Zhang <jszhang@marvell.com>

On Mon, Oct 12 2015 at 09:40 -0600, Lorenzo Pieralisi wrote:
>Hi Lina,
>
>On Mon, Oct 12, 2015 at 08:56:40AM -0600, Lina Iyer wrote:
>> On Mon, Oct 12 2015 at 05:16 -0600, Lorenzo Pieralisi wrote:
>> >The suspend() hook in the cpuidle_ops struct is always called on
>> >the cpu entering idle, which means that the cpu parameter passed
>> >to the suspend hook always corresponds to the local cpu, making
>> >it somewhat redundant.
>> >
>> >This patch removes the logical cpu parameter from the ARM
>> >cpuidle_ops.suspend hook and updates all the existing kernel
>> >implementations to reflect this change.
>> >
>> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> >Cc: Lina Iyer <lina.iyer@linaro.org>
>> >Cc: Russell King <linux@arm.linux.org.uk>
>> >Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Reviewed-by: Lina Iyer <lina.iyer@linaro.org>
>
>Thank you very much. May I also ask you to test it please, a Tested-by
>is needed since it affects QCOM platforms I can't test on at present.
>
Tested-by: Lina Iyer <lina.iyer@linaro.org>

Thanks,
Lina
