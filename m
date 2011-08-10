From: "Mansoor, Illyas" <illyas.mansoor@intel.com>
Subject: Re: [PATCH v4] PM: add statistics debugfs file for
 suspend	to ram
Date: Wed, 10 Aug 2011 23:30:40 +0530
Message-ID: <EB6073F1DF78F9439DFDCC701BC6466007B36A0CCE__31968.6934505173$1312999389$gmane$org@bgsmsx502.gar.corp.intel.com>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B847F42F9@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <6E3BC7F7C9A4BF4286DD4C043110F30B5B847F42F9@shsmsx502.ccr.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Liu, ShuoX" <shuox.liu@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
Cc: "Brown, Len" <len.brown@intel.com>, "Yanmin_zhang@linux.intel.com" <Yanmin_zhang@linux.intel.com>, Greg KH <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> +struct suspend_stats suspend_stats;
>  static DEFINE_MUTEX(dpm_list_mtx);
>  static pm_message_t pm_transition;
> 
> @@ -464,8 +465,12 @@ void dpm_resume_noirq(pm_message_t state)
>  		mutex_unlock(&dpm_list_mtx);
> 
>  		error = device_resume_noirq(dev, state);
> -		if (error)
> +		if (error) {
> +			suspend_stats.failed_resume_noirq++;
> +			dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
> +			dpm_save_failed_dev(dev_name(dev));

Please make these statistics conditionally enabled, so on a production system
If we need to disable these statistics code we should be able to do so.

May be CONFIG_SUSPEND_STATS and convert those lines of code into function calls
That can be stubbed out when the config is not enabled.

-Illyas
