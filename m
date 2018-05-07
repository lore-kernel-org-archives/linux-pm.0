From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: devfreq: rk3399_dmc: move interrupts
 to be optional.
Date: Mon, 7 May 2018 09:13:25 -0500
Message-ID: <20180507141325.GB31442@rob-hp-laptop>
References: <20180505093450.17327-1-enric.balletbo@collabora.com>
 <20180505093450.17327-5-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180505093450.17327-5-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org, kernel@collabora.com, hl@rock-chips.com, Chanwoo Choi <cw00.choi@samsung.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

On Sat, May 05, 2018 at 11:34:49AM +0200, Enric Balletbo i Serra wrote:
> In ATF we already wait for DDR DVFS finish, so move the interrupts properties
> to be optional.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> 
> Changes in v3:
> - [4/6] Move interrupts to be optional instead of remove.
> 
> Changes in v2:
> - [4/6] Add Reviewed-by Chanwoo Choi.
> 
>  .../devicetree/bindings/devfreq/rk3399_dmc.txt         | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
