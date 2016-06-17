From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 3/3] firmware: scpi: add device power domain support
 using genpd
Date: Fri, 17 Jun 2016 09:55:47 +0100
Message-ID: <5763BB13.1060303@arm.com>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
 <1466073481-697-4-git-send-email-sudeep.holla@arm.com>
 <5763BAE7.8020801@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48409 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967AbcFQIzw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Jun 2016 04:55:52 -0400
In-Reply-To: <5763BAE7.8020801@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Jon Medhurst <tixy@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>



On 17/06/16 09:55, Sudeep Holla wrote:
> Hi Ulf,
>
> On 16/06/16 11:38, Sudeep Holla wrote:
>> This patch hooks up the support for device power domain provided by
>> SCPI using the Linux generic power domain infrastructure.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>
> Can you review this ? I have cc-ed you on the entire series.
>

Sorry we crossed over the email, thanks for the review.

-- 
Regards,
Sudeep
