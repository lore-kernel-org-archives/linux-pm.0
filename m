From: Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v2] cpufreq: rockchip: add driver
Date: Thu, 24 Mar 2016 23:09:28 +0800
Message-ID: <56F40328.5090001@rock-chips.com>
References: <1458647848-48999-1-git-send-email-xf@rock-chips.com>
 <1458699487-58470-1-git-send-email-xf@rock-chips.com>
 <20160323044033.GQ5272@vireshk-i7> <56F35894.3020106@rock-chips.com>
 <20160324064324.GG22062@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:47695 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbcCXPJA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 11:09:00 -0400
In-Reply-To: <20160324064324.GG22062@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Feng Xiao <xf@rock-chips.com>
Cc: linux@arm.linux.org.uk, heiko@sntech.de, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com

Hi Viresh,

can we add a of_match_table with a common compatible name as follows ?

--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -470,10 +470,16 @@ static int dt_cpufreq_remove(struct=20
platform_device *pdev)
         cpufreq_unregister_driver(&dt_cpufreq_driver);
         return 0;
  }
+static const struct of_device_id dt_cpufreq_of_match[] =3D {
+       { .compatible =3D "***,***", },
+       { }
+};
+MODULE_DEVICE_TABLE(of, dt_cpufreq_of_match);
  static struct platform_driver dt_cpufreq_platdrv =3D {
         .driver =3D {
                 .name   =3D "cpufreq-dt",
+               .of_match_table =3D dt_cpufreq_of_match,
         },

--- a/arch/arm64/boot/dts/rockchip/rk3366.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3366.dtsi
+       cpufreq {
+               compatible =3D "***,***";
+       }

Does it create a DT node for a dummy device too ?


=E5=9C=A8 2016/3/24 14:43, Viresh Kumar =E5=86=99=E9=81=93:
> On 24-03-16, 11:01, Feng Xiao wrote:
>> hi all,
>>       I found that it could match the cpufreq-dt driver succesfully =
only with
>> the following changes.
>> --- a/arch/arm64/boot/dts/rockchip/rk3366.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3366.dtsi
>> @@ -139,6 +139,10 @@
>>                  };
>>          };
>>
>> +       cpufreq-dt {   //the node name must be cpufreq-dt
>> +               compatible =3D "rockchip,cpufreq";  //  the compatib=
le name is
>> insignificant
>> +       };
>> +
> Its not allowed to create a DT node for a dummy device and so we neve=
r
> followed this way.
>
> I have just sent a patchset and cc'd you:
> "[PATCH 0/3] cpufreq: dt: Create platform device from generic code"
>
> and so this patch shall get replaced now.
>

--=20
=46inley


