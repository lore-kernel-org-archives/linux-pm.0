From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC PATCHv3 2/7] devfreq: event: Add the list of supported
 devfreq-event type
Date: Mon, 15 Dec 2014 15:53:26 +0100
Message-ID: <1418655206.20866.6.camel@AMDC1943>
References: <1418372852-12454-1-git-send-email-cw00.choi@samsung.com>
 <1418372852-12454-3-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1418372852-12454-3-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, rafael.j.wysocki@intel.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, b.zolnierkie@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On pi=C4=85, 2014-12-12 at 17:27 +0900, Chanwoo Choi wrote:
> This patch adds the list of supported devfreq-event type as following=
=2E
> Each devfreq-event device driver would support the various devfreq-ev=
ent type
> for devfreq governor at the same time.
> - DEVFREQ_EVENT_TYPE_RAW_DATA
> - DEVFREQ_EVENT_TYPE_UTILIZATION
> - DEVFREQ_EVENT_TYPE_BANDWIDTH
> - DEVFREQ_EVENT_TYPE_LATENCY
>=20
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq-event.c | 44 +++++++++++++++++++++++++++++++=
++++++----
>  include/linux/devfreq.h         | 29 ++++++++++++++++++++++-----
>  2 files changed, 64 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfre=
q-event.c
> index eaf59c1..9444f93 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -29,6 +29,9 @@
>  #include <linux/of.h>
>  #include "governor.h"
> =20
> +#define EVENT_TYPE_RAW_DATA_MAX		U64_MAX
> +#define EVENT_TYPE_UTILIZATION_MAX	100
> +
>  static struct class *devfreq_event_class;
> =20
>  /* The list of all devfreq event list */
> @@ -144,7 +147,8 @@ EXPORT_SYMBOL_GPL(devfreq_event_is_enabled);
>   * Note that this function set the event to the devfreq-event device=
 to start
