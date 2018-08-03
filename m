From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v7 4/8] interconnect: qcom: Add RPM communication
Date: Fri, 3 Aug 2018 15:59:28 -0700
Message-ID: <CAE=gft5VyY5_44df3G2x4gLtogTNq9tqe=nYz5N0MBz42zF+Bg@mail.gmail.com>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-5-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180731161340.13000-5-georgi.djakov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: georgi.djakov@linaro.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Vincent Guittot <vincent.guittot@linaro.org>, arnd@arndb.de, linux-pm@vger.kernel.org, seansw@qti.qualcomm.com, gregkh@linuxfoundation.org, Michael Turquette <mturquette@baylibre.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, Bjorn Andersson <bjorn.andersson@linaro.org>, robh+dt@kernel.org, Saravana Kannan <skannan@codeaurora.org>, Alexandre Bailon <abailon@baylibre.com>, khilman@baylibre.com, linux-arm-msm@vger.kernel.org, daidavid1@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle communication
> with this remote processor.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom-smd.txt        | 32 +++++++
>  drivers/interconnect/qcom/Kconfig             | 14 +++
>  drivers/interconnect/qcom/Makefile            |  2 +
>  drivers/interconnect/qcom/smd-rpm.c           | 91 +++++++++++++++++++
>  drivers/interconnect/qcom/smd-rpm.h           | 16 ++++
>  5 files changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/Makefile
>  create mode 100644 drivers/interconnect/qcom/smd-rpm.c
>  create mode 100644 drivers/interconnect/qcom/smd-rpm.h
>
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom-smd.txt b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
> new file mode 100644
> index 000000000000..88a5aeb50935
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
> @@ -0,0 +1,32 @@
> +Qualcomm SMD-RPM interconnect driver binding
> +------------------------------------------------
> +The RPM (Resource Power Manager) is a dedicated hardware engine
> +for managing the shared SoC resources in order to keep the lowest
> +power profile. It communicates with other hardware subsystems via
> +the shared memory driver (SMD) back-end and accepts requests for
> +various resources.
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +                       "qcom,interconnect-smd-rpm"
> +
> +Example:
> +       smd {
> +               compatible = "qcom,smd";
> +
> +               rpm {
> +                       interrupts = <0 168 1>;

It would be nice if this interrupt example were more proper, somethine
like <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>. Other than that:

Reviewed-by: Evan Green <evgreen@chromium.org>
