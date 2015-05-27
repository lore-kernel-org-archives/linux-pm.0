From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] base: power : opp.c: fixed a typo error
Date: Wed, 27 May 2015 07:50:16 +0530
Message-ID: <CAOh2x=mu1gbAit8XR_nVOeYtBhnjMac+0qNXzQigtve_Dv8Z5A@mail.gmail.com>
References: <1432665010-24464-1-git-send-email-dash.sriram@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432665010-24464-1-git-send-email-dash.sriram@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sriram Dash <dash.sriram@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <trivial@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 27, 2015 at 12:00 AM, Sriram Dash <dash.sriram@gmail.com> wrote:
> From: dashsriram <dash.sriram@gmail.com>
>
> Fixed a typo error in the file
>
> Signed-off-by: Sriram Dash <dash.sriram@gmail.com>
> ---
>  drivers/base/power/opp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 677fb28..300941b 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -675,7 +675,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
>   * share a common logic which is isolated here.
>   *
>   * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> - * copy operation, returns 0 if no modifcation was done OR modification was
> + * copy operation, returns 0 if no modification was done OR modification was
>   * successful.
>   *
>   * Locking: The internal device_opp and opp structures are RCU protected.
> @@ -763,7 +763,7 @@ unlock:
>   * mutex locking or synchronize_rcu() blocking calls cannot be used.
>   *
>   * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> - * copy operation, returns 0 if no modifcation was done OR modification was
> + * copy operation, returns 0 if no modification was done OR modification was
>   * successful.
>   */
>  int dev_pm_opp_enable(struct device *dev, unsigned long freq)
> @@ -789,7 +789,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_enable);
>   * mutex locking or synchronize_rcu() blocking calls cannot be used.
>   *
>   * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> - * copy operation, returns 0 if no modifcation was done OR modification was
> + * copy operation, returns 0 if no modification was done OR modification was
>   * successful.
>   */
>  int dev_pm_opp_disable(struct device *dev, unsigned long freq)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
