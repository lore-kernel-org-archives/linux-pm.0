From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v5 7/8] Loongson: YeeLoong: add suspend driver
Date: Sun, 29 Nov 2009 23:35:39 +0100
Message-ID: <200911292335.40055.rjw__34228.8632564761$1259534189$gmane$org@sisk.pl>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
	<f758058af5e45ec98bdc849e7762f32d795177e1.1259414649.git.wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f758058af5e45ec98bdc849e7762f32d795177e1.1259414649.git.wuzhangjin@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org, yanh@lemote.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, zhangfx@lemote.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 28 November 2009, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds Suspend Driver, which will suspend the YeeLoong Platform
> specific devices.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 ++
>  .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
>  .../loongson/lemote-2f/yeeloong_laptop/suspend.c   |  141 ++++++++++++++++++++
>  3 files changed, 151 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/suspend.c
> 
> diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> index c4398ff..49d63c5 100644
> --- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> +++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> @@ -45,4 +45,13 @@ config YEELOONG_VO
>  	  This option adds Video Output Driver, which provides standard
>  	  interface to turn on/off the video output of LCD, CRT.
>  
> +config YEELOONG_SUSPEND
> +	tristate "Suspend Driver"

Why tristate?

> +	depends on YEELOONG_HWMON && YEELOONG_VO
> +	select SUSPEND

I'm not sure if that's going to work.  Please make it depend on SUSPEND rather
than select it.

> +	default y
> +	help
> +	  This option adds Suspend Driver, which will suspend the YeeLoong
> +	  Platform specific devices.
> +
>  endif

Thanks,
Rafael
