From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V4 0/2] Implement per policy instance of governor
Date: Sat, 30 Mar 2013 23:08:56 +0100
Message-ID: <1656173.qmCdUDP7Pu@vostro.rjw.lan>
References: <cover.1364398686.git.viresh.kumar@linaro.org> <2566297.LngxUqUYMZ@vostro.rjw.lan> <CAKohpon_C3LYe++cOb_9fgtz=DfQV_vWRNuH=UVXcKOO14GUhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpon_C3LYe++cOb_9fgtz=DfQV_vWRNuH=UVXcKOO14GUhQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, jacob.shin@amd.com
List-Id: linux-pm@vger.kernel.org

On Saturday, March 30, 2013 09:06:37 AM Viresh Kumar wrote:
> On 30 March 2013 07:47, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, March 27, 2013 09:28:56 PM Viresh Kumar wrote:
> 
> >> To test these over linux-next you need to revert following first:
> >> db9baec cpufreq: Get rid of "struct global_attr"
> >> 86bd6f0 cpufreq: governor: Implement per policy instances of governors
> >> 8ae67b1 cpufreq: Add per policy governor-init/exit infrastructure
> 
> > I've applied these two patches and re-applied the queue on top of them.
> >
> > All is in my linux-next branch now.
> 
> You were supposed to remove below patch too, which you missed :)
> 
> c7baa5e cpufreq: Get rid of "struct global_attr"

OK, I'll remove it.

And by the way, I'm no longer amused with the mess going on in the cpufreq land.

Please send me *patches*.  I'm not interested in git pointers.

Moreover, please send those patches in a way allowing me to figure out the
ordering without looking into your git tree.

If you have a number of outstanding cpufreq patches for me to apply, please
create a patch series out of them and send it.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
