From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 4/7] include: devfreq: add polling_idle_ms to
 'profile'
Date: Thu, 14 Feb 2019 13:51:00 +0900
Message-ID: <b956e581-0753-6257-279b-a4c8218c2651@samsung.com>
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222434eucas1p134dcdce827df19704c698fd6452b0a06@eucas1p1.samsung.com>
        <1550010238-24002-5-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550010238-24002-5-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

If the user can select the type of work in accordance with
their choice, either deferrable work or delayed work
for periodic without stop on idle state,
I think that the existing polling_ms is enough.

Because, user determine to use the 'delayed work' for periodic timer,
user can change the polling_ms through already provided sysfs interface
according to multiple situation.

In fact,
If the user want to use the periodic timer without stop on idle state
instead of deferrable work, it means that the user always want to
monitor/check the current load/status of device at the correct interval
and then changing the frequency without any latency.

On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
> Add needed fields to support new state: idle, where different polling
> interval is in use. It provides better control of the devfreq device
> and lower the power consumption when the device is not busy.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/linux/devfreq.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index fbffa74..5140970 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -72,6 +72,11 @@ struct devfreq_dev_status {
>   * @initial_freq:	The operating frequency when devfreq_add_device() is
>   *			called.
>   * @polling_ms:		The polling interval in ms. 0 disables polling.
> + * @polling_idle_ms:	The polling interval in 'idle state' in ms.
> + *			When the device is running at lowest frequency and has
> + *			low-load, it is considered as in 'idle state'.
> + *			Thus, longer polling interval is used for the device
> + *			to save some power.
>   * @target:		The device should set its operating frequency at
>   *			freq or lowest-upper-than-freq value. If freq is
>   *			higher than any operable frequency, set maximum.
> @@ -98,6 +103,7 @@ struct devfreq_dev_status {
>  struct devfreq_dev_profile {
>  	unsigned long initial_freq;
>  	unsigned int polling_ms;
> +	unsigned int polling_idle_ms;
>  
>  	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
>  	int (*get_dev_status)(struct device *dev,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
