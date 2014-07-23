From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: tests: Providing cpufreq regression test
Date: Wed, 23 Jul 2014 14:19:54 +0530
Message-ID: <CAKohpok++gPcNk9-E4MsFdNBy8qL7oLYvatk1EvcW1OHwroZXQ@mail.gmail.com>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
	<1405926154-27214-1-git-send-email-l.majewski@samsung.com>
	<CAKohpondk7Cty8MhTcjyzZW8Z0o4AVupYE0rRnG4YJf+SmDyjg@mail.gmail.com>
	<20140723093824.5e51918f@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140723093824.5e51918f@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Abraham <ta.omasab@gmail.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <spk.linux@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 23 July 2014 13:08, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Do you want to say that we have enough tests and we don't need more ?

No. We don't have any tests at all :)

> I always thought that we shall have as much regression tests as
> possible.

Yeah, tests are welcomed but the question is where should they get added.
Don't know if its common to add tests directly to kernel.

And also if the test is really good, not discouraging your work.

>> On 21 July 2014 12:32, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> > This commit adds first regression test "cpufreq_freq_test.sh" for
>> > the cpufreq subsystem.
>>
>> That's not enough, Tell us why we should continue reading this mail..
>
> Hmm... If "regression" and "test" don't catch the attention of a
> diligent maintainer, then I cannot do much more to encourage him to
> read the whole e-mail :-)

What I meant to say was, your subject and body must be good enough
to answer most of the things. You don't have to tell much about the
implementation but other things should be pretty clear from logs.

Your current logs are quite short for something that's not a normal practice.

> I can imagine that maintainers are very busy, therefore I've prepared
> README file with detailed description of the script operation.

Yeah, a README is welcomed and would be useful for users as well..

>> I couldn't make out the purpose of this test and why we need it. How
>> do we ensure that "cpufreq attributes exported by sysfs are exposing
>> correct values"?
>
> First of all the cpufreq attributes are part of the subsystem API.
> There are systems which actually depend on them, so we would be better
> off to test if they work as intended.
>
> Secondly, the test takes those values and then with use of other
> attribute enforce the value, which is then read via cat'ing
> cpufreq_cur_freq. If any of the attributes is wrong then we will spot
> the error immediately.

Shouldn't you use userspace governor then instead of performance?
And then we don't need the gzip stuff at all. We can just set it to the
right freq and get current freq to see if it matches?

And now that we are starting to get tests added into the kernel (will still
wait to see what Rafael has to advice), we better think of the way these
are going to get added. Probably a single script with parameters like
what to test?

>> And actually what do we mean by this statement even? What kind of
>> errors can be there in exposing these values.
>
> Errors with cpufreq and CCF cooperation - especially when some parts of
> cpufreq code uses direct write to MUX, DIV or PLL SoC registers.
>
> Also, one can check if permutations of changing all available
> frequencies are working properly.

Yeah, that would be fine. Probably need to think more about scripts name.
