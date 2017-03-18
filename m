From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 2/7] thermal: rcar_gen3_thermal: remove unneeded mutex
Date: Sat, 18 Mar 2017 12:30:26 +0300
Message-ID: <65b25e5d-0a25-ae0c-9f4d-a2a5429dc11b@cogentembedded.com>
References: <20170317155300.21566-1-niklas.soderlund+renesas@ragnatech.se>
 <20170317155300.21566-3-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170317155300.21566-3-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 3/17/2017 6:52 PM, Niklas Söderlund wrote:

> There is no point in protecting a register read with a lock. This is

    Register I/O is usually protected with spinlock...

> most likely a leftover from when the driver was reworked before submitted
> for upstream.

    Before being submitted?

> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[...]

MBR, Sergei
