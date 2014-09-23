From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3] power: reset: use restart_notifier mechanism for msm-poweroff
Date: Tue, 23 Sep 2014 10:42:56 -0700
Message-ID: <5421B120.10106@codeaurora.org>
References: <1411452520-29589-1-git-send-email-pramod.gurav@smartplayin.com> <542112FD.7080302@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <542112FD.7080302@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Josh Cartwright <joshc@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/22/14 23:28, Pramod Gurav wrote:
> +linux-arm-msm
> On Tuesday 23 September 2014 11:38 AM, Pramod Gurav wrote:
>> This change replaces use of arm_pm_restart with recently introduced
>> reset mechanism in Linux kernel called restart_notifier.
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Josh Cartwright <joshc@codeaurora.org>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: linux-pm@vger.kernel.org
>>
>> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
>> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
