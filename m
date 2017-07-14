From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/4] thermal: imx: Add support for reading OCOTP through
 nvmem
Date: Fri, 14 Jul 2017 09:48:49 +0100
Message-ID: <3dd43cba-02f2-204c-c3a2-582827018ef8@linaro.org>
References: <cover.1499347157.git.leonard.crestez@nxp.com>
 <68b476b35b0c0cbce21da0e87338323bb77e9bc4.1499347157.git.leonard.crestez@nxp.com>
 <20170712063629.GD3172@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38272 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdGNIsw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2017 04:48:52 -0400
Received: by mail-wm0-f45.google.com with SMTP id f67so15729004wmh.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2017 01:48:51 -0700 (PDT)
In-Reply-To: <20170712063629.GD3172@dragon>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Leonard Crestez <leonard.crestez@nxp.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>, Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org



On 12/07/17 07:36, Shawn Guo wrote:
>>   
>> +static int nvmem_cell_read_u32(struct device* dev, const char *cell_id, u32 *val)
>> +{
>> +	struct nvmem_cell *cell;
>> +	void *buf;
>> +	size_t len;
>> +
>> +	cell = nvmem_cell_get(dev, cell_id);
>> +	if (IS_ERR(cell))
>> +		return PTR_ERR(cell);
>> +
>> +	buf = nvmem_cell_read(cell, &len);
>> +	if (IS_ERR(buf)) {
>> +		nvmem_cell_put(cell);
>> +		return PTR_ERR(buf);
>> +	}
>> +	if (len != sizeof(*val)) {
>> +		kfree(buf);
>> +		nvmem_cell_put(cell);
>> +		return -EINVAL;
>> +	}
>> +	memcpy(val, buf, sizeof(*val));

This can overflow the memory allocated to val, we should be careful here 
not to do so.
limit this to sizeof(u32) should be good. Also add some sanity checks to 
make sure that len is atleast 4 bytes.


>> +
>> +	kfree(buf);
>> +	nvmem_cell_put(cell);
>> +	return 0;
>> +}
> The function looks nothing IMX specific, and could be a nvmem core
> function?
> 
> @Srinivas, thoughts?
Yep, this function looks generic, can be moved to nvmem layer.

Thanks,
srini
