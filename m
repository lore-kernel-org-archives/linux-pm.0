From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] opp: ti-opp-supply: Fixes
Date: Thu, 8 Nov 2018 11:23:24 +0530
Message-ID: <20181108055324.rlqmerb3imas5yfc@vireshk-i7>
References: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: d-gerlach@ti.com, Keerthy <j-keerthy@ti.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com
List-Id: linux-pm@vger.kernel.org

On 07-11-18, 10:04, Keerthy wrote:
> The series brings in couple of fixes to the ti-opp-supply driver.
> One of them updates u_volt_min dynamically and avoids hang due
> to lesser static u_volt_min and the other fixes the supply in
> _get_optimal_vdd_voltage.
> 
> Keerthy (2):
>   power: opp: ti-opp-supply: Dynamically update u_volt_min
>   power: opp: ti-opp-supply: Correct the supply in
>     _get_optimal_vdd_voltage call

@Dave: I would like to get an Ack from you on these before applying.

-- 
viresh
