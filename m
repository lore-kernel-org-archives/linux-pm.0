From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] opp: ti-opp-supply: Dynamically update u_volt_min
Date: Thu, 8 Nov 2018 11:24:01 +0530
Message-ID: <20181108055401.btrixinlqcfh22du@vireshk-i7>
References: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
 <1541565263-8296-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541565263-8296-2-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, d-gerlach@ti.com, t-kristo@ti.com
List-Id: linux-pm@vger.kernel.org

On 07-11-18, 10:04, Keerthy wrote:
> The voltage range (min, max) provided in the device tree is from
> the data manual and is pretty big, catering to a wide range of devices.
> On a i2c read/write failure the regulator_set_voltage_triplet function
> falls back to set voltage between min and max. The min value from Device
> Tree can be lesser than the optimal value and in that case that can lead
> to a hang or crash. Hence set the u_volt_min dynamically to the optimal
> voltage value.

And why shouldn't we fix the DT for this ?

-- 
viresh
