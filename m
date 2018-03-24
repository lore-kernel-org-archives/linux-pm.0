From: Joel Fernandes <joel.opensrc@gmail.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on task wake-up
Date: Fri, 23 Mar 2018 23:06:11 -0700
Message-ID: <BE9CF57A-877A-4F2D-A64E-9693C54FF058@gmail.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com> <20180320094312.24081-6-dietmar.eggemann@arm.com> <20180321153518.GC13951@e110439-lin> <CAJWu+opupHfDF8QoSC2AQnoFXnz3idt6pr-fq6nUp1C59XjtXA@mail.gmail.com> <20180323154745.GP4589@e105550-lin.cambridge.arm.com> <CAJWu+oqP9NLkhhZsTZ5JogSWgp6D2FoGAmP76Szi4+n87XNSsQ@mail.gmail.com> <20180324013421.GB1317@queper01-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180324013421.GB1317@queper01-VirtualBox>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, Joel Fernandes <joelaf@google.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Chris Redpath <chris.redpath@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>
List-Id: linux-pm@vger.kernel.org



On March 23, 2018 6:34:22 PM PDT, Quentin Perret <quentin=2Eperret@arm=2Ec=
om> wrote:
>On Friday 23 Mar 2018 at 18:13:56 (-0700), Joel Fernandes wrote:
>> Hi Morten,
>>=20
>> On Fri, Mar 23, 2018 at 8:47 AM, Morten Rasmussen
>> <morten=2Erasmussen@arm=2Ecom> wrote:
>> > On Thu, Mar 22, 2018 at 01:10:22PM -0700, Joel Fernandes wrote:
>
>[=2E=2E=2E]
>
>> > You mean if SD_BALANCE_WAKE isn't set on sched_domains?
>>=20
>> Yes=2E
>>=20
>> > The current code seems to rely on that flag to be set to work
>correctly=2E
>> > Otherwise, the loop might bail out on !want_affine and we end up
>doing
>> > the find_energy_efficient_cpu() on the lowest level sched_domain
>even if
>> > there is higher level one which isn't over-utilized=2E
>> >
>> > However, SD_BALANCE_WAKE should be set if SD_ASYM_CPUCAPACITY is
>set so
>> > sd =3D=3D NULL shouldn't be possible? This only holds as long as we
>only
>> > want EAS for asymmetric systems=2E
>>=20
>> Yes, I see you had topology code that set SD_BALANCE_WAKE for ASYM=2E
>It
>> makes sense to me then, thanks for the clarification=2E
>>=20
>> Still I feel it is a bit tedious/confusing when reading code to draw
>> the conclusion about why sd is checked first before doing
>> find_energy_efficient_cpu (and that sd will !=3D NULL for ASYM
>systems)=2E
>> If energy_sd is set, then we can just proceed with EAS without
>> checking that sd !=3D NULL=2E This function in mainline is already pret=
ty
>> confusing as it is :-(
>
>Right I see your point=2E The code is correct as is, but I agree that
>having
>a code structured as
>
>	if (energy_sd) {
>		new_cpu =3D find_energy_efficient_cpu(energy_sd, p, prev_cpu);
>	} else if (!sd) {
>		=2E=2E=2E
>
>might be easier to understand and functionally equivalent=2E What do you
>think ?

Yeah definitely=2E Go for it=2E

- Joel


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