>   * for getting the event data which could be various event type.
>   */
> -int devfreq_event_set_event(struct devfreq_event_dev *edev)
> +int devfreq_event_set_event(struct devfreq_event_dev *edev,
> +				enum devfreq_event_type type)
>  {
>  	int ret;
> =20
> @@ -158,7 +162,15 @@ int devfreq_event_set_event(struct devfreq_event=
_dev *edev)
>  		return -EPERM;
> =20
>  	mutex_lock(&edev->lock);
> -	ret =3D edev->desc->ops->set_event(edev);
> +
> +	if ((edev->desc->type & type) =3D=3D 0) {
> +		dev_err(&edev->dev, "unsupported of devfreq-event type\n");
> +		mutex_unlock(&edev->lock);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D edev->desc->ops->set_event(edev, type);
> +
>  	mutex_unlock(&edev->lock);
> =20
>  	return ret;
> @@ -174,7 +186,9 @@ EXPORT_SYMBOL_GPL(devfreq_event_set_event);
>   * current event data and total_event should be stored in second par=
ameter
>   * (total_event).
>   */
> -u64 devfreq_event_get_event(struct devfreq_event_dev *edev, u64 *tot=
al_event)
> +u64 devfreq_event_get_event(struct devfreq_event_dev *edev,
> +				enum devfreq_event_type type,
> +				u64 *total_event)
>  {
>  	u64 event;
> =20
> @@ -190,7 +204,27 @@ u64 devfreq_event_get_event(struct devfreq_event=
_dev *edev, u64 *total_event)
>  		return 0;
> =20
>  	mutex_lock(&edev->lock);
> -	event =3D edev->desc->ops->get_event(edev, total_event);
> +
> +	if ((edev->desc->type & type) =3D=3D 0) {
> +		dev_err(&edev->dev, "unsupported of devfreq-event type\n");
> +		return -EINVAL;
> +	}
> +
> +	event =3D edev->desc->ops->get_event(edev, type, total_event);
> +
> +	switch (type) {
> +	case DEVFREQ_EVENT_TYPE_RAW_DATA:
> +	case DEVFREQ_EVENT_TYPE_BANDWIDTH:
> +	case DEVFREQ_EVENT_TYPE_LATENCY:
> +		if ((event > *total_event)
> +			|| ((event > EVENT_TYPE_RAW_DATA_MAX) ||
> +				*total_event > EVENT_TYPE_RAW_DATA_MAX))
> +			event =3D 0;

missing break here.

Best regards,
Krzysztof

> +	case DEVFREQ_EVENT_TYPE_UTILIZATION:
> +		if (event > EVENT_TYPE_UTILIZATION_MAX)
> +			event =3D 0;
> +	}
> +
>  	mutex_unlock(&edev->lock);
> =20
>  	return event;
> @@ -215,8 +249,10 @@ int devfreq_event_reset_event(struct devfreq_eve=
nt_dev *edev)
>  		return -EPERM;
> =20
>  	mutex_lock(&edev->lock);
> +
>  	if (edev->desc->ops && edev->desc->ops->reset)
>  		ret =3D edev->desc->ops->reset(edev);
> +
>  	mutex_unlock(&edev->lock);
> =20
>  	if (ret < 0)
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index a8d2277..82da235 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -197,6 +197,14 @@ struct devfreq_event_dev {
>  	const struct devfreq_event_desc *desc;
>  };
> =20
> +/* The supported type by devfreq-event device */
> +enum devfreq_event_type {
> +	DEVFREQ_EVENT_TYPE_RAW_DATA	=3D BIT(0),
> +	DEVFREQ_EVENT_TYPE_UTILIZATION	=3D BIT(1),
> +	DEVFREQ_EVENT_TYPE_BANDWIDTH	=3D BIT(2),
> +	DEVFREQ_EVENT_TYPE_LATENCY	=3D BIT(3),
> +};
> +
>  /**
>   * struct devfreq_event_ops - the operations of devfreq-event device
>   *
> @@ -219,8 +227,10 @@ struct devfreq_event_ops {
>  	int (*reset)(struct devfreq_event_dev *event_dev);
> =20
>  	/* Mandatory functions */
> -	int (*set_event)(struct devfreq_event_dev *event_dev);
> -	u64 (*get_event)(struct devfreq_event_dev *event_dev, u64 *total_ev=
ent);
> +	int (*set_event)(struct devfreq_event_dev *event_dev,
> +			enum devfreq_event_type type);
> +	u64 (*get_event)(struct devfreq_event_dev *event_dev,
> +			enum devfreq_event_type type, u64 *total_event);
>  };
> =20
>  /**
> @@ -228,6 +238,10 @@ struct devfreq_event_ops {
>   *
>   * @name	: the name of devfreq-event device.
>   * @driver_data	: the private data for devfreq-event driver.
> + * @event_type	: the supported devfreq-event type among as following
> + *		  - DEVFREQ_EVENT_TYPE_UTILIZATION
> + *		  - DEVFREQ_EVENT_TYPE_BANDWIDTH
> + *		  - DEVFREQ_EVENT_TYPE_LATENCY
>   * @ops		: the operation to control devfreq-event device.
>   *
>   * Each devfreq-event device is described with a this structure.
> @@ -236,6 +250,7 @@ struct devfreq_event_ops {
>  struct devfreq_event_desc {
>  	const char *name;
>  	void *driver_data;
> +	enum devfreq_event_type type;
> =20
>  	struct devfreq_event_ops *ops;
>  };
> @@ -273,8 +288,10 @@ extern void devm_devfreq_unregister_opp_notifier=
(struct device *dev,
>  extern int devfreq_event_enable_edev(struct devfreq_event_dev *edev)=
;
>  extern int devfreq_event_disable_edev(struct devfreq_event_dev *edev=
);
>  extern bool devfreq_event_is_enabled(struct devfreq_event_dev *edev)=
;
> -extern int devfreq_event_set_event(struct devfreq_event_dev *edev);
> +extern int devfreq_event_set_event(struct devfreq_event_dev *edev,
> +				enum devfreq_event_type type);
>  extern u64 devfreq_event_get_event(struct devfreq_event_dev *edev,
> +				enum devfreq_event_type type,
>  				u64 *total_event);
>  extern int devfreq_event_reset_event(struct devfreq_event_dev *edev)=
;
>  extern void *devfreq_event_get_drvdata(struct devfreq_event_dev *ede=
v);
> @@ -397,13 +414,15 @@ static inline bool devfreq_event_is_enabled(str=
uct devfreq_event_dev *edev);
>  	return false;
>  }
> =20
> -static inline int devfreq_event_set_event(struct devfreq_event_dev *=
edev);
> +static inline int devfreq_event_set_event(struct devfreq_event_dev *=
edev,
> +					enum devfreq_event_type type)
>  {
>  	return -EINVAL;
>  }
> =20
>  static inline u64 devfreq_event_get_event(struct devfreq_event_dev *=
edev
> -					u64 *total_event);
> +					enum devfreq_event_type type,
> +					u64 *total_event)
>  {
>  	return 0;
>  }
