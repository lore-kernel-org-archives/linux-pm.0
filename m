From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
Date: Thu, 12 Sep 2013 02:43:47 +0200
Message-ID: <52310E43.1090808@intel.com>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange> <2703632.ul5ekQh5oq@vostro.rjw.lan> <CAKohpo=RKB-_EO=cjaOorAfN=y_cMgJg-j6=xtX71a-TwujgsA@mail.gmail.com> <2013615.oHjWkmedue@vostro.rjw.lan> <CAKohpokEZcwF-zL6rTXYyC_x=SJzGFvdvxqvmvyhJHa8nPXogQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAKohpokEZcwF-zL6rTXYyC_x=SJzGFvdvxqvmvyhJHa8nPXogQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Greg KH <greg@kroah.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 9/12/2013 2:39 AM, Viresh Kumar wrote:
> On 11 September 2013 18:48, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Wednesday, September 11, 2013 02:08:44 PM Viresh Kumar wrote:
>>> That looked like a straight forward issue/bug to me and so I haven't
>>> gotten deep into it..
>> Which you should always do when you're going to deal with concurrency issues.
>> Even if they appear to be obvious, they often are far from that, like in this
>> case.
> /me Nods
>
>>> Scenario 2:
>>> --------------
>>> Governor is changing freq and has called __cpufreq_driver_target().
>>> At the same time we are changing scaling_{min|max}_freq from
>>> sysfs, which would eventually end up calling governors:
>>> CPUFREQ_GOV_LIMITS notification, that will also call:
>>> __cpufreq_driver_target()..
>>>
>>> So, we eventually have two concurrent calls to ->target() and we
>>> don't really know how hardware will behave in this case.. Most of
>>> the implementations of ->target() routines just go and change
>>> freq/voltage without checking if we are already in progress of doing
>>> that (i.e. based on expectation that this call is not re entrant)..
>>>
>>> Now anything can happen at hardware level, which I don't have
>>> all insight of :(
>> That is more theoretical, however.
> Maybe we can get more deeper into it then :)
> Platform have something like this in their target()

Which platform?

> A. If new freq is more than old: Increase voltage
> B. Change freq
> C. If new freq is less than old: decrease voltage
>
> Now, two concurrent calls to target are X and Y, where X is trying to increase
> freq and Y is trying to decrease it..
>
> And this is the sequence that followed due to races..
>
> X.A: voltage increased for larger freq
> Y.A: nothing happened here
> Y.B: freq decreased
> Y.C: voltage decreased
> X.B: freq increased
> X.C: nothing happened..
>
> We ended up setting a freq which is not supported by the voltage we have
> set.. That will probably make clock to CPU unstable and system wouldn't
> be workable anymore...
>
> And so I think even this case must also get some space in the changelog :)

Yes, if you can point to a specific driver having this problem.

Thanks,
Rafael

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

