From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 4/8] usb: core: add power sequence handling for USB
 devices
Date: Tue, 23 Aug 2016 11:37:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1608231130330.2093-100000@iolanthe.rowland.org>
References: <20160823031021.GB13986@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160823031021.GB13986@shlinux2>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: mark.rutland@arm.com, Peter Chen <peter.chen@nxp.com>, ulf.hansson@linaro.org, stephen.boyd@linaro.org, k.kozlowski@samsung.com, Kernel development list <linux-kernel@vger.kernel.org>, festevam@gmail.com, stillcompiling@gmail.com, pawel.moll@arm.com, dbaryshkov@gmail.com, mka@chromium.org, dwmw3@infradead.org, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, arnd@arndb.de, Linux-pm mailing list <linux-pm@vger.kernel.org>, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, oscar@naiandei.net, gregkh@linuxfoundation.org, USB list <linux-usb@vger.kernel.org>, sre@kernel.org, broonie@kernel.org, p.zabel@pengutronix.de, shawnguo@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Aug 2016, Peter Chen wrote:

> I will add #ifdef CONFIG_OF for related code. And put the content at
> hub_pwrseq_on at hub_probe directly, how about below?
> 
> hub_probe() {
> 
> 	...
> 
> 	if (hub_configure(hub, endpoint) >= 0) {
> #ifdef CONFIG_OF
> 		for_each_child_of_node(parent->of_node, np) {
> 			ret = generic_pwrseq_on(np, hub);
> 			if (ret)
> 				return ret;
> 		}
> #else
> 		return 0;
> #endif
> 	}

Please make this a separate subroutine like you had before, but now in 
hub.c:

#ifdef CONFIG_OF
static int hub_of_pwrseq_on(struct usb_hub *hub)
{
...
}

#else
static inline int hub_of_pwrseq_on(struct usb_hub *hub)
{
	return 0;
}
#endif /* CONFIG_OF */


Alan Stern
