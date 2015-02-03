From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: tmp102: add hibernation callbacks
Date: Tue, 3 Feb 2015 09:45:19 -0800
Message-ID: <20150203174519.GA31926@roeck-us.net>
References: <1422975718-871-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422975718-871-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@linaro.org
Cc: Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 03, 2015 at 05:01:58PM +0200, grygorii.strashko@linaro.org wrote:
> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> 
> Setting a dev_pm_ops suspend/resume pair but not a set of
> hibernation functions means those pm functions will not be
> called upon hibernation.
> Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
> assigns the suspend and hibernation handlers and move
> mp102_suspend/tmp102_resume under CONFIG_PM_SLEEP to avoid
> build warnings.
> 
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Applied to -next.

Thanks,
Guenter
