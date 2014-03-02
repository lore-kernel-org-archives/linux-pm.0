From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] x86_pkg_temp_thermal: Do not expose as a hwmon device
Date: Sun, 02 Mar 2014 09:44:32 -0800
Message-ID: <53136E00.2030000@roeck-us.net>
References: <20140302153335.0f1326b6@endymion.delvare>	<53135650.3070909@roeck-us.net> <20140302180452.73fa2f8a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:58795 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbaCBRof (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Mar 2014 12:44:35 -0500
In-Reply-To: <20140302180452.73fa2f8a@endymion.delvare>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>

On 03/02/2014 09:04 AM, Jean Delvare wrote:
> On Sun, 02 Mar 2014 08:03:28 -0800, Guenter Roeck wrote:
>> On 03/02/2014 06:33 AM, Jean Delvare wrote:
>>> The temperature value reported by x86_pkg_temp_thermal is already
>>> reported by the coretemp driver. So, do not expose this thermal zone
>>> as a hwmon device, because it would be redundant.
>>>
>>> Signed-off-by: Jean Delvare <jdelvare@suse.de>
>>> Cc: Zhang Rui <rui.zhang@intel.com>
>>> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
>>
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>
>> Does that make the "Fix thermal zone type" patch unnecessary ?
>
> I think both patches are needed, as type "pkg-temp-0" is wrong anyway,
> regardless of the hwmon side of things. But it is less important with
> this patch applied, indeed.
>
>> If so, this patch would be a candidate for stable.
>
> I'm still not 100% certain we want either patch in stable. After all,
> they aren't fixing any critical bug, and they change user interfaces so
> they could impact some users in unpredictable ways.
>

Ok.

Guenter

