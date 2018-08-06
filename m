From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v8 09/26] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
Date: Mon, 6 Aug 2018 11:37:55 +0200
Message-ID: <CAJZ5v0hk1wfm10fyycmddKF6wR4D51r30fD_-J5UDMbtB3+V-Q@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <2056372.NMt4aPaF4h@aspire.rjw.lan> <2205807.cU2puvubpP@aspire.rjw.lan>
 <1726374.375PCQfjLZ@aspire.rjw.lan> <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 3, 2018 at 1:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>>
>>> Assuming that I have got that right, there are concerns, mostly regarding
>>> patch [07/26], but I will reply to that directly.
>>
>> Well, I haven't got that right, so never mind.
>>
>> There are a few minor things to address, but apart from that the general
>> genpd patches look ready.
>
> Alright, thanks!
>
> I will re-spin the series and post a new version once 4.19 rc1 is out.
> Hopefully we can queue it up early in next cycle to get it tested in
> next for a while.
>
>>
>>> The $subject patch is fine by me by itself, but it obviously depends on the
>>> previous ones.  Patches [01-02/26] are fine too, but they don't seem to be
>>> particularly useful without the rest of the series.
>>>
>>> As far as patches [10-26/26] go, I'd like to see some review comments and/or
>>> tags from the people with vested interest in there, in particular from Daniel
>>> on patch [12/26] and from Sudeep on the PSCI ones.
>>
>> But this still holds.
>
> Actually, patch 10 and patch11 is ready to go as well. I ping Daniel
> on patch 12.
>
> In regards to the rest of the series, some of the PSCI/ARM changes
> have been reviewed by Mark Rutland, however several changes have not
> been acked.
>
> On the other hand, one can also interpret the long silence in regards
> to PSCI/ARM changes as they are good to go. :-)

Well, in that case giving an ACK to them should not be an issue for
the people with a vested interest I suppose.
