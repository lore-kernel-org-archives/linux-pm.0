From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 6/7] thermal: rcar_gen3_thermal: store device match data
 in private structure
Date: Tue, 7 Mar 2017 20:55:40 +0100
Message-ID: <20170307195539.GF2554@tetsubishi>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
 <20170306200401.29923-7-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170306200401.29923-7-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 06, 2017 at 09:04:00PM +0100, Niklas Söderlund wrote:
> The device match data needs to be accessible outside the probe function,
> store it in the private data structure.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
