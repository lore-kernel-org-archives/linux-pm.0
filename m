From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 1/3] thermal: of-thermal: Add devm version of thermal_zone_of_sensor_register
Date: Wed, 9 Mar 2016 17:40:38 +0530
Message-ID: <56E012BE.3050305@nvidia.com>
References: <1457098810-11964-1-git-send-email-ldewangan@nvidia.com> <1457098810-11964-2-git-send-email-ldewangan@nvidia.com> <20160308212954.GB8820@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15477 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343AbcCIMXi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 07:23:38 -0500
In-Reply-To: <20160308212954.GB8820@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, corbet@lwn.net, rklein@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi Edurado,
Thanks for review.


On Wednesday 09 March 2016 02:59 AM, Eduardo Valentin wrote:
> Hello Laxman,
>
>
> Minor as follows.
>
> Can you please run ./scripts/checkpatch.pl --strict on this and remove
> the warnings, errors, checks?

Taken from existing function and so borrowed the error. Will fix in next 
revision.


>
> On Fri, Mar 04, 2016 at 07:10:08PM +0530, Laxman Dewangan wrote:
>> Add resource managed version of thermal_zone_of_sensor_register() and
>> thermal_zone_of_sensor_unregister().
>>
>> This helps in reducing the code size in error path, remove of
>> driver remove callbacks and making proper sequence for deallocations.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> ---
>>   drivers/thermal/of-thermal.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/thermal.h      | 18 ++++++++++
> Could you also please document these under
> Documentation/thermal/sysfs-api.txt?
>
>
Sure, I saw that thermal_zone_of_sensor_register/unregister is also not 
documented.
So I will add the details for this first and then add for newly added 
interfaces.

Will take care in next series.
