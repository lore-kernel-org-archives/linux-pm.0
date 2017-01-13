From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/4] DMA Engine: switch PL330 driver to non-irq-safe
 runtime PM
Date: Fri, 13 Jan 2017 18:00:42 +0100
Message-ID: <3102129.expA2ZvqTx@wuerfel>
References: <CGME20170113072651eucas1p2b7487d97894de93daab24adb6745087c@eucas1p2.samsung.com>
 <CAPDyKFqDGs6OkG-NKiY9Xd3hHEJOJB1YJ2O0_3Tojrzv_xR-yw@mail.gmail.com>
 <60596eee-12a9-58f3-387e-145a5bc28aaa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <60596eee-12a9-58f3-387e-145a5bc28aaa@samsung.com>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, dmaengine@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, January 13, 2017 3:12:57 PM CET Marek Szyprowski wrote:
> On 2017-01-13 14:59, Ulf Hansson wrote:
> > On 13 January 2017 at 08:26, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > I did only a brief review so far, particularly concentrating on the
> > changes for device links and runtime PM. I like it!
> >
> > Perhaps we can get someone like Arnd/Vinod to comment in general idea
> > from a DT and DMA slave channel point of view. I don't know that stuff
> > good enough to give good opinion.
> 
> Arnd already said that it looks good:
> http://www.spinics.net/lists/dmaengine/msg12186.html

Rihgt, feel free to add my

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
