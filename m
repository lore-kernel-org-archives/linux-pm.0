From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: brcm: clocks: add binding for
 brcmstb-cpu-clk-div
Date: Tue, 7 Feb 2017 12:41:45 -0600
Message-ID: <20170207184145.32brcgfvl66p5qtm@rob-hp-laptop>
References: <20170201232638.74396-1-code@mmayer.net>
 <20170201232638.74396-2-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170201232638.74396-2-code@mmayer.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Mayer <code@mmayer.net>
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Power Management List <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Markus Mayer <mmayer@broadcom.com>, Linux Clock List <linux-clk@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 01, 2017 at 03:26:37PM -0800, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add binding document for brcm,brcmstb-cpu-clk-div.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  .../bindings/clock/brcm,brcmstb-cpu-clk-div.txt    | 22 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt

Acked-by: Rob Herring <robh@kernel.org>
