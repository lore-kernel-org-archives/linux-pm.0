From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq: fix double call put_device
Date: Wed, 18 May 2016 20:07:05 +0900
Message-ID: <573C4CD9.5050200@samsung.com>
References: <C3050A4DBA34F345975765E43127F10F6381E593@SZXEMA512-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36312 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbcERLHI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 07:07:08 -0400
In-reply-to: <C3050A4DBA34F345975765E43127F10F6381E593@SZXEMA512-MBS.china.huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caizhiyong <caizhiyong@hisilicon.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, lkml <linux-kernel@vger.kernel.org>
Cc: "Wanli (welly)" <welly.wan@hisilicon.com>, "Wangming (Wonder)" <mingwonder.wang@hisilicon.com>, Quyaxin <quyaxin@hisilicon.com>

Hi Cai,

On 2016=EB=85=84 05=EC=9B=94 14=EC=9D=BC 15:28, Caizhiyong wrote:
> From: Cai Zhiyong <caizhiyong@huawei.com>
> Date: Sat, 14 May 2016 14:13:30 +0800
> Subject: [PATCH] devfreq: fix double call put_device

The patch description don't need to include the 'Date/Subject'.
You need to delete them.

>=20
> 1295  */
> 1296 void device_unregister(struct device *dev)
> 1297 {
> 1298         pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
> 1299         device_del(dev);
> 1300         put_device(dev);
> 1301 }
> 1302 EXPORT_SYMBOL_GPL(device_unregister);
> 1303

Also, you don't need to include the source code of device_unregister()
because below description explains the why this patch is needed.

>=20
> device_unregister is called put_device, there is no need to call
> put_device(&devfreq->dev) again.
>=20
> Signed-off-by: Cai Zhiyong <caizhiyong@huawei.com>
> ---
>  drivers/devfreq/devfreq.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 1d6c803..8de22c0 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -621,7 +621,6 @@ int devfreq_remove_device(struct devfreq *devfreq=
)
>  		return -EINVAL;
> =20
>  	device_unregister(&devfreq->dev);
> -	put_device(&devfreq->dev);
> =20
>  	return 0;
>  }
>=20

If you modify the patch description, Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
