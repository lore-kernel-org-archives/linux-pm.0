From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v8 2/3] dmaengine: pl330: remove pdata based initialization
Date: Mon, 27 Mar 2017 10:04:08 +0530
Message-ID: <20170327043408.GC9308@localhost>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142308eucas1p24d52db3d52e19228e8f423c3dc8b085b@eucas1p2.samsung.com>
 <1486650171-20598-3-git-send-email-m.szyprowski@samsung.com>
 <f0d36362-ce75-02a0-0bfa-e265cba03b8b@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f0d36362-ce75-02a0-0bfa-e265cba03b8b@samsung.com>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 22, 2017 at 09:22:23AM +0100, Marek Szyprowski wrote:
> Hi Vinod
> 
> 
> On 2017-02-09 15:22, Marek Szyprowski wrote:
> >This driver is now used only on platforms which support device tree, so
> >it is safe to remove legacy platform data based initialization code.
> >
> >Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >Acked-by: Arnd Bergmann <arnd@arndb.de>
> >For plat-samsung:
> >Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Vinod: This patch is completely independent from the rest of the changes
> from that patchset. Could you apply it, or do you want me to resend it
> separately? Runtime pm related changes will wait until a new DMA engine API
> is ready.

Sure, please resend it :)

-- 
~Vinod
