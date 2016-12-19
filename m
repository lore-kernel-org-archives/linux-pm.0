From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 01/14] extcon: Add extcon_get_extcon_dev_by_cable_id
 function
Date: Mon, 19 Dec 2016 19:12:58 +0900
Message-ID: <5857B2AA.3030403@samsung.com>
References: <20161219000731.10188-1-hdegoede@redhat.com>
 <CGME20161219000750epcas2p4485a9ceafb718dc5a8926e9a546b3516@epcas2p4.samsung.com>
 <20161219000731.10188-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20161219000731.10188-2-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Hans,

On 2016년 12월 19일 09:07, Hans de Goede wrote:
> extcon_register_notifier() allows passing in a NULL pointer for the
> extcon_device, so that extcon consumers which want extcon events of a
> certain type, but do not know the extcon device name (e.g. because
> there are different implementation depending on the board), can still
> get such events.
> 
> But most drivers will also want to know the initial state of the cable.
> Rather then adding NULL edev argument support to extcon_get_state, which
> would require looking up the right edev each call, this commit allows
> drivers to get the first extcon device with a requested cable-id through
> a new extcon_get_extcon_dev_by_cable_id function.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon.c | 24 ++++++++++++++++++++++++
>  include/linux/extcon.h  |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 7829846..505c272 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -890,6 +890,30 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  EXPORT_SYMBOL_GPL(extcon_get_extcon_dev);
>  
>  /**
> + * extcon_get_extcon_dev_by_cable_id() - Get an extcon device by a cable id
> + * @id:		the unique id of each external connector in extcon enumeration.
> + */
> +struct extcon_dev *extcon_get_extcon_dev_by_cable_id(unsigned int id)
> +{
> +	struct extcon_dev *extd;
> +	int idx = -EINVAL;
> +
> +	mutex_lock(&extcon_dev_list_lock);
> +	list_for_each_entry(extd, &extcon_dev_list, entry) {
> +		idx = find_cable_index_by_id(extd, id);
> +		if (idx >= 0)
> +			break;
> +	}
> +	mutex_unlock(&extcon_dev_list_lock);
> +
> +	if (idx < 0)
> +		return NULL;
> +
> +	return extd;
> +}
> +EXPORT_SYMBOL_GPL(extcon_get_extcon_dev_by_cable_id);

This function do not guarantee the same operation on all of case.

For example,
The h/w board has multiple extcon provider which support the same external connector. When using this function, this function don't get the correct extcon instance. Just, this function returns the first extcon instance in the registered extcon list.

This function has the potential problem.

> +
> +/**
>   * extcon_register_notifier() - Register a notifiee to get notified by
>   *				any attach status changes from the extcon.
>   * @edev:	the extcon device that has the external connecotr.
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index b871c0c..51abda8 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -230,6 +230,7 @@ extern int devm_extcon_dev_register(struct device *dev,
>  extern void devm_extcon_dev_unregister(struct device *dev,
>  				       struct extcon_dev *edev);
>  extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
> +extern struct extcon_dev *extcon_get_extcon_dev_by_cable_id(unsigned int id);
>  
>  /*
>   * Following APIs control the memory of extcon device.
> 


-- 
Regards,
Chanwoo Choi
