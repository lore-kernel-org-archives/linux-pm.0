From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/7] thermal: rcar_gen3_thermal: fix probe error path
Date: Tue, 7 Mar 2017 20:52:03 +0100
Message-ID: <20170307195203.GB2554@tetsubishi>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
 <20170306200401.29923-3-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170306200401.29923-3-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 06, 2017 at 09:03:56PM +0100, Niklas Söderlund wrote:
> If the memory resource for a TSC is unviable probe should fail not try
> to go ahead with the remaining TSC. This fix is aligned with other
> checks in probe where probe fails if they are unavailable.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

I disagree. There are likely SoCs in the future which have less than
TSC_MAX_NUM sensors (V3M shall have only 1 according to chapter 10C in
v0.52 documentation). So, the code exits the loop for this case. We
should move it before the devm_kzalloc(), however.

That also means that you can't really iterate over TSC_MAX_NUM in later
patches, but rather store the amount of instances in the main struct and
iterate over that value.
