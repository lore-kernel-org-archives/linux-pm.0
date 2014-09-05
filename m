From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v4 1/4] thermal: rockchip: add driver for thermal
Date: Fri, 05 Sep 2014 08:33:23 +0800
Message-ID: <540904D3.1070004@rock-chips.com>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com> <1409710239-19941-2-git-send-email-caesar.wang@rock-chips.com> <20140904170559.GB10224@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140904170559.GB10224@core.coreip.homeip.net>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, zyw@rock-chips.com, addy.ke@rock-chips.com, zhaoyifeng <zyf@rock-chips.com>
List-Id: linux-pm@vger.kernel.org


=E5=9C=A8 2014=E5=B9=B409=E6=9C=8805=E6=97=A5 01:06, Dmitry Torokhov =E5=
=86=99=E9=81=93:
> Hi Caesar,
>
> On Wed, Sep 03, 2014 at 10:10:36AM +0800, Caesar Wang wrote:
>> +static int rockchip_thermal_remove(struct platform_device *pdev)
>> +{
>> +	struct rockchip_thermal_data *data =3D platform_get_drvdata(pdev);
>> +
>> +	rockchip_thermal_control(data, false);
>> +
>> +	thermal_zone_device_unregister(data->tz);
>> +	cpufreq_cooling_unregister(data->cdev);
>> +	cpufreq_cooling_unregister(data->cdev);
> It looks like we are unregistering the same cooling device one too ma=
ny times.
>
> Thanks.
>
yes,I made a stupid mistake.  Thanks~

--=20
Best regards,
Caesar


