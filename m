From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 07/15] Platform: OLPC: Use BIT() and GENMASK() for
 event masks
Date: Wed, 9 Jan 2019 13:14:08 +0200
Message-ID: <CAHp75Vf=B4TxZ5ETXaezQAm3HGzQ6cNkApwxq+3_fw92phumkw@mail.gmail.com>
References: <20190108175818.705110-1-lkundrak@v3.sk>
 <20190108175818.705110-8-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190108175818.705110-8-lkundrak@v3.sk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, James Cameron <quozl@laptop.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Platform Driver <platform-driver-x86@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 8, 2019 at 7:58 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Just a cosmetic tidy-up.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>
> ---
> Changes since v1:
> - This patch was added to the set.
>
>  include/linux/olpc-ec.h | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/olpc-ec.h b/include/linux/olpc-ec.h
> index e28f72416a57..c4602364e909 100644
> --- a/include/linux/olpc-ec.h
> +++ b/include/linux/olpc-ec.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_OLPC_EC_H
>  #define _LINUX_OLPC_EC_H
>
> +#include <linux/bits.h>
> +
>  /* XO-1 EC commands */
>  #define EC_FIRMWARE_REV                        0x08
>  #define EC_WRITE_SCI_MASK              0x1b
> @@ -17,17 +19,16 @@
>  #define EC_EXT_SCI_QUERY               0x85
>
>  /* SCI source values */
> -#define EC_SCI_SRC_EMPTY        0x00
> -#define EC_SCI_SRC_GAME         0x01
> -#define EC_SCI_SRC_BATTERY      0x02
> -#define EC_SCI_SRC_BATSOC       0x04
> -#define EC_SCI_SRC_BATERR       0x08
> -#define EC_SCI_SRC_EBOOK        0x10    /* XO-1 only */
> -#define EC_SCI_SRC_WLAN         0x20    /* XO-1 only */
> -#define EC_SCI_SRC_ACPWR        0x40
> -#define EC_SCI_SRC_BATCRIT      0x80
> -#define EC_SCI_SRC_GPWAKE       0x100   /* XO-1.5 only */
> -#define EC_SCI_SRC_ALL          0x1FF
> +#define EC_SCI_SRC_GAME         BIT(0)
> +#define EC_SCI_SRC_BATTERY      BIT(1)
> +#define EC_SCI_SRC_BATSOC       BIT(2)
> +#define EC_SCI_SRC_BATERR       BIT(3)
> +#define EC_SCI_SRC_EBOOK        BIT(4)    /* XO-1 only */
> +#define EC_SCI_SRC_WLAN         BIT(5)    /* XO-1 only */
> +#define EC_SCI_SRC_ACPWR        BIT(6)
> +#define EC_SCI_SRC_BATCRIT      BIT(7)
> +#define EC_SCI_SRC_GPWAKE       BIT(8)   /* XO-1.5 only */
> +#define EC_SCI_SRC_ALL          GENMASK(8, 0)
>
>  struct platform_device;
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
