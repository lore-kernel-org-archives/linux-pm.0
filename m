From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v15 2/7] power: add power sequence library
Date: Mon, 19 Jun 2017 17:02:59 +0800
Message-ID: <20170619090259.GA23731@b29397-desktop>
References: <1497319166-17287-3-git-send-email-peter.chen@nxp.com>
 <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com>
 <20170614015338.GA4635@b29397-desktop>
 <CAPDyKFrLL10TY1JZAhF44_0+qGETLNtFc6ujKVUu7Ay=O8+M5A@mail.gmail.com>
 <20170615065854.GA24157@b29397-desktop>
 <CAPDyKFpc8GRKK8bafMU_HPaqWNrger3grPSd5rWWCTYhUGHZLA@mail.gmail.com>
 <20170615091131.GB24157@b29397-desktop>
 <CAPDyKFrZoyoYCQA1rnRbz9tmT9vJigzSb+xyTZpJjhd=5eFA5A@mail.gmail.com>
 <20170615100604.GC24157@b29397-desktop>
 <CAPDyKFrSQ7m+yUvKqB9yAMakk8pHZooboZMFdXGU6Xb=TZSGNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrSQ7m+yUvKqB9yAMakk8pHZooboZMFdXGU6Xb=TZSGNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Chen <peter.chen@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <stephen.boyd@linaro.org>, frank.li@nxp.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Joshua Clayton <stillcompiling@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, mka@chromium.org, Alan Stern <stern@rowland.harvard.edu>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.ker>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 19, 2017 at 10:09:58AM +0200, Ulf Hansson wrote:
> On 15 June 2017 at 12:06, Peter Chen <hzpeterchen@gmail.com> wrote:
> > On Thu, Jun 15, 2017 at 11:35:20AM +0200, Ulf Hansson wrote:
> >> On 15 June 2017 at 11:11, Peter Chen <hzpeterchen@gmail.com> wrote:
> >> > On Thu, Jun 15, 2017 at 10:11:45AM +0200, Ulf Hansson wrote:
> >> >> > Yes, you are right. This is the limitation for this power sequence
> >> >> > library, the registration for the 1st power sequence instance must
> >> >> > be finished before device driver uses it. I am appreciated that
> >> >> > you can supply some suggestions for it.
> >> >>
> >> >> In general this kind of problems is solved by first parsing the DTB,
> >> >> which means you will find out whether there is a resource (a pwrseq)
> >> >> required for the device. Then you try to fetch that resource, and if
> >> >> that fails, it means the resource is not yet available, and hence you
> >> >> want to retry later and should return -EPROBE_DEFER.
> >> >>
> >> >> In this case, of_pwrseq_on() needs to be converted to start looking
> >> >> for a pwrseq compatible in it's child node - I guess. Then if that is
> >> >> found, you try to fetch the instance of the corresponding library.
> >> >> Failing to fetch the library instance should then cause a return
> >> >> -EPROBE_DEFER.
> >> >
> >> > The most difficulty for this is we can't know whether the requested
> >> > pwrseq instance will be registered or not, the kernel configuration
> >> > for this pwrseq library may not be chosen at all.
> >>
> >> In such case it is still correct to return -EPROBE_DEFER, because the
> >> driver that tries to probe its device will fail unless it can run the
> >> needed pwrseq. Right?
> >>
> >
> > Unlike the MMC design, there is no dts entry to indicate whether this
> > device needs pwrseq or not at this design, it will only carry out power
> > on sequence after matching. So, return -EPROBE_DEFER may not work since
> > this device may never need pwrseq.
> 
> Then, how will you really be able to fetch the correct pwrseq library
> instance for the device node?
> 
> Suppose their is a *list* of pwrseq library instances available. In
> pwrseq_find_available_instance() you call of_match_node(table, np).
> The "table" there corresponds to the compatible for the pwrseq library
> and the np is the device node provided by the caller of
> of_pwrseq_on().
> 
> Why is this match done?

The compatible in table is from the source code, and the compatible in
np is from the dts. This is the current match way, I comment your
suggestion below.

> 
> Why can't the match be done before trying to fetch a library instance

How? If there is no pwrseq instance, how can we do match?

> and then in a second step, really try to fetch the instance? If only
> the second step fails, returning -EPROBE_DEFER can be done, no?
> 
> BTW, I didn't compatible for the generic pwrseq library being
> documented in this series.
> 
> >
> >> >
> >> >>
> >> >> >
> >> >> >> Moreover, I have found yet another severe problem but reviewing the code:
> >> >> >> In the struct pwrseq, you have a "bool used", which you are setting to
> >> >> >> "true" once the pwrseq has been hooked up with the device, when a
> >> >> >> driver calls of_pwrseq_on(). Setting that variable to true, will also
> >> >> >> prevent another driver from using the same instance of the pwrseq for
> >> >> >> its device. So, to cope with multiple users, you register a new
> >> >> >> instance of the same pwrseq library that got hooked up, once the
> >> >> >> ->get() callback is about to complete.
> >> >> >>
> >> >> >> The problem the occurs, when there is another driver calling
> >> >> >> of_pwrseq_on() in between, meaning that the new instance has not yet
> >> >> >> been registered. This will simply fail, won't it?
> >> >> >
> >> >> > Yes, you are right, thanks for pointing that, I will add mutex_lock for
> >> >> > of_pwrseq_on.
> >> >>
> >> >> Another option is to entirely skip to two step approach.
> >> >>
> >> >> In other words, make the library to cope with multiple users via the
> >> >> same registered library instance.
> >> >>
> >> >
> >> > No, the pwrseq instance stores dtb information (clock, gpio, etc), it
> >> > needs to be per device.
> >>
> >> I think you misunderstood my suggestion here. Of course you need to
> >> allocate one pwrseq data per device.
> >>
> >> However, my point is that you shouldn't need more than one instance of
> >> the library functions to be registered in the list of available pwrseq
> >> libraries.
> >>
> >
> > This additional instance is used to store compatible information for
> > this pwrseq library, it is used for the next matching between device
> > and pwrseq library, it just likes we need the first pwrseq instance
> > registered at boot stage.
> 
> Why can't the compatible information be a static table, known by the
> pwrseq core library?
> 
> Then when of_pwrseq_on() is called, that static table is parsed and
> matched, then a corresponding pwrseq library instance tries to be
> fetched.
> 

So, you suggest allocating and registering pwrseq instance on the
demand? Eg, we maintain a power sequence static table, including
compatible and allocate function.

static const struct pwrseq_match_table pwrseq_match_table_list[] = {
	{ PWRSEQ_DEV(0x0204, 0x6025), .alloc_instance = pwrseq_AA_alloc_instance },
	{ PWRSEQ_DEV(0x0204, 0x6026), .alloc_instance = pwrseq_BB_alloc_instance },
	{ PWRSEQ_DEV(0xffff, 0xffff), .alloc_instance = pwrseq_generic_alloc_instance },
};

And pwrseq_AA{BB}_alloc_instance are defined at each pwrseq library, and
are exported.

Since the pwrseq_match_table_list is static, we can always do match, and
will not return -EPROBE_DEFER anymore, one problem for this is we need
always compile all pwrseq libraries. Any good suggestions?

-- 

Best Regards,
Peter Chen
