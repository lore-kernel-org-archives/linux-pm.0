From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 02/27] PM / Domains: Allow domain power states to be
 read from DT
Date: Wed, 16 Dec 2015 14:36:18 -0700
Message-ID: <20151216213618.GA3342@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-3-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFrZFMfE9XNRS8CpTPXU6fzfY9wv0cn+DTcg=SUnDyUQ0A@mail.gmail.com>
 <566FE652.1030602@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <566FE652.1030602@baylibre.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Marc Titinger <mtitinger@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 15 2015 at 03:07 -0700, Marc Titinger wrote:
>On 10/12/2015 17:53, Ulf Hansson wrote:
>>On 17 November 2015 at 23:37, Lina Iyer <lina.iyer@linaro.org> wrote:

>>>Similarly, devices can register power-states into the cluster domain, in
>>>a manner consistent with idle-states.
>>
>>I don't get this. Can you please elaborate?
>
>
>Alexes addition of "power states" to the power domains was to have a 
>better representation of features of power controllers. For instance 
>QoS may prevent to enter/exit complete power-off, but setting the core 
>voltage to say 0.7v is feasible in terms of timing, and still better 
>than full-power-on etc... Hence the domain has a list of possible 
>states to chose upon, between full power-on and full-power-off, and 
>genpd will call the platform code for this.
>
>Now, this patch maps the idle-states as possible power states for the 
>domain: upon the last CPU runtime_put, the domain can chose the 
>deepest
>state that can be reached given the enter/exit time available, and 
>call the platform code for this. This selected state can be any of:
>* cluster-sleep (power OFF)
>* cluster-retention A (L2RAM retention for instance)
>* cluster-retention B (some device is still on, like PMU or bus 
>analyzer, healthckeck IP etc...)
>...
>* cluster-on, but lower voltage A
>* cluster-on, but lower voltage B
>etc...
>
>Put short: CPUs, like any other devices in the domain may register a 
>power state.
>
>>
>>>
>>>This is a attempt to address device-retention states for devices that
>>>are not hooked to runtime-pm, but feature a retention state handled by
>>>the same firmware that handles idle-states. For instance a L2 caches.
>>
>>I guess whether devices may use runtime PM or not, they still can be
>>attached to a PM domain with multiple power states?
>
>yes.
>
>From what I understand, it seems like you want to have a constraint on a
domain state based on the device's idle state. This seems more like a
job for a governor. You could write a governor that chooses the domain
state based on these dependencies.

I am not sure this can be solved generically without increasing the
complexity of genpd idle states.

Thanks,
Lina
