From: Minkyu Kang <promsoft@gmail.com>
Subject: Re: [PATCH v2] add MAX17040 Fuel Gauge driver
Date: Thu, 4 Jun 2009 19:55:13 +0900
Message-ID: <1f3430fb0906040355y21d5c8d1u4133dd8f7f4e9d70__17024.1885156885$1244113055$gmane$org@mail.gmail.com>
References: <4A278C08.5000206@samsung.com>
	<5d5443650906040216h2314b7bbt1ae2e89c709b566e@mail.gmail.com>
	<20090604113504.5370775b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090604113504.5370775b@hyperion.delvare>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Anton Vorontsov <cbou@mail.ru>, linux-pm@lists.linux-foundation.org, Minkyu Kang <mk7.kang@samsung.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Dear, Jean Delvare

>
> In case of error, this will wrap the error code into a u8 and the
> caller won't notice. So you'll return a random value, depending on the
> actual error which happened. No good.
>
> You should either return an int there, and have the caller check for
> errors, or if you don't want to care about errors, return an arbitrary
> value on error (e.g. 0.)
>

Yes, I missed it.

>> > + =A0 =A0 =A0 ret =3D power_supply_register(&client->dev, &bat_ps);
>> > + =A0 =A0 =A0 if (ret) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&max17040->client->dev,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed:=
 power supply register\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&chip->work);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(chip);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max17040 =3D NULL;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>
> Please come up with a better error code.
>

Ok, many thanks :)

-- =

from. prom.
promsoft.net
