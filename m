From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM: after suspend/resume the system,can not suspends again
Date: Mon, 16 Nov 2015 22:12:59 +0100
Message-ID: <CAPDyKForCz9MjwYUvMdmR1hJD_+rA9Be09sMPyxfAZsE_HuT2g@mail.gmail.com>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
	<87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
	<56417D61.80407@jinso.co.jp>
	<56499E53.2050905@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <56499E53.2050905@jinso.co.jp>
Sender: linux-sh-owner@vger.kernel.org
To: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Cc: Nguyen Viet Dung <nv-dung@jinso.co.jp>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Sakato Ryusuke <ryusuke.sakato.bx@renesas.com>
List-Id: linux-pm@vger.kernel.org

On 16 November 2015 at 10:13, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
> Dear Ulf Hansson,
>
> I am Hiep from Jinzai Solution (a Japanese Company)
> We have tested PM driver on Rcar-Gen2 (Lager, Koelsch Board) at Linux v4.3.
>
> I would like to contact you because we found a patch that relate to a PM bug
> :
>
> After Suspend/resume system one time, we can not suspend the system again!.
> (I attach the test log file)
>
> The patch is show as below:
> a98f1b7 PM / Domains: Fix validation of latency constraints in genpd
> governor
>
> Tested-by: Harunaga <nx-truong@jinso.co.jp>
> Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
>
> This problem disapeared if revert this patch.
> Please review it, when you have time!

Thanks for reporting and bisecting!

I had a look and I believe have found the cause of the problem, though
I will need a few days to post a fix for it.

The problem is actually in genpd's ->runtime_suspend() callback, as it
validates PM QoS latencies even when it's being invoked from the
system PM path.
I will post a fixup to genpd in the next couple of days. I would
appreciate if you could help out in testing it.

Kind regards
Uffe
