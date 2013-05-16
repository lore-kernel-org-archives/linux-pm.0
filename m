From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/6] Thermal: armada_thermal: Remove redundant platform_set_drvdata()
Date: Thu, 16 May 2013 13:39:19 +0530
Message-ID: <CAK9yfHy0fjYt3h4-E5rspARJGAfA1rtvGGiHrNhhbWuQ-fbkwg@mail.gmail.com>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
	<5183B1B0.5030806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52228 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704Ab3EPIJU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2013 04:09:20 -0400
Received: by mail-ob0-f174.google.com with SMTP id un3so3075957obb.19
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2013 01:09:19 -0700 (PDT)
In-Reply-To: <5183B1B0.5030806@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com

On 3 May 2013 18:16, Eduardo Valentin <eduardo.valentin@ti.com> wrote:
> On 03-05-2013 05:57, Sachin Kamat wrote:
>> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
>> driver is bound) removes the need to set driver data field to
>> NULL.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>
> I am fine with this patch.
>
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

Ping on this series Rui :)

-- 
With warm regards,
Sachin
