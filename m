From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v3 0/2] thermal: power allocator: add new divvy-up
 algorithm
Date: Mon, 15 May 2017 09:56:37 +0100
Message-ID: <718af724-79af-730a-9c7d-3fb901fd8aec@arm.com>
References: <1494575248-4166-1-git-send-email-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbdEOI4w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 May 2017 04:56:52 -0400
In-Reply-To: <1494575248-4166-1-git-send-email-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, javi.merino@kernel.org

Hi Rui, Eduardo,

Would it be possible to take this change?

Regards,
Lukasz



On 12/05/17 08:47, Lukasz Luba wrote:
> Hi,
>
> This patch set introduces a new algorithm in IPA.
> It distributes the power in different way.
> In first phase the spare power is splited between the same
> type of deveices. In the next phase the rest of the power
> is split among all other devices.
> More detailed description can be found in first patch.
> Second patch adds trace to the algorithm.
>
> Patch set is based on v4.11.
>
> Changes:
> v3
> - trace function call moved to second patch
> v2
> - change division to div_u64()
>
> Regards,
> Lukasz Luba
>
> Lukasz Luba (2):
>   thermal: IPA: add new divvy-up algorithm
>   trace: power allocator: add trace for divvyup algorithm
>
>  drivers/thermal/power_allocator.c              | 179 +++++++++++++++++++++----
>  include/trace/events/thermal_power_allocator.h |  40 ++++++
>  2 files changed, 195 insertions(+), 24 deletions(-)
>
