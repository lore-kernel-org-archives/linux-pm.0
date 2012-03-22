From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH] thermal: Fix for setting the thermal zone
	mode to enable/disable
Date: Thu, 22 Mar 2012 10:40:17 +0530
Message-ID: <CAK44p22JK+DkbrTwCSU1OCkkC=sHrWeFfEmTE8Km3=dZm4T-aQ@mail.gmail.com>
References: <1332328201-21191-1-git-send-email-amit.kachhap@linaro.org>
	<20120321151357.53fb86e4@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120321151357.53fb86e4@endymion.delvare>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 21 March 2012 19:43, Jean Delvare <khali@linux-fr.org> wrote:
> On Wed, 21 Mar 2012 16:40:01 +0530, Amit Daniel Kachhap wrote:
>> Basically without this patch changing the mode of thermal zone
>> is not possible as wrong string size is passed to strncmp.
>
> Actually it is possible,
> $ echo -n disabled > mode
> works fine. But it fails without the -n, your patch would fix that.
Thanks for pointing this out. Anyway this patch makes some sense until
sysfs takes care of this.
>
> Acked-by: Jean Delvare <khali@linux-fr.org>
>
> Note that a quick grep suggests that drivers/misc/ad525x_dpot.c,
> security/selinux/hooks.c and arch/m68k/sun3/prom/console.c suffer from
> the same issue, if you want to fix them too.
>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> ---
>> =A0drivers/thermal/thermal_sys.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys=
.c
>> index 220ce7e..96da1af 100644
>> --- a/drivers/thermal/thermal_sys.c
>> +++ b/drivers/thermal/thermal_sys.c
>> @@ -152,9 +152,9 @@ mode_store(struct device *dev, struct device_attribu=
te *attr,
>> =A0 =A0 =A0 if (!tz->ops->set_mode)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
>>
>> - =A0 =A0 if (!strncmp(buf, "enabled", sizeof("enabled")))
>> + =A0 =A0 if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D tz->ops->set_mode(tz, THERMAL_DEV=
ICE_ENABLED);
>> - =A0 =A0 else if (!strncmp(buf, "disabled", sizeof("disabled")))
>> + =A0 =A0 else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D tz->ops->set_mode(tz, THERMAL_DEV=
ICE_DISABLED);
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D -EINVAL;
>
>
> --
> Jean Delvare
