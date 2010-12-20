From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM: Prototype the pm_generic_ operations
Date: Mon, 20 Dec 2010 22:08:58 +0100
Message-ID: <201012202208.59102.rjw__1790.9329887063$1292879473$gmane$org@sisk.pl>
References: <1292855593-30608-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1292855593-30608-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jean Delvare <khali@linux-fr.org>
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, December 20, 2010, Mark Brown wrote:
> The pm_generic_ operations are all exported but are not prototyped in any
> header file for direct use. Do so.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I'd take this one, but the second one depends on it.

I can take both if Jean agrees.

Thanks,
Rafael


> ---
>  include/linux/pm.h |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 40f3f45..f7b5bed 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -610,4 +610,11 @@ extern unsigned int	pm_flags;
>  #define PM_APM	1
>  #define PM_ACPI	2
>  
> +int pm_generic_suspend(struct device *dev);
> +int pm_generic_resume(struct device *dev);
> +int pm_generic_freeze(struct device *dev);
> +int pm_generic_thaw(struct device *dev);
> +int pm_generic_restore(struct device *dev);
> +int pm_generic_poweroff(struct device *dev);
> +
>  #endif /* _LINUX_PM_H */
> 
