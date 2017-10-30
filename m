From: Edward Statham <edward.statham@gmail.com>
Subject: Re: CPU frequency governor problem
Date: Tue, 31 Oct 2017 11:15:37 +1300
Message-ID: <CAMn+H1v2PpGrR6qp54R9g7gOdYCEF7PJUN_9ySgV+UgdQdPNOA@mail.gmail.com>
References: <CAMn+H1sk267Er5zS2jRmDUE_s+f8Fguq8K40ZpDQG656LcLnBg@mail.gmail.com>
 <CAOh2x==Wtv2o2cVST2hRMqXn76NC+P3hN0HnYKukHLiLPVws5w@mail.gmail.com> <CAMn+H1skVF-Y-u=6vZeGcshmkOZcLnQf3_K=gvGaGO6uQBCSVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:49041 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753302AbdJ3WPi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Oct 2017 18:15:38 -0400
Received: by mail-vk0-f43.google.com with SMTP id g69so9128504vke.5
        for <linux-pm@vger.kernel.org>; Mon, 30 Oct 2017 15:15:37 -0700 (PDT)
In-Reply-To: <CAMn+H1skVF-Y-u=6vZeGcshmkOZcLnQf3_K=gvGaGO6uQBCSVQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

I have more details on this problem. I have a laptop that is prone to
overheating.
I have now fitted 3 external fans, and the problem has considerably
lessened - the max frequency is lowered but when the core temp drops
back
then it re-scales up to max again.
However - if the "no_turbo" flag is set true then it sticks there on
70% max (sometimes 50%) and no_turbo=3D1 and stays there
regardless of subsequent core temp. Only a reboot clears it.

HTH


On 22 August 2017 at 12:12, Edward Statham <edward.statham@gmail.com> wrote=
:
> Some further info - the same behavior occurs with the powersave governor.
> It just locks at a low frequency, disables turbo and stays there.
>
> Immediately after reboot:
>
> System:    Host: ed-P35V7 Kernel: 4.11.0-14-generic x86_64 (64 bit gcc: 5=
.4.0)
>            Desktop: Cinnamon 3.4.6 (Gtk 3.18.9-1ubuntu3.3) Distro:
> Linux Mint 18.2 Sonya
> Machine:   Mobo: GIGABYTE model: P35V7 v: Default string Bios:
> American Megatrends v: FB02 date: 11/29/2016
> CPU:       Quad core Intel Core i7-7700HQ (-HT-MCP-) cache: 6144 KB
>            flags: (lm nx sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx) bmips: 22=
464
>            clock speeds: max: 3800 MHz 1: 799 MHz 2: 799 MHz 3: 799
> MHz 4: 799 MHz 5: 799 MHz 6: 799 MHz
>            7: 799 MHz 8: 799 MHz
> Graphics:  Card-1: Intel Device 591b bus-ID: 00:02.0
>            Card-2: NVIDIA Device 1ba1 bus-ID: 01:00.0
>            Display Server: X.Org 1.18.4 driver: nvidia Resolution:
> 1920x1080@59.93hz
>            GLX Renderer: GeForce GTX 1070/PCIe/SSE2 GLX Version: 4.5.0
> NVIDIA 384.59 Direct Rendering: Yes
> Audio:     Card Intel Sunrise Point-H HD Audio driver: snd_hda_intel
> bus-ID: 00:1f.3
>            Sound: Advanced Linux Sound Architecture v: k4.11.0-14-generic
> Network:   Card-1: Realtek RTL8111/8168/8411 PCI Express Gigabit
> Ethernet Controller
>            driver: r8169 v: 2.3LK-NAPI port: d000 bus-ID: 02:00.0
>            IF: enp2s0 state: up speed: 1000 Mbps duplex: full mac: <filte=
r>
>            Card-2: Intel Wireless 8260 driver: iwlwifi bus-ID: 04:00.0
>            IF: wlp4s0 state: down mac: <filter>
> Drives:    HDD Total Size: 1000.2GB (17.7% used) ID-1: /dev/nvme0n1
> model: N/A size: 512.1GB
>            ID-2: /dev/sda model: HGST_HTS721010A9 size: 1000.2GB
> Partition: ID-1: / size: 30G used: 11G (37%) fs: ext4 dev: /dev/nvme0n1p1
>            ID-2: /home size: 184G used: 54G (31%) fs: ext4 dev: /dev/nvme=
0n1p6
>            ID-3: swap-1 size: 32.00GB used: 0.00GB (0%) fs: swap dev:
> /dev/nvme0n1p5
> RAID:      No RAID devices: /proc/mdstat, md_mod kernel module present
> Sensors:   System Temperatures: cpu: 53.5C mobo: 29.8C gpu: 0.0:65C
>            Fan Speeds (in rpm): cpu: N/A
> Info:      Processes: 376 Uptime: 4 min Memory: 4053.5/32055.0MB Init:
> systemd runlevel: 5 Gcc sys: 5.4.0
>            Client: Shell (bash 4.3.481) inxi: 2.2.35
>
> On 16 August 2017 at 15:18, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Adding PM list instead.
>>
>> On Tue, Aug 15, 2017 at 8:17 AM, Edward Statham
>> <edward.statham@gmail.com> wrote:
>>> Hi, sorry for the direct email but I=E2=80=99ve been unable to find a r=
esolution
>>> to this in forums etc.  I have a laptop with a Intel i7-7700HQ CPU and =
am
>>> running Linux Mint 18.  The frequency governor is set to performance bu=
t
>>> it keeps on throttling down to 70% or even 50% and getting stuck there,
>>> for example:
>>>
>>> cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
>>> 70
>>>
>>> I can=E2=80=99t find a way to get it to throttle sensibly i.e. lower th=
e max
>>> when required but revert to full speed when other conditions allow. I=
=E2=80=99ve
>>> tried the ondemand and performance governors.
>>>
>>> Any suggestions would be much appreciated.
>>>
>>> thanks,
>>> Ed
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
