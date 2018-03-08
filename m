From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
Date: Thu, 8 Mar 2018 11:12:21 +0530
Message-ID: <20180308054221.GJ6842@vireshk-i7>
References: <cover.1520274879.git.amit.kucheria@linaro.org>
 <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
 <6d5aeab8-aafe-fa3b-585e-953a34864e7d@arm.com>
 <CAP245DVwaY84+fZrbne1RLK9gKsfSTE2TELDAC0RkZGMzFkpWg@mail.gmail.com>
 <CAOh2x=njFxcwDfQs1g3-Estrun5j=fSYVnG-EaVw0UcRaDKsSg@mail.gmail.com>
 <CAP245DWAnYqbKJ_+NMqYvP9suwgmmkZ6twSBfAD64FxqztgnuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP245DWAnYqbKJ_+NMqYvP9suwgmmkZ6twSBfAD64FxqztgnuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Ram Chandrasekar <rkumbako@codeaurora.org>, DTML <devicetree@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08-03-18, 11:05, Amit Kucheria wrote:
> Interestingly enough, there are some patches that make the thermal
> framework start earlier to deal with boot-time thermal issues. I
> expect to post them soon. :-) These are required, for example, if the
> device goes into a reboot loop - the device might not even make it to
> the point in userspace where the governors are setup. In such a loop,
> the temperature constantly keeps increasing.
> 
> I was refering to the 'make defconfig' out-of-box experience that
> makes the majority of developer boards/devices out there stable to
> work on. I can't do that today.

Fair enough, but I am still not sure if we should put something that defines our
thermal policy into DT which should describe hardware.

-- 
viresh
