From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: qcom: tsens-8916: mark PM functions
 __maybe_unused
Date: Fri, 19 Aug 2016 20:44:28 +0800
Message-ID: <1471610668.2691.64.camel@intel.com>
References: <20160704131318.990672-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160704131318.990672-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 一, 2016-07-04 at 15:12 +0200, Arnd Bergmann wrote:
> The newly added tsens-8916 driver produces warnings when CONFIG_PM
> is disabled:
> 
> drivers/thermal/qcom/tsens.c:53:12: error: 'tsens_resume' defined but
> not used [-Werror=unused-function]
>  static int tsens_resume(struct device *dev)
>             ^~~~~~~~~~~~
> drivers/thermal/qcom/tsens.c:43:12: error: 'tsens_suspend' defined
> but not used [-Werror=unused-function]
>  static int tsens_suspend(struct device *dev)
>             ^~~~~~~~~~~~~
> 
> This marks both functions __maybe_unused to let the compiler
> know that they might be used in other configurations, without
> adding ugly #ifdef logic.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.9, with a minor fix for the following checkpatch
error,

ERROR: "foo __maybe_unused  bar" should be "foo __maybe_unused bar"
#54: FILE: drivers/thermal/qcom/tsens.c:53:
+static int __maybe_unused  tsens_resume(struct device *dev)

total: 1 errors, 0 warnings, 16 lines checked

thanks,
rui

> ---
>  drivers/thermal/qcom/tsens.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c
> b/drivers/thermal/qcom/tsens.c
> index 446f70b5dbb2..e4fca3350d26 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -40,7 +40,7 @@ static int tsens_get_trend(void *p, int trip, enum
> thermal_trend *trend)
>  	return -ENOTSUPP;
>  }
>  
> -static int tsens_suspend(struct device *dev)
> +static int  __maybe_unused tsens_suspend(struct device *dev)
>  {
>  	struct tsens_device *tmdev = dev_get_drvdata(dev);
>  
> @@ -50,7 +50,7 @@ static int tsens_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int tsens_resume(struct device *dev)
> +static int __maybe_unused  tsens_resume(struct device *dev)
>  {
>  	struct tsens_device *tmdev = dev_get_drvdata(dev);
>  
