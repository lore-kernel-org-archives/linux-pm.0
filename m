From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 0/3] firmware: imx: scu-pd: generalize the implementation
Date: Tue, 19 Mar 2019 21:58:20 +0800
Message-ID: <20190319135818.GA23379@dragon>
References: <1550673013-21462-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1550673013-21462-1-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aisheng Dong <aisheng.dong@nxp.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "khilman@kernel.org" <khilman@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 20, 2019 at 02:38:23PM +0000, Aisheng Dong wrote:
> This patch series used to further generalize the driver implementation for
> better adding new SCU based platforms. e.g. imx8qm which is mostly the same
> as imx8qxp except a minor SS name and resource avaliability difference.
> e.g.
> QXP has ADMA SS while QM has DMA and Audio SS separately.
> So we decouple the SS information from domain names.
> 
> Dong Aisheng (3):
>   firmware: imx: scu-pd: use bool to set postfix
>   firmware: imx: scu-pd: add specifying the base of domain name index
>     support
>   firmware: imx: scu-pd: decouple the SS information from domain names

Applied all, thanks.
