From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 1/2] opp: ti-opp-supply: Dynamically update u_volt_min
Date: Mon, 12 Nov 2018 08:45:39 +0530
Message-ID: <e383feb1-ba04-7f56-0cd8-257660a95bd3@ti.com>
References: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
 <1541565263-8296-2-git-send-email-j-keerthy@ti.com>
 <20181108055401.btrixinlqcfh22du@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108055401.btrixinlqcfh22du@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, d-gerlach@ti.com, t-kristo@ti.com
List-Id: linux-pm@vger.kernel.org



On 11/8/2018 11:24 AM, Viresh Kumar wrote:
> On 07-11-18, 10:04, Keerthy wrote:
>> The voltage range (min, max) provided in the device tree is from
>> the data manual and is pretty big, catering to a wide range of devices.
>> On a i2c read/write failure the regulator_set_voltage_triplet function
>> falls back to set voltage between min and max. The min value from Device
>> Tree can be lesser than the optimal value and in that case that can lead
>> to a hang or crash. Hence set the u_volt_min dynamically to the optimal
>> voltage value.
> 
> And why shouldn't we fix the DT for this ?

The DT voltages do not cater to the broad range of devices. In some 
particular cases the DT min voltage is slightly lower the voltage at 
which the device cannot sustain a particular frequency in which case the 
device just silently hangs. So best thing to do is to actually read the 
device specific voltages dynamically which will guarantee a particular 
device sustaining a particular frequency at the optimal voltage.

> 
