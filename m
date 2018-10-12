From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 6/9] OPP: Add dev_pm_opp_{set|put}_genpd_device() helper
Date: Fri, 12 Oct 2018 21:13:15 +0530
Message-ID: <CAKohpont9Jn0QiZ3yG++xR87ttUAbAL4CAwAmvVL+jMOqVRGdg@mail.gmail.com>
References: <cover.1539341929.git.viresh.kumar@linaro.org> <110c9e13d8d44dfb59577256b1309dddf2ceda12.1539341929.git.viresh.kumar@linaro.org>
 <CAPDyKFojOdmGbAzDMrO8EVJYrEYwYi6PT8YG55J9svGT61a1Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFojOdmGbAzDMrO8EVJYrEYwYi6PT8YG55J9svGT61a1Cg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 October 2018 at 20:16, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 October 2018 at 13:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Multiple generic power domains for a consumer device are supported with
>> the help of virtual devices, which are created for each consumer device
>> - genpd pair. These are the device structures which are attached to the
>> power domain and are required by the OPP core to set the performance
>> state of the genpd.
>>
>> The helpers added by this commit are required to be called once for each
>> of these virtual devices. These are required only if multiple domains
>> are available for a device, otherwise the actual device structure will
>> be used instead by the OPP core.
>>
>> The new helpers also support the complex cases where the consumer device
>> wouldn't always require all the domains. For example, a camera may
>> require only one power domain during normal operations but two during
>> high resolution operations. The consumer driver can call
>> dev_pm_opp_put_genpd_device(high_resolution_genpd_dev) if it is
>> currently operating in the normal mode and doesn't have any performance
>> requirements from the genpd which manages high resolution power
>> requirements. The consumer driver can later call
>> dev_pm_opp_set_genpd_device(high_resolution_genpd_dev) once it switches
>> back to the high resolution mode.
>>
>> The new helpers differ from other OPP set/put helpers as the new ones
>> can be called with OPPs initialized for the table as we may need to call
>> them on the fly because of the complex case explained above. For this
>> reason it is possible that the genpd_device structure may be used in
>
> This is a bit unclear. What is really the genpd_device structure?
> Could you please clarify that here?

It is the virtual device structures created by genpd.

>> parallel while the new helpers are running and a new mutex is added to
>> protect against that. We didn't use the existing opp_table->lock mutex
>> as that is widely used in the OPP core and we will need a lock in the
>> hotpath now, i.e.  while changing OPP and we need to make sure there is
>> not much contention while doing that.
>
> I not sure this needs to be considered as hotpath. I would be
> surprised if changing genpd virtual devices for OPP, is something that
> is going to be done frequently. Rather, this is more depending on the
> use case, like the camera case you describe above.
>
> In other words, do you really need a new lock?

My bad. I didn't explain it well. If you see a later patch where we started
configuring the required OPPs, we use genpd_dev or virt-dev within
opp_set_rate() which also needs this lock. And that is the hot path.

--
viresh
