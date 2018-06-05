From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 19/33] thermal: db8500: use match_string() helper
Date: Tue, 5 Jun 2018 19:14:33 +0300
Message-ID: <CAHp75Vf=DJ2U6_XrBNdbHwHOnDPKe5ZVUtsHzi0WPJAw3bBR7g@mail.gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-20-git-send-email-xieyisheng1@huawei.com>
 <CAHp75VfqEdoDZydwFmQaLiUN8cVtH3MbFHf3qixU8xUHXMwt1g@mail.gmail.com> <c058971b-e072-a7b5-3f6e-d06458099c60@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c058971b-e072-a7b5-3f6e-d06458099c60@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 23, 2018 at 10:47 AM, Yisheng Xie <xieyisheng1@huawei.com> wrot=
e:
> Hi Andy,
>
> On 2018/5/22 6:00, Andy Shevchenko wrote:
>> On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wr=
ote:
>>> match_string() returns the index of an array for a matching string,
>>> which can be used intead of open coded variant.
>>
>>> +       i =3D match_string((const char **)trip_point->cdev_name,
>>
>> Casting looks ugly. You need to constify the variable itself.
> When I tried to const cdev_name like:
> +++ b/include/linux/platform_data/db8500_thermal.h
> @@ -27,7 +27,7 @@
>  struct db8500_trip_point {
>         unsigned long temp;
>         enum thermal_trip_type type;
> -       char cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH];
> +       char const cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH]; // co=
nst char cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH] will also the same
>  };
>
> The compiler will also warning:
> drivers/thermal/db8500_thermal.c: In function =E2=80=98db8500_thermal_mat=
ch_cdev=E2=80=99:
> drivers/thermal/db8500_thermal.c:53:2: warning: passing argument 1 of =E2=
=80=98match_string=E2=80=99 from incompatible pointer type [enabled by defa=
ult]
>   i =3D match_string(trip_point->cdev_name, COOLING_DEV_MAX, cdev->type);
>   ^
> In file included from include/linux/bitmap.h:9:0,
>                  from include/linux/cpumask.h:12,
>                  from include/linux/rcupdate.h:44,
>                  from include/linux/radix-tree.h:28,
>                  from include/linux/idr.h:15,
>                  from include/linux/kernfs.h:14,
>                  from include/linux/sysfs.h:16,
>                  from kernel/include/linux/kobject.h:20,
>                  from kernel/include/linux/of.h:17,
>                  from include/linux/cpu_cooling.h:27,
>                  from drivers/thermal/db8500_thermal.c:20:
> include/linux/string.h:184:5: note: expected =E2=80=98const char * const*=
=E2=80=99 but argument is of type =E2=80=98const char (*)[20]=E2=80=99
>
> Any idea?

Yes.
If you wish to continue, you need to do two patches instead, where in
first you are changing fixed array size of pointers to dynamic one and
replace or loops from being by size to ones being NULL terminated.


--=20
With Best Regards,
Andy Shevchenko
