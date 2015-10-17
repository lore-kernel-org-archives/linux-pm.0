From: Rob Clark <robdclark@gmail.com>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sat, 17 Oct 2015 15:48:01 -0400
Message-ID: <CAF6AEGsvRvuWnLhqRYKvvHsnFn12tNvw-6TyBGubKQygUZP6iA@mail.gmail.com>
References: <561E1378.6000906@collabora.com>
	<20151017065750.GA18607@kroah.com>
	<CAL_Jsq+Due3CgV0Z_m4vYQsa+X30DSxgmqz_r=26OrBV7v+H2g@mail.gmail.com>
	<20151017154709.GE4059@kroah.com>
	<CAL_JsqJvtKt6FpZgnYcsEm_opr9gK_a013BVpZGvnB=51oSUXg@mail.gmail.com>
	<20151017165617.GC25156@kroah.com>
	<CAF6AEGvbYYeZx=YVCv9r5K0xjtLf3gN69gX5DyQ3j0S1qT0Yog@mail.gmail.com>
	<20151017182755.GA28072@kroah.com>
	<CAF6AEGuvr6XMMufY0iDCSkp2BNcWa2=xUxjN66+FtQ6ygS-nyQ@mail.gmail.com>
	<56229BCC.9050603@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <56229BCC.9050603@tronnes.org>
Sender: linux-clk-owner@vger.kernel.org
To: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwo>
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 17, 2015 at 3:04 PM, Noralf Tr=C3=B8nnes <noralf@tronnes.or=
g> wrote:
>
> Den 17.10.2015 20:45, skrev Rob Clark:
>>
>> On Sat, Oct 17, 2015 at 2:27 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Sat, Oct 17, 2015 at 01:54:43PM -0400, Rob Clark wrote:
>>>>
>>>> On Sat, Oct 17, 2015 at 12:56 PM, Greg Kroah-Hartman
>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>
>>>>>> I'm guessing the time is a matter of probing and undoing the pro=
bes
>>>>>> rather than slow h/w. We could maybe improve things by making su=
re
>>>>>> drivers move what they defer on to the beginning of probe, but t=
hat
>>>>>> seems like a horrible, fragile hack.
>>>>>
>>>>> How can calling probe and failing cause 2 seconds?  How many diff=
erent
>>>>> probe calls are failing here?  Again, a boot log graph would be g=
reat
>>>>> to
>>>>> see as it will show the root cause, not just guessing at this.
>>>>
>>>>
>>>> just fwiw, but when you have a driver that depends on several othe=
r
>>>> drivers (which in turn depend on other drivers and so on), the amo=
unt
>>>> of probe-defer we end up seeing is pretty comical.  Yeah, there
>>>> probably is some room to optimize by juggling around order drivers=
 do
>>>> things in probe.  But that doesn't solve the fundamental problem w=
ith
>>>> the current state, about probe order having no clue about
>>>> dependencies..
>>>
>>> I can imagine it is a lot of iterations, but how long does it reall=
y
>>> take?  How many different devices are involved that it takes multip=
le
>>> loops in order to finally work out the correct order?  Where is the=
 time
>>> delays here, just calling probe() and having it instantly return
>>> shouldn't take all that long.
>>
>> offhand, I think the dependencies go at *least* three levels deep..
>> I'd say, from memory, I see drm/msm taking at least 5 or 6 tries to
>> get all the way through requesting it's various different
>> regulators/clks/gpios.  I hadn't really paid attention to how many
>> tries the drivers I depend on go through.  (Of those, I take clks fr=
om
>> two different clk drivers (which have dependency on a 3rd clk driver=
),
>> and regulators and gpio's come from at least two places, which in tu=
rn
>> have dependencies on clks, etc.)  I don't have really good hard
>> numbers handy (since my observations of this are w/ console over uar=
t
>> which effects timings, and so I see it taking much longer than 2sec)=
=2E.
>> but the 2sec figure that Tomeu mentioned seemed pretty plausible to
>> me.
>>
>> I can try to get better #'s... I should have my kernel hat on at lea=
st
>> some of the time next week.. but the 2sec figure didn't seem
>> unrealistic to me.
>
>
> Are you saying that the total boot time is increased by 2 sec due to
> deferred probing, or that display initialization is happening 2 sec
> after it's first try?
>

The 2sec figure was from Tomeu, but I guess display should be probed
in first pass through list of devices (and ofc deferring the first
time), I'll say "probably both"..

BR,
-R
