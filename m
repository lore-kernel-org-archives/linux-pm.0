From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal/drivers/hisi: Remove confusing error message
Date: Tue, 5 Dec 2017 07:48:01 +0100
Message-ID: <dde0f691-18d4-0c18-531c-0f77200944d0@linaro.org>
References: <1499439833-32531-1-git-send-email-daniel.lezcano@linaro.org>
 <20171205015231.GC3536@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34582 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdLEGsE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 01:48:04 -0500
Received: by mail-wm0-f53.google.com with SMTP id y82so17569739wmg.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2017 22:48:04 -0800 (PST)
In-Reply-To: <20171205015231.GC3536@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 05/12/2017 02:52, Eduardo Valentin wrote:
> Hello,
> 
> Catching up on old patches.
> On Fri, Jul 07, 2017 at 05:03:52PM +0200, Daniel Lezcano wrote:
>> The sensor id is unknown at init time and we use all id in the authorized
>> MAX_SENSORS interval to register the sensor. On this SoC there is one
>> thermal-zone with one sensor on it. No need to spit on the console everytime we
>> failed to register thermal sensors, information which is deliberaly known as it
>> is part of the discovery process.
>>
>>  hisi_thermal f7030700.tsensor: failed to register sensor id 0: -19
>>  hisi_thermal f7030700.tsensor: failed to register thermal sensor: -19
>>  hisi_thermal f7030700.tsensor: failed to register sensor id 1: -19
>>  hisi_thermal f7030700.tsensor: failed to register thermal sensor: -19
>>  hisi_thermal f7030700.tsensor: failed to register sensor id 3: -19
>>  hisi_thermal f7030700.tsensor: failed to register thermal sensor: -19
>>
>> Remove the error messages
> 
> Is this still needed? I am assuming no.

Right, no longer needed.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
