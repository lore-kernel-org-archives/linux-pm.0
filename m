From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/10] OPP: Support multiple power-domains per device
Date: Mon, 16 Jul 2018 11:04:22 +0200
Message-ID: <CAPDyKFriy50XL6O0=4TUremONNqrWUDa5Sm3tzqhnuRMc=BArw@mail.gmail.com>
References: <cover.1530252803.git.viresh.kumar@linaro.org> <20180716043203.gyedmithp4xa7p3u@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716043203.gyedmithp4xa7p3u@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 16 July 2018 at 06:32, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 29-06-18, 11:49, Viresh Kumar wrote:
>> Hi,
>>
>> This series improves the OPP core (and a bit of genpd core as well) to
>> support multiple phandles in the "required-opps" property, which are
>> only used for multiple power-domains per device for now.
>>
>> We still don't propagate the changes to master domains for the
>> sub-domains, but this patchset is an important stepping stone for that
>> to happen.
>>
>> Tested on Hikey960 after faking some power domains for CPUs.
>
> Ulf, can you please help review this stuff ?

I am in holiday mode, so I needs some more time before I can review
this. Apologize for the inconvenience.

Kind regards
Uffe
