From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
Date: Tue, 9 Aug 2016 18:55:37 -0500
Message-ID: <20160809235537.GA28122@rob-hp-laptop>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 04, 2016 at 05:04:49PM -0600, Lina Iyer wrote:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
> 
> Update DT bindings to describe idle states of PM domains.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> [Lina: Added state properties, removed state names, wakeup-latency,
> added of_pm_genpd_init() API, pruned commit text]
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> [Ulf: Moved around code to make it compile properly, rebased on top of multiple state support]

This change doesn't make sense given this is just a binding doc.

> ---
>  .../devicetree/bindings/power/power_domain.txt     | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
