From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v13 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Date: Mon, 17 Dec 2018 14:50:12 -0600
Message-ID: <20181217205012.GA22574@bogus>
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org>
 <1544760624-12874-2-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544760624-12874-2-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>, Taniya Das <tdas@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 Dec 2018 09:40:23 +0530, Taniya Das wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by the hardware engine.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 +++++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
