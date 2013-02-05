From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Tue, 5 Feb 2013 15:17:21 +0530
Message-ID: <CAKohpo=6q+Bcgq0Re=3SXM6zwub5N=vJBO=sTeEgZZ9byFK7=g@mail.gmail.com>
References: <20130204130403.GD13909@pd.tnic>
	<CAKohpokuFC5gnTFcD3+RH3p5XaW8vBtyfq+Kej=d2J8tERdmoQ@mail.gmail.com>
	<20130204133648.GE13909@pd.tnic>
	<CAKohpo=aLnhM0Op_32ohWZK5eG5nT7iK0OktBe+8ygOQW7zUqQ@mail.gmail.com>
	<20130204140908.GC15452@pd.tnic>
	<CAKohpokowK6ybYd8aDUdfFYsnzoc5VAKsuPSkfxoDqJ3k+FwGA@mail.gmail.com>
	<20130204150511.GF13909@pd.tnic>
	<CAKohpokt0xtsj1eQDMw6JgvQVp4rgFyU-vUrtuuF+0jjOVNHRQ@mail.gmail.com>
	<20130204165057.GH13909@pd.tnic>
	<CAOh2x==fyfYwz+eXmPhBJTE+_q_fHyx2drXrM789XvCfEqPBUQ@mail.gmail.com>
	<20130205091532.GA4827@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20130205091532.GA4827-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Steve.Bannister-5wv7dgnIgG8@public.gmane.org, Charles Garcia-Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 5 February 2013 14:45, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org> wrote:
> On Tue, Feb 05, 2013 at 12:50:31PM +0530, Viresh Kumar wrote:
>> > I think this is cleaner but whatever - I don't care that much. My
>> > only strong concern is that this thing should be a Kconfig option and
>> > optional for arches where it doesn't apply.
>>
>> Your concern is: we don't want to fix userspace for existing platforms
>> where we have just a single cluster and so struct policy in the system.
>
> No, as I said so many times already and you're unwilling to understand
> it:

I am willing to, but not able to :)

> multiple policies support in cpufreq should be optional and
> selectable in Kconfig so that systems which don't need that, don't
> have to see or use it. It is yet another feature which doesn't apply
> universally so we make such features optional. Like the rest of the
> gazillion things in the kernel already.

I understand what Kconfig options are for, but i am not able to understand
what's the benefit of this option here. For example: for single image solutions
we need to keep it enabled. And so, would need some sort of logic in cpufreq
core & platform driver to decide where to create the governors directory.

The code without Kconfig option would be as simple as:

platform_driver:
init(struct cpufreq_policy *policy)
{
..
    policy->have_multiple_policies = true;
..
}

cpufreq-core:

add_dev()
{
    if (policy->have_multiple_policies)
        create-folder-in-cpu/cpu*/cpufreq;
    else
        create-folder-in-cpu/cpufreq;
}

And so, platforms like Krait or big.LITTLE can set it to true from their
cpufreq-drivers. And this wouldn't break any of the current platforms.

> The existing sysfs layout cannot be changed because you're breaking
> userspace and we don't do that. It is that simple.

That's fine. I understood it already. :)

The problem i see is:
- both governor tunables, cpufreq-stats & policy tunables (P-states) have the
same requirement. They are all per policy or clock-domain, instead of per cpu.
- I want to keep all of these at the same place, as they should be
present in the
same hierarchy.
- If we move everything to cpu/cpufreq/policy-names/ then also we would break
existing userspace stuff for stats and P-states.
- If we move everything to cpu/cpu*/cpufreq/ then also we would break
existing userspace stuff for governors.

> Concerning adding new sysfs entries, I told you to make it as easy as
> possible and as sensible as possible, dictated by the use cases. If you
> can't come up with some, then talk to the people who are going to use
> your design and ask them what makes sense the most.

For me cpu/cpu*/ is the most sensible as it is an very easy/convenient interface
for users. I am the first one who is going to use it :)

@Rafael: What's your view on this discussion we are having? We probably need few
more "minds" to jump in, as we are not moving towards a conclusion. :)

--
viresh
