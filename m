From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 6/6] dt-bindings: devfreq: rk3399_dmc: Remove
 references of unexistant defines
Date: Tue, 7 May 2019 12:07:30 -0500
Message-ID: <20190507170730.GA3315@bogus>
References: <20190502175820.25382-1-gael.portay@collabora.com>
 <20190502175820.25382-7-gael.portay@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190502175820.25382-7-gael.portay@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com, =?iso-8859-1?Q?Ga=EBl?= PORTAY <gael.portay@collabora.com>
List-Id: linux-pm@vger.kernel.org

On Thu,  2 May 2019 13:58:20 -0400, =?UTF-8?q?Ga=C3=ABl=20PORTAY?= wrote:
> Those DDR related defines do not exist. Replace their references with
> their numerical constant.
> 
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> ---
> 
> Changes in v5: New
> 
>  .../bindings/devfreq/rk3399_dmc.txt           | 73 +++++++++----------
>  1 file changed, 34 insertions(+), 39 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
