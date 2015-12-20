From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH v3 2/5] thermal: rockchip: fix a impossible condition
 caused by the warning
Date: Sun, 20 Dec 2015 15:50:12 +0800
Message-ID: <56765DB4.5070901@gmail.com>
References: <1449132523-18817-1-git-send-email-wxt@rock-chips.com> <1449132523-18817-3-git-send-email-wxt@rock-chips.com> <20151203201908.GA34901@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151203201908.GA34901@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, huangtao@rock-chips.com, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, dianders@chromium.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, computersforpeace@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-pm@vger.kernel.org



=E5=9C=A8 2015=E5=B9=B412=E6=9C=8804=E6=97=A5 04:19, Dmitry Torokhov =E5=
=86=99=E9=81=93:
> On Thu, Dec 03, 2015 at 04:48:40PM +0800, Caesar Wang wrote:
>> As the Dan report the smatch check the thermal driver warning:
>> drivers/thermal/rockchip_thermal.c:551 rockchip_configure_from_dt()
>> warn: impossible condition '(thermal->tshut_temp > ((~0 >> 1))) =3D>
>> (s32min-s32max > s32max)'
>>
>> Let's we remove the imposssible condition Since the Temperature is
>> currently represented as int not long in the thermal driver.
>>
>> Fixes: commit 437df2172e8d
>> ("thermal: rockchip: consistently use int for temperatures")
>>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>
>> ---
>>
>> Changes in v3:
>> - As Brian comments on https://patchwork.kernel.org/patch/7580661/,
>>    let's remove the impossible condition.
>>
>> Changes in v2: None
>> Changes in v1: None
>>
>>   drivers/thermal/rockchip_thermal.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/ro=
ckchip_thermal.c
>> index ae796ec..611de00 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -549,12 +549,6 @@ static int rockchip_configure_from_dt(struct de=
vice *dev,
>>   		thermal->tshut_temp =3D shut_temp;
>>   	}
>>  =20
>> -	if (thermal->tshut_temp > INT_MAX) {
>> -		dev_err(dev, "Invalid tshut temperature specified: %d\n",
>> -			thermal->tshut_temp);
>> -		return -ERANGE;
>> -	}
> Well, that is not entirely correct. The value that we read from DT is
> u32, but we convert it down to int. I believe you want to move the ch=
eck
> up so that you do:
>
> 	} else if (tshut_temp > INT_MAX) {
> 		dev_err(dev, "Invalid tshut temperature specified: %d\n",
> 			thermal->tshut_temp);
> 		return -ERANGE;
> 	} else {
> 		thermal->tshut_temp =3D shut_temp;
> 	}

Okay,
that's seem the following wll be resonable since the checkcode is a war=
ning.

if (of_property_read_u32(np, "rockchip,hw-tshut-temp", &shut_temp)) {
         dev_warn(dev,
              "Missing tshut temp property, using default %d\n",
              thermal->chip->tshut_temp);
         thermal->tshut_temp =3D thermal->chip->tshut_temp;
     } else {
         if (tshut_temp > INT_MAX) {
             dev_err(dev, "Invalid tshut temperature specified: %d\n",
                 tshut_temp);
             return -ERANGE;
         }
         thermal->tshut_temp =3D shut_temp;
     }

Thanks,


> Thanks.
>
