From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH] PM / devfreq: remove redundant null pointer check
 before kfree
Date: Thu, 27 Sep 2018 11:25:36 +0900
Message-ID: <529236451.01538015400755.JavaMail.epsvc@epcpmgr01>
References: <1537535923-46240-1-git-send-email-zhongjiang@huawei.com>
        <CGME20180921133110epcas4p3d2914c21c881e2dfb6a2e2d9708f7a43@epcms1p7>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537535923-46240-1-git-send-email-zhongjiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhong jiang <zhongjiang@huawei.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

=C2=A0
> kfree has taken the null pointer into account. hence it is safe
> to remove the redundant null pointer check before kfree.
>=20
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

> ---
>  drivers/devfreq/devfreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4c49bb1..c37021d 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -675,8 +675,7 @@ struct devfreq *devfreq_add_device(struct device *dev=
,
>  =09device_unregister(&devfreq->dev);
>  =09devfreq =3D NULL;
>  err_dev:
> -=09if (devfreq)
> -=09=09kfree(devfreq);
> +=09kfree(devfreq);
>  err_out:
>  =09return ERR_PTR(err);
>  }
> --=20
> 1.7.12.4

=C2=A0
--
MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), Ph.D.
Autonomous Machine Lab., AI Center,=C2=A0Samsung Research.
Cell: +82-10-6714-2858
