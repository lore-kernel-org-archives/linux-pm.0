From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: Bisected 3.12.0-rc1 Laptop screen goes blank during kernelboot
Date: Fri, 27 Sep 2013 09:05:41 +0200
Message-ID: <52452E45.5000501@linaro.org>
References: <523C8238.3000200@xmsnet.nl> <523E51A9.8050609@gmail.com> <5242D734.7020800@linaro.org> <52447A4C.3020000@xmsnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <52447A4C.3020000@xmsnet.nl>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Bruin <jmdebruin@xmsnet.nl>
Cc: Aaron Lu <aaron.lwe@gmail.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Linux-pm mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/26/2013 08:17 PM, Hans de Bruin wrote:

[ ... ]

> todays kernel with problem:
>
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=3Dy
> # CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is not set
> CONFIG_CPU_IDLE_GOV_LADDER=3Dy
> CONFIG_CPU_IDLE_GOV_MENU=3Dy
> # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> CONFIG_INTEL_IDLE=3Dy
>
>
> =3D=3D> /sys/devices/system/cpu/cpuidle/current_driver <=3D=3D
> acpi_idle
>
> =3D=3D> /sys/devices/system/cpu/cpuidle/current_governor_ro <=3D=3D
> menu
>
> [    0.056000] cpuidle: using governor ladder
> [    0.056000] cpuidle: using governor menu
>
>
>
> 3.8.0:
> bash-4.1# tail /sys/devices/system/cpu/cpuidle/*
> =3D=3D> /sys/devices/system/cpu/cpuidle/current_driver <=3D=3D
> acpi_idle
>
> =3D=3D> /sys/devices/system/cpu/cpuidle/current_governor_ro <=3D=3D
> menu
>
> [    1.759857] cpuidle: using governor ladder
> [    1.763849] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK400=
9GA
> BS11 PQ: 0 ANSI: 5
> [    1.767098] cpuidle: using governor menu

Thanks for the detailed information. Could you pastebin you kernel=20
config file or send it to me privately so I can reproduce the problem ?


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
