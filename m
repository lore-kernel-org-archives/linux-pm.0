From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/6] PM / Domains: Implement domain performance states
Date: Mon, 16 Jan 2017 22:47:07 +0100
Message-ID: <CAJZ5v0itMc8tQa6pO5DkMH=6Ai-5CFXaMTPov+2D4B3SXmy9bw@mail.gmail.com>
References: <cover.1483439894.git.viresh.kumar@linaro.org> <20170116053007.GA15930@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116053007.GA15930@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 16, 2017 at 6:30 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 03-01-17, 16:36, Viresh Kumar wrote:
>> Hi,
>>
>> An earlier series[1] tried to implement bindings for PM domain
>> performance states. Rob Herring suggested that we can actually write the
>> supporting code first instead of bindings, as that will make things
>> easier to understand for all.
>>
>> The bindings [1] aren't discarded yet and this series is based on a
>> version of those only. The bindings are only used by the last patch,
>> which should not be applied and is only sent for completeness.
>>
>> All other patches can be reviewed/applied whenever the maintainers feel
>> they look good.
>>
>>
>> A brief summary of the problem this series is trying to solve:
>>
>> Some platforms have the capability to configure the performance state of
>> their Power Domains. The performance levels are represented by positive
>> integer values, a lower value represents lower performance state.
>>
>> We decided earlier that we should extend Power Domain framework to
>> support active state power management as well.  The power-domains until
>> now were only concentrating on the idle state management of the device
>> and this needs to change in order to reuse the infrastructure of power
>> domains for active state management.
>>
>> The first 5 patches update the PM domain and QoS frameworks to support
>> that and the last one presents the front end interface to it.
>>
>> All the patches are tested by hacking the OPP core a bit for now.
>
> Ping !

http://marc.info/?l=linux-pm&m=148410629024194&w=2

Pretty please!

I will start processing things when I'm back (which probably means the
end of the next week realistically).

Thanks,
Rafael
