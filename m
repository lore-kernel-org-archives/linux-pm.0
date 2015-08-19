From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 05/21] ARM: pxa: magician: Add support for ADS7846
 touchscreen
Date: Wed, 19 Aug 2015 20:41:29 +0200
Message-ID: <87twrv6rza.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D2591F.10509@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <55D2591F.10509@tul.cz> (Petr Cvek's message of "Mon, 17 Aug 2015
 23:58:55 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, sameo@linux.intel.com, linux-pm@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cooloney@gmail.com, sre@kernel.org, haojian.zhuang@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, philipp.zabel@gmail.com, lee.jones@linaro.org, j.anaszewski@samsung.com, daniel@zonque.org
List-Id: linux-pm@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Add support for ADS7846 touchscreen.
> +
> +static struct pxa2xx_spi_master magician_spi_info = {
> +	.num_chipselect = 1,
> +/*	.enable_dma = 1, */ /* FIXME probably unnecessary */
That's up to you. If almost nothing transits on SPI then a DMA is not necessary.

I'll leave that one for a week for others to further comment.

Cheers.

--
Robert
