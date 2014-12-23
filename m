From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH v2 00/17] thermal: exynos: Thermal code rework to use
 device tree
Date: Tue, 23 Dec 2014 20:57:38 +0530
Message-ID: <CAM4voam14GOE2u1KaRubsrVGBPcWibOQBeibyM=C6SrBFjuiWg@mail.gmail.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
	<1418213396-743-1-git-send-email-l.majewski@samsung.com>
	<20141210102712.GA2919@developer>
	<20141210151925.61a0b091@amdc2363>
	<CAM4voakxJPjfGu3gkpCbDS+SY1TP39Of+0ed=5jS55ARn95pYg@mail.gmail.com>
	<20141222172133.6e69fc21@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141222172133.6e69fc21@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On Mon, Dec 22, 2014 at 9:51 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Abhilash,
>
>> Hi Lukasz and Eduardo,
>>
>> [...]
>> >
>> > Although, this shouldn't be a problem.
>> >
>> >> That is why we had the cycle with cpufreq folks, remember?
>> >>
>> >> (I will have a look in your patches)
>> >
>> > It would be great if those patches could find their way to therma
>> > -next. Then also Abhilash could benefit from them.
>>
>> I have a couple of 5420/5800 based chromebooks that I will test this
>> series on. Is it OK for me to start basing my Exynos7 TMU support on
>> this series ? Please let me know if I can help in any other way with
>> this.
>
> I'm fine if you rebase on top of my patches.
>
> However, it is up to Eduardo when he decides to pull them to -next
> branch.
>
> I hope that it will happen soon.

I tested a Peach Pit (5420 based chromebook) with your patches and
they work well (temperatures and software tripping). However, my
earlier comments with regards to duplicate exynos_tmu_initialize() and
the thermal zone showing as disabled in sysfs .

Also, I think the documentation for the dt properties are missing ?

I will post my exynos7 work based on your patches soon. Please take a look.

Regards,
Abhilash
>
>>
>> Regards,
>> Abhilash
>
>
>
> --
> Best regards,
>
> Lukasz Majewski
>
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
