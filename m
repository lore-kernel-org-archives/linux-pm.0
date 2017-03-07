From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/7] thermal: rcar_gen3_thermal: remove unneeded mutex
Date: Tue, 7 Mar 2017 20:53:42 +0100
Message-ID: <20170307195342.GC2554@tetsubishi>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
 <20170306200401.29923-4-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170306200401.29923-4-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 06, 2017 at 09:03:57PM +0100, Niklas Söderlund wrote:
> There is no point in protecting a register read with a lock. This is
> most likely a leftover from when the driver was reworked before submitted
> for upstream.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Yes, a left over.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
