From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/4] thermal: imx: Add support for reading OCOTP through
 nvmem
Date: Fri, 14 Jul 2017 11:54:11 +0100
Message-ID: <4ad5c6dd-8179-360f-9a90-51f13565956f@linaro.org>
References: <cover.1499347157.git.leonard.crestez@nxp.com>
 <68b476b35b0c0cbce21da0e87338323bb77e9bc4.1499347157.git.leonard.crestez@nxp.com>
 <20170712063629.GD3172@dragon>
 <3dd43cba-02f2-204c-c3a2-582827018ef8@linaro.org>
 <1500029388.11612.54.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38763 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbdGNKyO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2017 06:54:14 -0400
Received: by mail-wm0-f47.google.com with SMTP id f67so18817665wmh.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2017 03:54:13 -0700 (PDT)
In-Reply-To: <1500029388.11612.54.camel@nxp.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>, Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org



On 14/07/17 11:49, Leonard Crestez wrote:
>>>> +	}
>>>> +	memcpy(val, buf, sizeof(*val));
>> This can overflow the memory allocated to val, we should be careful here
>> not to do so.
>> limit this to sizeof(u32) should be good. Also add some sanity checks to
>> make sure that len is atleast 4 bytes.
> I'm not sure what you mean, isn't this already done? There is an
> explicit check above that the read len is exactly as expected. It's
> just that the limit is written as sizeof(*val) rather than sizeof(u32).

Opps, I overlooked the type.. it looks okay.

thanks,
srini
> 
