From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: brcm: clocks: add binding for
 brcmstb-cpu-clk-div
Date: Wed, 8 Feb 2017 09:29:20 -0800
Message-ID: <CAGt4E5t8rtgCgCTMcU1m0Gq9BgHckTUus3h8=j03NF0k4icwzg@mail.gmail.com>
References: <20170201232638.74396-1-code@mmayer.net>
 <20170201232638.74396-2-code@mmayer.net>
 <20170207184145.32brcgfvl66p5qtm@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170207184145.32brcgfvl66p5qtm@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Device Tree List <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Power Management List <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Viresh Kumar <viresh.kumar@linaro.org>, Markus Mayer <code@mmayer.net>, Linux Clock List <linux-clk@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 7 February 2017 at 10:41, Rob Herring <robh@kernel.org> wrote:
> On Wed, Feb 01, 2017 at 03:26:37PM -0800, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> Add binding document for brcm,brcmstb-cpu-clk-div.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> ---
>>  .../bindings/clock/brcm,brcmstb-cpu-clk-div.txt    | 22 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  1 +
>>  2 files changed, 23 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
>
> Acked-by: Rob Herring <robh@kernel.org>

Actually, Stephen wasn't liking this too much.

See [1] for the conclusion of the ensuing discussion.

Regards,
-Markus

[1] https://lkml.org/lkml/2017/2/6/982
