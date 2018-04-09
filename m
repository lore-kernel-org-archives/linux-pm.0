From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/7] PM / Domain: Add struct device to genpd
Date: Mon, 9 Apr 2018 12:46:47 +0200
Message-ID: <CAPDyKFpiahCSEtAAS856B+MWa=o5VCTZH--Hp+xTnzmT2M9v+A@mail.gmail.com>
References: <cover.1513926033.git.viresh.kumar@linaro.org> <a7867661e9bc6f5b1571f60398266ef678ccc1c0.1513926033.git.viresh.kumar@linaro.org>
 <CAPDyKFprVsOd7_nKCXDCxDErh-K+vfaWojqDo0arzt0ZJKCPjQ@mail.gmail.com>
 <20180322095903.h7hgm3xylq3esjyf@vireshk-mac-ubuntu> <CAPDyKFqZeOvHy1oY0JnUau17vFTuRBzCjKp+zzpf=tWzAi3cEw@mail.gmail.com>
 <20180409075342.GB7671@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409075342.GB7671@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh+dt@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 9 April 2018 at 09:53, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-03-18, 11:18, Ulf Hansson wrote:
>> On 22 March 2018 at 10:59, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > On 22-03-18, 10:30, Ulf Hansson wrote:
>> >> On 22 December 2017 at 08:26, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
>> >> > +       ret = device_add(&genpd->dev);
>> >>
>> >> What's the point of adding the device? Can we skip this step, as I
>> >> guess the opp core is only using the device as cookie rather actual
>> >> using it? No?
>> >
>> > We also use it for the OPP debugfs stuff, so that would be required I believe.
>>
>> Right, however, isn't that only using the dev_name(dev), which you
>> don't need to add the device to make use of.
>>
>> Or maybe I missing something around this...
>
> So I tested this bit. The code works fine even if the device isn't added
> (registered), but this looks a bit sloppy to attempt.
>
> Please let me know what would you prefer in this case, add the device or not.

Well, I don't know if there is policy of how to do this in general. Or
perhaps this can be considered as a special case as the device is only
going to be used as cookie (at least so far).

I suggest we keep it as simple as possible and *not* add (register) the device.

Kind regards
Uffe
