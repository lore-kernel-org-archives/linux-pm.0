From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] DT: bingdings: power: reset: add
 linkstation-reset doc
Date: Tue, 3 Jan 2017 11:09:52 -0600
Message-ID: <20170103170952.7svgaa247ewlht7f@rob-hp-laptop>
References: <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161227070611.14852-1-rogershimizu@gmail.com>
 <20161227070611.14852-3-rogershimizu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161227070611.14852-3-rogershimizu@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Shimizu <rogershimizu@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Ryan Tandy <ryan@nardis.ca>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 27, 2016 at 04:06:10PM +0900, Roger Shimizu wrote:
> Add linkstation-reset doc to describe the newly added
> POWER_RESET_LINKSTATION driver, which controls magic command
> sending to UART1 to power-off Buffalo Linkstation / KuroBox
> and their variants.
> 
> To: Sebastian Reichel <sre@kernel.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Ryan Tandy <ryan@nardis.ca>
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> ---
>  .../bindings/power/reset/linkstation-reset.txt     | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/linkstation-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/linkstation-reset.txt b/Documentation/devicetree/bindings/power/reset/linkstation-reset.txt
> new file mode 100644
> index 000000000000..815e340318f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/linkstation-reset.txt
> @@ -0,0 +1,26 @@
> +* Buffalo Linkstation Reset Driver
> +
> +Power of some Buffalo Linkstation or KuroBox Pro is managed by
> +micro-controller, which connects to UART1. After being fed from UART1
> +by a few magic numbers, the so-called power-off command,
> +the micro-controller will turn power off the device.

This needs to model the uC connected to the UART rather than some node 
that defines only some portion of the functionality. I'm working on 
bindings and proper bus support for this[1], but it's not done yet. 
Though, the binding side is pretty simple.

Rob

[1] https://git.kernel.org/cgit/linux/kernel/git/robh/linux.git/log/?h=serial-bus-v2
