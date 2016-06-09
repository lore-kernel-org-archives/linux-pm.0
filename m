From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] power: vexpress: make dev_attr_active static
Date: Thu, 9 Jun 2016 12:12:37 +0100
Message-ID: <57594F25.4010307@arm.com>
References: <1465410391-29475-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58959 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932099AbcFILMm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Jun 2016 07:12:42 -0400
In-Reply-To: <1465410391-29475-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk
Cc: Sudeep Holla <sudeep.holla@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liviu Dudau <liviu.dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 08/06/16 19:26, Ben Dooks wrote:
> The dev_attr_active is not exported or defined to be used
> outside the driver, so make it static to avoid the following
> warning:
>
> drivers/power/reset/vexpress-poweroff.c:77:1: warning: symbol 'dev_attr_active' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Pulled into vexpress-for-v4.8/fixes[1] along with other 3 vexpress
related patches. Thanks.

-- 
Regards,
Sudeep

[1] git.kernel.org/sudeep.holla/linux/h/vexpress-for-v4.8/fixes
