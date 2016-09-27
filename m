From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Subject: Re: [PATCH 1/3] mfd: max77693: Add defines for charger current control
Date: Tue, 27 Sep 2016 15:54:04 +0200
Message-ID: <8760phwirn.fsf@machinist.wiedmeyer.de>
References: <20160927080646.GB4394@kozik-lap>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from wiedmeyer.de ([85.116.192.112]:57124 "EHLO wiedmeyer.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932309AbcI0NyV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Sep 2016 09:54:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by wiedmeyer.localdomain (Postfix) with ESMTP id 5B1398E91D7
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2016 15:54:19 +0200 (CEST)
Received: from wiedmeyer.de ([127.0.0.1])
        by localhost (wiedmeyer.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L6z11YHa1nmT for <linux-pm@vger.kernel.org>;
        Tue, 27 Sep 2016 15:54:17 +0200 (CEST)
In-reply-to: <20160927080646.GB4394@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com, broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Krzysztof Kozlowski writes:

> On Tue, Sep 27, 2016 at 01:31:08AM +0200, Wolfgang Wiedmeyer wrote:
>> This prepares for an updated regulator and charger driver. The defines
>> are needed to set the maximum input current and the fast charge
>> current.
>>=20
>> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
>
> This shouldn't be separate patch, because:
> 1. You are touching later power and regulator so this patch should be
> applied to one and then pulled by other... a lot of unneeded work.
> 2. It is difficult to find which new code is needed for which driver.
>
> Simpler approach might work - when changing the regulator or psy driver,
> just change the header as needed. Unless there are conflicts and both of
> them need the same?

No, no conflicts. I will change the header as needed and won't do a
separate patch.

Thanks,
Wolfgang

> Best regards,
> Krzysztof
>
>> ---
>>  include/linux/mfd/max77693-private.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>=20
>> diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/ma=
x77693-private.h
>> index 3c7a63b..ca18344 100644
>> --- a/include/linux/mfd/max77693-private.h
>> +++ b/include/linux/mfd/max77693-private.h
>> @@ -222,6 +222,9 @@ enum max77693_charger_battery_state {
>>  #define CHG_CNFG_00_CHG_MASK		0x1
>>  #define CHG_CNFG_00_BUCK_MASK		0x4
>>=20=20
>> +/* MAX77693 CHG_CNFG_02 register */
>> +#define CHG_CNFG_02_CC_MASK		0x3F
>> +
>>  /* MAX77693_CHG_REG_CHG_CNFG_01 register */
>>  #define CHG_CNFG_01_FCHGTIME_SHIFT	0
>>  #define CHG_CNFG_01_CHGRSTRT_SHIFT	4
>> @@ -258,6 +261,10 @@ enum max77693_charger_battery_state {
>>=20=20
>>  /* MAX77693 CHG_CNFG_09 Register */
>>  #define CHG_CNFG_09_CHGIN_ILIM_MASK	0x7F
>> +#define CHG_CNFG_09_CHGIN_ILIM_500_MAX	500000
>> +#define CHG_CNFG_09_CHGIN_ILIM_500_MIN	470000
>> +#define CHG_CNFG_09_CHGIN_ILIM_0_MAX	60000
>> +#define CHG_CNFG_09_CHGIN_ILIM_0_MIN	0
>>=20=20
>>  /* MAX77693 CHG_CTRL Register */
>>  #define SAFEOUT_CTRL_SAFEOUT1_MASK	0x3
>> --=20
>> 2.8.0.rc3
>>=20


=2D-=20
Website: https://fossencdi.org
OpenPGP: 0F30 D1A0 2F73 F70A 6FEE  048E 5816 A24C 1075 7FC4
Key download: https://wiedmeyer.de/keys/ww.asc

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX6nn8AAoJEFgWokwQdX/E/KYP/Rz4xSSAfILaBY7lnqhOXOKM
J7kykJd/NdqlCMpvjrXrcAho8pzTDjZGU33+A2SKHXiaohKCR4EZ1Y0tToiiK42A
TdxEjAYrYT0lgpf5f0CTKl59UthaLUhInVEy62m4gNpyLgksD7LoskMQQ64n0k9E
sjSNkP++rSYGJntVjPdP7qL6E62mxfh+Hzv14JqzWj9fS1nlLBkxc2yaHENxw2gG
WIPPeLMVOMho3e3fUtipRGrsF0+rxs15BRF4ImkIUGNcEORZtxQBxqyMfIPtSQfb
aXBlpGJFp1t8kzu1kwmmKRuM7JEDdtvr8K9F2zikJz1A6A5F3JA6WqvT2bOTvEy0
gqgX6+a5Z5yFYSMJu408ZMo0Cfnq7KYrll3j+JW/BQfmYeU2f219RU+4zPhMyvLw
kd9KyjnDa0ve7c4XvyYg2DD/X6aq2obRfw/WJ8mXb50xuIRzBGXCt+67TUTuDok3
mhSe8VU7R75ZHWK6HDjBIP1/M1tsKT8WJtejZnmRKMeshvc4OQ5Fw+aVCIBHI3zQ
r2lzGnaz3Er70cFDNTF5LwMj9wl0WFEh1qKJv83P+NBeyxmH9H3elh5tp5y6z3tE
BLbS+k5ZMCe2l3mFiB4JlzRw1kgFoNedaih1vITHo2U/1ET5m1s7nC/06ynZvYNE
NAn65g8quBrIDlQm1pz7
=QHEH
-----END PGP SIGNATURE-----
--=-=-=--
