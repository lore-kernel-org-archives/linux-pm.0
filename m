From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 00/13] Move pad retention control to Exynos pin
 controller driver
Date: Wed, 18 Jan 2017 14:06:23 +0200
Message-ID: <CAJKOXPf8a8MF9=4NKPDa1O9y1gabkG4D_khPV=9+CAWBeaqOTg@mail.gmail.com>
References: <CGME20170117124453eucas1p1b812596939db4c4f3298b941555eb05a@eucas1p1.samsung.com>
 <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <CACRpkdbXcY5PtLUfJ5idq0XnHUZOdUk2GT5PVG9pkNYvQJ4vbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdbXcY5PtLUfJ5idq0XnHUZOdUk2GT5PVG9pkNYvQJ4vbQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 18, 2017 at 12:39 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Jan 17, 2017 at 1:44 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>
>> This patchset is a follow-up of my work on adding runtime PM support
>> to Exynos pin controller driver:
>> http://www.spinics.net/lists/arm-kernel/msg550161.html
>
> Nice, once you are done fixing the remaining nits, add Tomasz ACKs
> and resend as v3 and I will apply it.

Wait, for the pinctrl patches (and also the commits moving the bits
arch/arm -> pintrl) you need the soc changes (mostly: the header).
I'll prepare a tag with them but I am still giving some time for
review.

Best regards,
Krzysztof
