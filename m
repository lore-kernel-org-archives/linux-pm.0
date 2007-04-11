From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Thu, 12 Apr 2007 00:47:09 +0400
Message-ID: <461D494D.3080808@gmail.com>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176306867.19348.4.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176306867.19348.4.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi Johannes,

Johannes Berg wrote:
> For powermac, we need to do some things between suspending devices and
> device_power_off, for example setting the decrementer. =

I doubt your reasoning is cogent enough. If you add such a global thing,
you should prove it, or clearly explain what is the thing for.
I don't believe that it's not possible to solve that decrementer case
without this change. Can't you add appropriate platform_device which
would register early enough, to meet that timing requirement when it
gets suspended?


>
>  =

> --- wireless-dev.orig/arch/powerpc/platforms/powermac/setup.c	2007-04-11 =
17:07:51.029481358 +0200
> +++ wireless-dev/arch/powerpc/platforms/powermac/setup.c	2007-04-11 17:10=
:53.659481358 +0200
> @@ -475,7 +475,9 @@ static int pmac_pm_valid(suspend_state_t
>  static struct pm_ops pmac_pm_ops =3D {
>  	.pm_disk_mode	=3D PM_DISK_SHUTDOWN,
>  	.prepare	=3D pmac_pm_prepare,
> +	.quiesce	=3D pm_default_quiesce,
>  	.enter		=3D pmac_pm_enter,
> +	.activate	=3D pm_default_activate,
>  	.finish		=3D pmac_pm_finish,
>  	.valid		=3D pmac_pm_valid,
>  };

So, where is that callbacks that are so desirable for powermac?


Thanks,
Dmitry
