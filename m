From: Minkyu Kang <promsoft@gmail.com>
Subject: Re: [PATCH v2] add MAX17040 Fuel Gauge driver
Date: Thu, 4 Jun 2009 19:47:43 +0900
Message-ID: <1f3430fb0906040347m1079def5j7d820e18a9375eaa__29442.6960325383$1244112514$gmane$org@mail.gmail.com>
References: <4A278C08.5000206@samsung.com>
	<5d5443650906040216h2314b7bbt1ae2e89c709b566e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <5d5443650906040216h2314b7bbt1ae2e89c709b566e@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Minkyu Kang <mk7.kang@samsung.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi, Trilok

> Adding linux-i2c mailing list, so not deleting any code.

Ok, I will.

>> +static struct max17040_chip *max17040;
>> +static struct max17040_platform_data *pdata;
>
> May be you want to move this pdata under chip structure.
>
>> +       i2c_set_clientdata(client, chip);
>
> Please add i2c_check_functionality check before doing any smbus
> read/write operations.
>

Ok, that's better.

>> + =A0 =A0 =A0 max17040 =3D chip;
>
> This means that we support only one instance of this chip, right?
>

Yes right.. but, I think that is not a good way.
I'll modify it, too. thanks :)


-- =

from. prom.
promsoft.net
