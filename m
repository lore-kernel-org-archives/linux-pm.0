From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v5 3/4] dmaengine: pl330: Store pointer to slave device
Date: Wed, 18 Jan 2017 16:13:46 +0200
Message-ID: <20170118141346.wfwp7ybtqmwsiee7@kozik-lap>
References: <1484657338-26338-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124922eucas1p1d4037d80229e55007169cf85c19e5eec@eucas1p1.samsung.com>
 <1484657338-26338-4-git-send-email-m.szyprowski@samsung.com>
 <20170117172445.3itztktiay22as26@kozik-lap>
 <539bd321-66f5-9d06-923e-88dcb12787b8@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <539bd321-66f5-9d06-923e-88dcb12787b8@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-samsung-soc@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 18, 2017 at 08:07:22AM +0100, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2017-01-17 18:29, Krzysztof Kozlowski wrote:
> > On Tue, Jan 17, 2017 at 01:48:57PM +0100, Marek Szyprowski wrote:
> > > Store the pointer to slave device, which requested our channel. It will be
> > > later used to implement runtime PM of PL330 DMA controller. Although
> > > DMA channels might be requested many times, each DMA peripheral channel is
> > > physically dedicated only for specific hardware, so there should be only
> > > one slave device for each channel.
> > > 
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Any particular reason for removing my Reviewed-by? Any changes here?
> 
> No changes here. I'm sorry, the tag got lost during rebase.

Okay:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
