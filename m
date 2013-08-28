From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 3/5] drivers: thermal: make usage of CONFIG_THERMAL_HWMON
 optional
Date: Wed, 28 Aug 2013 09:15:50 -0400
Message-ID: <521DF806.4030900@ti.com>
References: <1377295396-17289-1-git-send-email-eduardo.valentin@ti.com>
 <4832825.8PCMQe7StP@vostro.rjw.lan> <521CEF61.6040504@ti.com>
 <8131326.8QGX41MW6c@vostro.rjw.lan> <1377648836.2335.252.camel@rzhang-lenovo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3684300722018677354=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1377648836.2335.252.camel@rzhang-lenovo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-pm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, Peter Feuerer <peter@piie.net>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <matthew.garrett@nebula.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============3684300722018677354==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mWhQBTIXSPWUdFBXk4Q2HNmMGfgbf8xVc"

--mWhQBTIXSPWUdFBXk4Q2HNmMGfgbf8xVc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 27-08-2013 20:13, Zhang Rui wrote:
> On =E4=BA=8C, 2013-08-27 at 23:17 +0200, Rafael J. Wysocki wrote:
>> On Tuesday, August 27, 2013 02:26:41 PM Eduardo Valentin wrote:
>>> On 23-08-2013 19:08, Rafael J. Wysocki wrote:
>>>> On Friday, August 23, 2013 06:03:14 PM Eduardo Valentin wrote:
>>>>> When registering a new thermal_device, the thermal framework
>>>>> will always add a hwmon sysfs interface.
>>>>>
>>>>> This patch adds a flag to make this behavior optional. Now
>>>>> when registering a new thermal device, the caller needs
>>>>> to say if the hwmon interface is required.
>>>>>
>>>>> In order to keep same behavior as of today, all current
>>>>> calls will by default create the hwmon interface.
>>>>
>>>> Well, instead of modifying all of the callers this way, why don't
>>>> you add new versions taking the additional argument as, for example,=

>>>>
>>>> thermal_zone_device_register_full()
>>>>
>>>> and redefine the old ones as static inline wrappers, for example
>>>>
>>>> static inline struct thermal_zone_device *thermal_zone_device_regist=
er(args)
>>>> {
>>>> 	return thermal_zone_device_register_full(args, true);
>>>> }
>>>>
>>>> ?
>>>
>>> Yeah, that is another way to go and I thought of doing it like that. =
I
>>> just could not come out with a good API naming:
>>>
>>> thermal_zone_device_register_full(all args)
>>>
>>> thermal_zone_device_register(args) /* on hwmon =3D=3D true */
>>> thermal_zone_device_register_no_hwmon(args) /* on hwmon =3D=3D false =
*/
>>>
>>> Would this sound reasonable naming?
>>
>> Yeah, sounds good to me.
>>
> Well, actually, Tianyu is working on a patch set to move all the
> thermal_zone_device_register() parameters to struct thermal_zone_params=
=2E
>=20
> But with that patch set done, what you need to do next is just to
> introduce a new field in struct thermal_zone_params and make sure 0
> means registering hwmon sysfs I/F.

Rui,

Do you have a pointer to his patch?

>=20
> thanks,
> rui
>=20
>> Thanks,
>> Rafael
>>
>=20
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--mWhQBTIXSPWUdFBXk4Q2HNmMGfgbf8xVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlId+AoACgkQCXcVR3XQvP2kqQD+Pw7guXqGlaKBfZxUlPAxmFpO
0FpvSYqnSqGxrvIY10EA/jw72f7Ssk7xDeg14e8VfJi3M0jNbGQSm9w8sIVcH2QW
=lOEf
-----END PGP SIGNATURE-----

--mWhQBTIXSPWUdFBXk4Q2HNmMGfgbf8xVc--


--===============3684300722018677354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3684300722018677354==--
