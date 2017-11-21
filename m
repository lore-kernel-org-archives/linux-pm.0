From: Lukasz Luba <llu.ker.dev@gmail.com>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Tue, 21 Nov 2017 16:56:35 +0100
Message-ID: <5A144CB3.50806@gmail.com>
References: <cover.1510735482.git.viresh.kumar@linaro.org> <65fef2a1-d23f-3de2-bd91-021296c3e2f7@arm.com> <20171116152058.GR3257@vireshk-i7> <2810372.fJ2vMN0cWO@aspire.rjw.lan> <20171116234422.GA6141@localhost.localdomain> <878tf5tbfj.fsf@e105922-lin.cambridge.arm.com> <35d3751d-f28d-38c2-02b2-c9980f11c52e@arm.com> <cab738f4-dbbf-e5d8-af51-14bc3219b53e@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cab738f4-dbbf-e5d8-af51-14bc3219b53e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javi Merino <javi.merino@arm.com>
List-Id: linux-pm@vger.kernel.org

On 21/11/17 14:06, Daniel Lezcano wrote:
> On 21/11/2017 12:30, Ionela Voinescu wrote:
>
> [ ... ]
>
>> A DT model would be easy to support with the current code but it would
>> be very inaccurate.
>
> Why ?
>
> [ ... ]
>
Hi all,

The DT solution won't fly, the reason can be found below.

I agree with Ionela and Punit that the Juno board is not
the best platform to test the static power impact on IPA.
In some other platforms the static power can be 50% or more
of the total power, so it cannot be neglected.

These are the issues.
The static power equation is complicated, here is one known to me.
The leakage function is exponentially influenced by current circuit
supply voltage, body-bias and some constants K_{4,5}.

P_{leak} = L_{g}*V_{dd}*K_{3}*e^{K_{4}*V_{dd}}*e^{K_{5}*V_{bs}}+| 
V_{bs}|*I_{Ju}

It can also vary depending on technology (CMOS, FinFET, etc).

It would be really hard to approximate by i.e. a polynomial
function with inputs from DT. One size does not fit all.

The equation can also tell you some interesting things about
the manufacturing process. Exposing such information might be the last
thing the vendors want to.
That's why the vendors might want to implement whole
thermal management in the firmware or skip static power and
rely on IPA adaptation.
They can also use a different api in IPA, when they have some mechanism
to measure power in firmware, it can be feed into IPA.

Anyway, I would recommend to keep it as is, to have a complete
power model in the kernel.
The code without static power routines looks awkward to me.
 From my side - NACK for the patch which removes static power.

Regards,
Lukasz Luba
