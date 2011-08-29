From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: Fix builderror in spi-pl022.c
Date: Mon, 29 Aug 2011 10:41:39 +0200
Message-ID: <CACRpkdavhLpsfFwHy3jnHO3o9EC+e6=dt1joMGQD_e3O=HTT-A__5722.62410210005$1314607453$gmane$org@mail.gmail.com>
References: <E1Qvo1q-0000qv-TQ@rmk-PC.arm.linux.org.uk>
	<1314559619-19923-1-git-send-email-peterhuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314559619-19923-1-git-send-email-peterhuewe@gmx.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Huewe <peterhuewe@gmx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net, Russell King <rmk+kernel@arm.linux.org.uk>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 28, 2011 at 9:26 PM, Peter Huewe <peterhuewe@gmx.de> wrote:

> This patch fixes a build error, introduced by commit (67fc8b9f, "PM: add
> runtime PM support to core Primecell driver") which unfortunately was a little
> bit incomplete and did contain a typo (11 instead of 22).
> I'm not sure how this patch could have been tested back then, if it
> doesn't even compile ;)
>
> The build failure was:
> drivers/spi/spi-pl022.c:2292: error: 'adev' undeclared (first use in
> this function)
> drivers/spi/spi-pl022.c:2344: error: 'pl022_suspend' undeclared here
> (not in a function)
>
> The build failure appears e.g. for the u8500 and realview defconfig.
>
> LinuxVersion: linux next-20110826
>
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!
Linus Walleij
