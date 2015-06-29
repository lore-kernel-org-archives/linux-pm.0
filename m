From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFCv4 PATCH 00/34] sched: Energy cost model for energy-aware
 scheduling
Date: Mon, 29 Jun 2015 11:19:35 +0100
Message-ID: <55911BB7.3000804@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>	<5552799E.2060507@nvidia.com>	<20150513134753.GA26396@e105550-lin.cambridge.arm.com> <CAEZQSscFKoang2X4E82xSXddcij=Ym5wyLGDLZwiwy5czJqAZg@mail.gmail.com> <OF2A9F9D14.FDD9C66B-ON48257E73.003184BC-48257E73.0031FA3D@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF2A9F9D14.FDD9C66B-ON48257E73.003184BC-48257E73.0031FA3D@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, Abel Vesa <abelvesa@linux.com>
Cc: Juri Lelli <Juri.Lelli@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "mturquette@linaro.org" <mturquette@linaro.org>, Peter Boonstoppel <pboonstoppel@nvidia.com>, "peterz@infradead.org" <peterz@infradead.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Sai Gurrappadi <sgurrappadi@nvidia.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "yuyang.du@intel.com" <yuyang.du@intel.com>
List-Id: linux-pm@vger.kernel.org

On 29/06/15 10:06, pang.xunlei@zte.com.cn wrote:
> Hi Abel,
> 
> Abel Vesa <abelvesa@linux.com> wrote 2015-06-29 AM 04:26:31:
>>
>> Re: [RFCv4 PATCH 00/34] sched: Energy cost model for energy-aware 
> scheduling

[...]

>> I wasn't able to determine the cause from the line:
>>
>> 7de5:       49 0f a3 87 00 03 00    bt     %rax,0x300(%r15)
>>
>> Finally, the question I have is: Could this happen because I'm running
>> it from qemu?
>>
>> I hope all this info helps.
> 
> I've met this as well.
> 
> You can try to change "return -1;" in energy_aware_wake_cpu() to "return 
> target_cpu;"
> hope this may help.

Yeah, I also suppose that https://lkml.org/lkml/2015/5/14/330 cures it.

-- Dietmar

[...]
