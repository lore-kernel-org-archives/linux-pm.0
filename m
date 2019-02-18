From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 3/3] PM / devfreq: tegra: remove unneeded variable
Date: Mon, 18 Feb 2019 09:55:43 +0000
Message-ID: <abb56481-0cc7-3d31-2dae-ba602a423811@nvidia.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
 <CGME20190216151918epcas1p25c2971b063cc66981fda6a67a8276585@epcas1p2.samsung.com>
 <20190216151826.11584-4-tiny.windzz@gmail.com>
 <7fe8f9ba-ffcc-55ed-38b0-f37538257c1b@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7fe8f9ba-ffcc-55ed-38b0-f37538257c1b@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, heiko@sntech.de, thierry.reding@gmail.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 18/02/2019 00:38, Chanwoo Choi wrote:
> On 19. 2. 17. =EC=98=A4=EC=A0=84 12:18, Yangtao Li wrote:
>> This variable is not used after initialization, so
>> remove it. And in order to unify the code style,
>> move the location where the dev_get_drvdata is called
>> by the way.
>>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-dev=
freq.c
>> index c59d2eee5d30..c89ba7b834ff 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -573,10 +573,7 @@ static int tegra_governor_get_target(struct devfreq=
 *devfreq,
>>  static int tegra_governor_event_handler(struct devfreq *devfreq,
>>  					unsigned int event, void *data)
>>  {
>> -	struct tegra_devfreq *tegra;
>> -	int ret =3D 0;
>> -
>> -	tegra =3D dev_get_drvdata(devfreq->dev.parent);
>> +	struct tegra_devfreq *tegra =3D dev_get_drvdata(devfreq->dev.parent);
>> =20
>>  	switch (event) {
>>  	case DEVFREQ_GOV_START:
>> @@ -600,7 +597,7 @@ static int tegra_governor_event_handler(struct devfr=
eq *devfreq,
>>  		break;
>>  	}
>> =20
>> -	return ret;
>> +	return 0;
>>  }
>> =20
>>  static struct devfreq_governor tegra_devfreq_governor =3D {
>>
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>=20

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

--=20
nvpublic
