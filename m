From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2 0/4] thermal: re-calculate k_po/k_pu when update
 sustainable power
Date: Wed, 6 Jan 2016 16:48:23 +0800
Message-ID: <20160106084823.GA1641@leoy-linaro>
References: <1452069023-32149-1-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36362 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbcAFIsb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2016 03:48:31 -0500
Received: by mail-pf0-f169.google.com with SMTP id 65so190368624pff.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Jan 2016 00:48:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452069023-32149-1-git-send-email-leo.yan@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>

Hi all,

On Wed, Jan 06, 2016 at 04:30:19PM +0800, Leo Yan wrote:
> k_po/k_pu are two proportional term constants and essentially they have
> fixed ratio compared with sustainable power. In current implementation,
> k_po and k_pu are absolute value after calculation and cannot represent
> the ratio relationship with sustainable power; as a result, when change
> sustainable power we cannot smoothly change proportional term constant.
> 
> So this patch series introduces k_po_ratio and k_pu_ratio, which
> represent the ratio value compared against sustainable power. Also add
> sys file system nodes for them for easily update them from userspace and
> update a bit in documentation.
> 
> Changes from v1:
> * According to Eduardo' comments, move code from thermal_core to
>   power_allocator file
> * According to Daniel's review, v1 will introduce accumulated rounding
>   errors; v2 patches can dismiss this issue
> 
> Leo Yan (4):
>   thermal: power_allocator: rework proportional parameter
>   thermal: power_allocator: change k_pu_ratio/k_po_ratio as percentage
>   thermal: add sys node for k_pu_ratio/k_po_ratio
>   thermal: power_allocator: document k_pu_ratio/k_po_ratio
> 
>  Documentation/thermal/power_allocator.txt | 15 +++++++++++----
>  drivers/thermal/power_allocator.c         | 18 ++++++++++++------
>  drivers/thermal/thermal_core.c            | 23 +++++++++++++++++++++--
>  include/linux/thermal.h                   |  4 ++--
>  4 files changed, 46 insertions(+), 14 deletions(-)

Sorry for confusion.

I recognized I used duplicated version number, please drop this series;
I will send a new v3 series.

Thanks,
Leo Yan
