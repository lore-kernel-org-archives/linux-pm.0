From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 20/24] dt: thermal: tsens: Add bindings for qcs404
Date: Mon, 25 Feb 2019 16:31:58 -0600
Message-ID: <20190225223158.GA7289@bogus>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
 <3f5a9282e815d2244b633a65e126494d23c16a7a.1549525708.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f5a9282e815d2244b633a65e126494d23c16a7a.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu,  7 Feb 2019 16:19:38 +0530, Amit Kucheria wrote:
> qcs404 uses v1 of the TSENS IP block. Create a fallback DT property
> "qcom,tsens-v1" to gather common code
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
