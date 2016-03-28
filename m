From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v6 2/4] power: reset: add reboot mode driver
Date: Mon, 28 Mar 2016 15:40:29 +0800
Message-ID: <56F8DFED.50905@rock-chips.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
 <1458646642-591-1-git-send-email-andy.yan@rock-chips.com>
 <CAJKOXPcKzGTAicbsXK-cC9WQT0vBhpSG_q2GCn37+72x2hdhsQ@mail.gmail.com>
 <56F39F36.5050702@rock-chips.com> <56F8D078.6040503@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56F8D078.6040503@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, olof@lixom.net, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, f.fainelli@gmail.com, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, linux-kernel@vger.kernel.org, wxt@rock-chips.com, dwmw2@infradead.org, mark.rutland@arm.com
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof :

On 2016=E5=B9=B403=E6=9C=8828=E6=97=A5 14:34, Krzysztof Kozlowski wrote=
:
> On 24.03.2016 17:03, Andy Yan wrote:
>> Hi Krzystof:
> (...)
>
>>>> +static int get_reboot_mode_magic(struct reboot_mode_driver *reboo=
t,
>>>> +                                const char *cmd)
>>>> +{
>>>> +       const char *normal =3D "normal";
>>>> +       int magic =3D 0;
>>>> +       struct mode_info *info;
>>>> +
>>>> +       if (!cmd)
>>>> +               cmd =3D normal;
>>>> +
>>>> +       list_for_each_entry(info, &reboot->head, list) {
>>>> +               if (!strcmp(info->mode, cmd)) {
>>>> +                       magic =3D info->magic;
>>>> +                       break;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       return magic;
>>> In absence of 'normal' mode (it is not described as required proper=
ty)
>>> the magic will be '0'. It would be nice to document that in binding=
s.
>>> Imagine someone forgets about this and will wonder why 0x0 is writt=
en
>>> to his precious register on normal reboot...
>>      If the magic value is '0', we won't touch the register, please =
see
>> reboot_mode_notify bellow.
> Ah, indeed... so we cannot use value of '0' for magic (e.g. to clear =
any
> existing value for normal reboot)?

     It seems that the value '0' cannot be used.
>>> It would be nice to document that 'mode-normal' has a special
>>> (hard-coded) meaning.
>>>
>>>> +}
>>>> +
>>>> +static int reboot_mode_notify(struct notifier_block *this,
>>>> +                             unsigned long mode, void *cmd)
>>>> +{
>>>> +       struct reboot_mode_driver *reboot;
>>>> +       int magic;
>>>> +
>>>> +       reboot =3D container_of(this, struct reboot_mode_driver,
>>>> reboot_notifier);
>>>> +       magic =3D get_reboot_mode_magic(reboot, cmd);
>>>> +       if (magic)
>>>> +               reboot->write(magic);
>>>> +
>>>> +       return NOTIFY_DONE;
>>>> +}
>>>> +
>>>> +int reboot_mode_register(struct device *dev, int (*write)(int))
>>>> +{
>>>> +       struct reboot_mode_driver *reboot;
>>>> +       struct mode_info *info;
>>>> +       struct property *prop;
>>>> +       size_t len =3D strlen(PREFIX);
>>>> +       int ret;
>>>> +
>>>> +       reboot =3D devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
>>>> +       if (!reboot)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       reboot->write =3D write;
>>>> +       INIT_LIST_HEAD(&reboot->head);
>>>> +       for_each_property_of_node(dev->of_node, prop) {
>>>> +               if (len > strlen(prop->name) || strncmp(prop->name=
,
>>>> PREFIX, len))
>>>> +                       continue;
>>> New line please for readability.
>>      Okay
>>>> +               info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERN=
EL);
>>>> +               if (!info)
>>>> +                       return -ENOMEM;
>>> Ditto.
>>      Okay
>>>> +               strcpy(info->mode, prop->name + len);
>>> Ehm, and how do you protect that name of mode is shorter than 32
>>> characters?
>>      How about info->mode =3D prop->name + len ?
> I don't get your answer.
> As fair as I read the code, the prop->name can be very long and you a=
re
> copying it from 5 character. If the name of the mode has bazillion
> characters then again my question: how do you protect that it will fi=
t
> in 32 bytes of 'mode'?

     What I mean is set info->mode as a pointer point to prop->name + l=
en

    struct mode_info {
             char *mode;
             ..........
             .........
    }

    info->mode =3D prop->name + len
>
>>>> +               if (of_property_read_u32(dev->of_node, prop->name,
>>>> &info->magic)) {
>>>> +                       dev_err(dev, "reboot mode %s without magic
>>>> number\n",
>>>> +                               info->mode);
>>>> +                       devm_kfree(dev, info);
>>>> +                       continue;
>>>> +               }
>>>> +               list_add_tail(&info->list, &reboot->head);
>>>> +       }
>>>> +       reboot->reboot_notifier.notifier_call =3D reboot_mode_noti=
fy;
>>>> +       ret =3D register_reboot_notifier(&reboot->reboot_notifier)=
;
>>>> +       if (ret)
>>>> +               dev_err(dev, "can't register reboot notifier\n");
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(reboot_mode_register);
>>>> +
>>>> +MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
>>>> +MODULE_DESCRIPTION("System reboot mode driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/drivers/power/reset/reboot-mode.h
>>>> b/drivers/power/reset/reboot-mode.h
>>>> new file mode 100644
>>>> index 0000000..44ed34f
>>>> --- /dev/null
>>>> +++ b/drivers/power/reset/reboot-mode.h
>>>> @@ -0,0 +1,6 @@
>>>> +#ifndef __REBOOT_MODE_H__
>>>> +#define __REBOOT_MODE_H__
>>>> +
>>>> +int reboot_mode_register(struct device *dev, int (*write)(int));
>>> Documentation would be appreciated. Although it is local header but
>>> you decoupled them and you are exporting the function.
>>      I think I should remove the EXPORT_SYMBOL_GPL.
> You need to export symbols which are located in modules. Is it locate=
d
> in module?
>
> Best regards,
> Krzysztof
>
>
>
>
>
