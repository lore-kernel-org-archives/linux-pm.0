From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal: exynos: Read soc_type from match data
Date: Thu, 22 Feb 2018 15:41:45 +0100
Message-ID: <2023948.K0BAVOQXYc@amdc3058>
References: <CGME20180220121554eucas1p1e97fba2b784a024233d3537c33989f6a@eucas1p1.samsung.com>
 <1519128948-11818-1-git-send-email-m.purski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1519128948-11818-1-git-send-email-m.purski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maciej Purski <m.purski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 20, 2018 01:15:48 PM Maciej Purski wrote:
> Device context's field data->soc is currently obtained by comparing
> of_compatible's. Provide soc_type as .data field in device's match
> table, as it is done in most drivers.
> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
