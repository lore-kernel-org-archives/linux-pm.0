From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 1/2] Input: enable i8042-level wakeup
 control
Date: Thu, 28 Jul 2011 10:53:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107281051220.1990-100000__14874.666176229$1311864847$gmane$org@iolanthe.rowland.org>
References: <20110728143121.E57469D401C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110728143121.E57469D401C@zog.reactivated.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Drake <dsd@laptop.org>
Cc: dtor@mail.ru, linux-pm@lists.linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, dilinger@queued.net
List-Id: linux-pm@vger.kernel.org

On Thu, 28 Jul 2011, Daniel Drake wrote:

> The OLPC XO laptop is able to use the PS/2 controller as a wakeup source.
> When used as a wakeup source, the key press/mouse motion must not be lost.
> 
> Add infrastructure to allow controllers to be marked as wakeup-capable,
> and avoid doing power control/reset on the i8042/serio/input devices when
> running in this mode.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>

> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1584,10 +1584,30 @@ void input_reset_device(struct input_dev *dev)
>  EXPORT_SYMBOL(input_reset_device);
>  
>  #ifdef CONFIG_PM
> +static bool input_may_wakeup(struct device *dev)
> +{
> +	/*
> +	 * Handle an i8042 wakeup corner case. The kernel sees the i8042 device
> +	 * and its grandchild input device as independent devices on different
> +	 * buses, so each one has its own suspend/resume implementation called
> +	 * from the PM layer.
> +	 *
> +	 * In this particular case, the wakeup enable setting on the
> +	 * grandparent i8042 device must take effect here, indicating that the
> +	 * input device is powered up and should not be touched during
> +	 * suspend/resume.
> +	 */
> +	return dev->parent && dev->parent->parent
> +		&& device_may_wakeup(dev->parent->parent);
> +}

Shouldn't this also check device_may_wakeup(dev)?  The user might 
disable wakeup for the input device while leaving it enabled for the 
i8042 device.

Alan Stern
