From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Subject: Re: PM: after suspend/resume the system,can not suspends again
Date: Tue, 17 Nov 2015 10:35:56 +0900
Message-ID: <564A847C.1090406@jinso.co.jp>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>	<87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>	<56417D61.80407@jinso.co.jp>	<56499E53.2050905@jinso.co.jp> <CAPDyKForCz9MjwYUvMdmR1hJD_+rA9Be09sMPyxfAZsE_HuT2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKForCz9MjwYUvMdmR1hJD_+rA9Be09sMPyxfAZsE_HuT2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nguyen Viet Dung <nv-dung@jinso.co.jp>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Sakato Ryusuke <ryusuke.sakato.bx@renesas.com>
List-Id: linux-pm@vger.kernel.org

Dear Ulf Hansson
Thanks for your feedback!

On 2015=E5=B9=B411=E6=9C=8817=E6=97=A5 06:12, Ulf Hansson wrote:
> On 16 November 2015 at 10:13, Cao Minh Hiep <cm-hiep@jinso.co.jp> wro=
te:
>> Dear Ulf Hansson,
>>
>> I am Hiep from Jinzai Solution (a Japanese Company)
>> We have tested PM driver on Rcar-Gen2 (Lager, Koelsch Board) at Linu=
x v4.3.
>>
>> I would like to contact you because we found a patch that relate to =
a PM bug
>> :
>>
>> After Suspend/resume system one time, we can not suspend the system =
again!.
>> (I attach the test log file)
>>
>> The patch is show as below:
>> a98f1b7 PM / Domains: Fix validation of latency constraints in genpd
>> governor
>>
>> Tested-by: Harunaga <nx-truong@jinso.co.jp>
>> Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
>>
>> This problem disapeared if revert this patch.
>> Please review it, when you have time!
> Thanks for reporting and bisecting!
>
> I had a look and I believe have found the cause of the problem, thoug=
h
> I will need a few days to post a fix for it.
>
> The problem is actually in genpd's ->runtime_suspend() callback, as i=
t
> validates PM QoS latencies even when it's being invoked from the
> system PM path.
> I will post a fixup to genpd in the next couple of days. I would
> appreciate if you could help out in testing it.
Please let me know when you post the fixup. I will test it.


Thank you!
Jinso/Cao Minh Hiep.

> Kind regards
> Uffe
>
