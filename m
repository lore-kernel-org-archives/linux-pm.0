From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: Can't set policy
Date: Thu, 2 May 2013 13:31:49 -0400
Message-ID: <5182A305.6000504@ti.com>
References: <1367008557-12443-1-git-send-email-srinivas.pandruvada@linux.intel.com> <517AEFC0.2010301@ti.com> <517B0E9D.6000904@linux.intel.com> <5181F0A3.90005@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2POFXJJODVGKOVTHVNOXS"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33418 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432Ab3EBRcE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 May 2013 13:32:04 -0400
In-Reply-To: <5181F0A3.90005@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-acpi@vger.kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org

------enig2POFXJJODVGKOVTHVNOXS
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Srivinas,

On 02-05-2013 00:50, Srinivas Pandruvada wrote:
> Hi Valentin,
>=20
> Any further thoughts?

Yeah,

>=20
> Thanks,
> Srinivas
>=20
> On 04/26/2013 04:32 PM, Srinivas Pandruvada wrote:
>> Hi Valentin,
>>
>> I planned to use that before , but it will change the semantics here.
>>
>> - Here comparison is using a case in-sensitive version, sysfs_streq is=

>> case sensitive.

Indeed. That changes the semantics. On the other hand, I do not see why
we need to be case in-sensitive. Depending on how you see this, it might
infringe the sysfs rules. Besides, I am favor to have 1 to 1 relation
between array of chars and their meaning.

On the other hand, changing the semantics might break userland. I
personally do not have any userland application that uses this sysfs
nodes. Neither I am aware of any. But I request Rui and Durga s opinions
here.

>> - I am not sure if there is any protection for length. If we pass a
>> more than THERM_NAME_LENGTH string, then whether sysfs_streq can
>> handle. so we need to pre-check for length.

sysfs_streq does not check for length, only for string ending char and
CRLF. In fact we would need to check for string ending before using it.

Side note, I believe we might consider the following:
diff --git a/lib/string.c b/lib/string.c
index e5878de..b83eee7 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -522,7 +522,7 @@ EXPORT_SYMBOL(strsep);
  */
 bool sysfs_streq(const char *s1, const char *s2)
 {
-       while (*s1 && *s1 =3D=3D *s2) {
+       while (*s1 && *s2 && *s1 =3D=3D *s2) {
                s1++;
                s2++;
        }


>> - some stupid echo command with CRLF, will still fail

sure about that? sysfs_streq() was actually introduced to avoid it. If
yes, then we have a bug on it.

>> I see that some other syfs string write (eg. cpufreq.c) decided not to=

>> use sysfs_streq, may be historical.
>>

yeah, maybe. But have you git greped for sysfs_streq()?

Obviously, your patch provides more protection. On the other hand, I
believe we need to check if we fix this locally or if we need to fix
sysfs_streq() too. Providing a sysfs_strneq() would also be a good thing.=


>> Thanks,
>> Srinivas
>>
>>
>> On 04/26/2013 02:21 PM, Eduardo Valentin wrote:
>>> Hello Srinivas,
>>>
>>> On 26-04-2013 16:35, Srinivas Pandruvada wrote:
>>>> Setting policy results in invalid value error.
>>>>     >echo "step_wise" > policy
>>>>     >echo: write error: Invalid argument
>>>>
>>>> Need clean up of the buffer which "echo" may add based on the
>>>> arguments, before comparing aganist list of governor names.
>>>>
>>>> Signed-off-by: Srinivas Pandruvada
>>>> <srinivas.pandruvada@linux.intel.com>
>>>> ---
>>>>   drivers/thermal/thermal_core.c | 19 +++++++++++++++----
>>>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/thermal_core.c
>>>> b/drivers/thermal/thermal_core.c
>>>> index 4cdc3e3..ed6904f 100644
>>>> --- a/drivers/thermal/thermal_core.c
>>>> +++ b/drivers/thermal/thermal_core.c
>>>> @@ -696,16 +696,27 @@ static ssize_t
>>>>   policy_store(struct device *dev, struct device_attribute *attr,
>>>>               const char *buf, size_t count)
>>>>   {
>>>> -    int ret =3D -EINVAL;
>>>> +    int ret;
>>>>       struct thermal_zone_device *tz =3D to_thermal_zone(dev);
>>>>       struct thermal_governor *gov;
>>>> +    char str_gov[THERMAL_NAME_LENGTH];
>>>> +    char format[6]; /* enough for 3 digit format width */
>>>> +
>>>> +    ret =3D snprintf(format, sizeof(format), "%%%ds",
>>>> +                    THERMAL_NAME_LENGTH - 1);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +    ret =3D sscanf(buf, format, str_gov);
>>>> +    if (ret <=3D 0)
>>>> +        return -EINVAL;
>>>
>>>
>>> Is this due to trainling \n? Why not using sysfs_streq()? I believe
>>> it is better approach. Can you please check if the following solves
>>> the issue?
>>>
>>> https://gitorious.org/thermal-framework/thermal-framework/commit/810a=
33a629b40adfa92a164883281bbdfad80516
>>>
>>>
>>> commit 810a33a629b40adfa92a164883281bbdfad80516
>>> Author: Eduardo Valentin <eduardo.valentin@ti.com>
>>> Date:   Fri Apr 26 17:12:30 2013 -0400
>>>
>>>     thermal: better string treatment while finding governors
>>>
>>>     To avoid returning error value just because of trailing
>>>     \n, this patch changes the function to find governors
>>>     by name to use sysfs_streq().
>>>
>>>     Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>>
>>> diff --git a/drivers/thermal/thermal_core.c
>>> b/drivers/thermal/thermal_core.c
>>> index f36cd44..08ea62c 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -58,7 +58,7 @@ static struct thermal_governor
>>> *__find_governor(const char *name)
>>>         struct thermal_governor *pos;
>>>
>>>         list_for_each_entry(pos, &thermal_governor_list, governor_lis=
t)
>>> -               if (!strnicmp(name, pos->name, THERMAL_NAME_LENGTH))
>>> +               if (sysfs_streq(name, pos->name))
>>>                         return pos;
>>>
>>>         return NULL;
>>>
>>>>
>>>>       mutex_lock(&thermal_governor_lock);
>>>>
>>>> -    gov =3D __find_governor(buf);
>>>> -    if (!gov)
>>>> +    gov =3D __find_governor(str_gov);
>>>> +    if (!gov) {
>>>> +        ret =3D -EINVAL;
>>>>           goto exit;
>>>> -
>>>> +    }
>>>>       tz->governor =3D gov;
>>>>       ret =3D count;
>>>>
>>>>
>>>
>>>
>>
>>
>=20
>=20
>=20



------enig2POFXJJODVGKOVTHVNOXS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGCowUACgkQCXcVR3XQvP0ApAEAkb83+5RvgaDNl+JVmqvd1vpj
aOXv98WU3VP51vgYlmwBAOyfVT+XmUVaPpJKmLHm+1JmTsphKT1SdVLhdi/hr7Ws
=kh/J
-----END PGP SIGNATURE-----

------enig2POFXJJODVGKOVTHVNOXS--
