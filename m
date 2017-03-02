From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC v0 1/2] interconnect: Add generic interconnect controller API
Date: Thu, 2 Mar 2017 15:53:35 -0800
Message-ID: <15929d7a-65e5-f8ba-2fac-0381c5f8e8fc@infradead.org>
References: <20170301182235.19154-1-georgi.djakov@linaro.org>
 <20170301182235.19154-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170301182235.19154-2-georgi.djakov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, vincent.guittot@linaro.org, seansw@qti.qualcomm.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, davidai@quicinc.com, skannan@codeaurora.org, khilman@baylibre.com, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 03/01/17 10:22, Georgi Djakov wrote:
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> new file mode 100644
> index 000000000000..103524b59905
> --- /dev/null
> +++ b/drivers/interconnect/Kconfig
> @@ -0,0 +1,10 @@
> +menuconfig INTERCONNECT
> +	bool "On-Chip Interconnect management support"

Why isn't this symbol tristate instead of bool so that the
interconnect management support can be built as a loadable module?


> +	help
> +	  Support for management of the on-chip interconnects.
> +
> +	  This framework is designed to provide a generic interface for
> +          managing the interconnects in a SoC.
> +
> +	  If unsure, say no.
> +


-- 
~Randy
