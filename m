From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: add header files required for
 MT7623A SCPSYS dt-binding
Date: Mon, 12 Feb 2018 08:44:01 -0600
Message-ID: <20180212144401.yzrecztdveua3zix@rob-hp-laptop>
References: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
 <9955178588f8bde01782d0645b25a7b24cceb87b.1517998367.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9955178588f8bde01782d0645b25a7b24cceb87b.1517998367.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 07, 2018 at 06:22:48PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add relevant header files required for dt-bindings of SCPSYS power domain
> control for subsystems found on MT7623A SoC.
> 
> v1 -> v2: fix typos and treat the patch as a dt-binding patch
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  include/dt-bindings/power/mt7623a-power.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt7623a-power.h

Reviewed-by: Rob Herring <robh@kernel.org>
