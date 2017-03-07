From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/7] thermal: rcar_gen3_thermal: add delay in
 .thermal_init on r8a7796
Date: Tue, 7 Mar 2017 12:49:25 +0300
Message-ID: <98691387-0546-4884-b0ae-09814b7964d0@cogentembedded.com>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
 <20170306200401.29923-2-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170306200401.29923-2-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 3/6/2017 11:03 PM, Niklas Söderlund wrote:

> The .thermal_init needs to be delayed a short amount of to allow for the

    Amount of what? :-)

> TEMP register to contain something useful. If it's not delayed theses

    These.

> warnings are common during boot:
>
> thermal thermal_zone0: failed to read out thermal zone (-5)
> thermal thermal_zone1: failed to read out thermal zone (-5)
> thermal thermal_zone2: failed to read out thermal zone (-5)
>
> The warnings are triggered by the first call to .get_temp while the TEMP
> register contains 0 and rcar_gen3_thermal_get_temp() returns -EIO since
> a TEMP value of 0 will result in a temperature reading which is out of
> specifications.
>
> This should have been done in the initial commit which adds the driver
> as the same issue was found and corrected for r8a7795.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
[...]

MBR, Sergei
