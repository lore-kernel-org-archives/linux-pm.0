From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 2/4] dmaengine: Forward slave device
 pointer to of_xlate callback
Date: Thu, 9 Feb 2017 10:55:43 +0100
Message-ID: <CAPDyKFqYe0YJRzjaOo1N-fgZyJ8JqNnka66kSSg0nWiXOYj=BQ@mail.gmail.com>
References: <1485340088-25481-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125102824eucas1p1cf027184286131ff628eb7113c3f9e60@eucas1p1.samsung.com>
 <1485340088-25481-3-git-send-email-m.szyprowski@samsung.com>
 <26397455-1237-2a66-acf8-215aacc7c9ce@metafoo.de>
 <49c9c23d-ff0a-268a-5edd-931e04eb98b5@samsung.com>
 <20170209041123.GK19244@localhost>
 <ded8b3e8-2ef8-218b-fb6d-783825588fd8@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <ded8b3e8-2ef8-218b-fb6d-783825588fd8@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: alsa-devel@alsa-project.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

>>
>> Yes agreed on that, plus the runtime handling needs to be built in, right
>> now the APIs dont work well with it, we disucssed these during the KS and
>> this goes without saying, patches are welcome :)
>
>
> Okay, so what is the conclusion? Do you want me to do the whole rework of
> dma
> engine core to get this runtime pm patchset for pl330 merged??? Is there any
> roadmap for this rework prepared, so I can at least take a look at the
> amount
> of work needed to be done?
>
> I'm rather new to dma engine framework and I only wanted to fix pl330 driver
> not to block turning off the power domain on Exynos5422/5433 SoCs.

As you probably know, this is a common problem for many dma devices,
slave devices and platforms.

If possible, it would be great if we could avoid a solution that
doesn't force changes to lots of "dma consumer" drivers.

>
> I can also check again if there is any other way to find the slave device in
> alloc_chan_resources, like for example scanning the device tree for
> phandles,
> to avoid changing dmaengine core as this turned out to be too problematic
> before one will do the proper dma engine core rework.
>

Again, thanks for working on this!

Kind regards
Uffe
