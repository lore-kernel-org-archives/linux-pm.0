From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 02/13] soc: samsung: pmu: Use of_device_get_match_data
 helper
Date: Fri, 20 Jan 2017 18:40:13 +0200
Message-ID: <20170120164013.6wvbmma3imis5jpr@kozik-lap>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134904eucas1p1cc044892728a1716acc2f77f32180c42@eucas1p1.samsung.com>
 <1484833733-16082-3-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1484833733-16082-3-git-send-email-m.szyprowski@samsung.com>
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
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-gpio@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 19, 2017 at 02:48:42PM +0100, Marek Szyprowski wrote:
> Replace custom code with generic helper to retrieve driver data.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/soc/samsung/exynos-pmu.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
