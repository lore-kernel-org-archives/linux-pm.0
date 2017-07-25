From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 2/5] nvmem: core: Add nvmem_cell_read_u32
Date: Tue, 25 Jul 2017 16:07:59 +0800
Message-ID: <20170725080758.GC20064@dragon>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
 <eedf98ecb5d9d47f3c8b9ffbf58e03c7a2fb8db4.1500041281.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <eedf98ecb5d9d47f3c8b9ffbf58e03c7a2fb8db4.1500041281.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 14, 2017 at 05:11:07PM +0300, Leonard Crestez wrote:
> This function does a quick and easy read of an u32 value without any
> kind of resource management code on the consumer side.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Shawn Guo <shawnguo@kernel.org>
