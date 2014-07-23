From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2] cpufreq: tests: Providing cpufreq regression test
Date: Wed, 23 Jul 2014 09:38:24 +0200
Message-ID: <20140723093824.5e51918f@amdc2363>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
 <1405926154-27214-1-git-send-email-l.majewski@samsung.com>
 <CAKohpondk7Cty8MhTcjyzZW8Z0o4AVupYE0rRnG4YJf+SmDyjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAKohpondk7Cty8MhTcjyzZW8Z0o4AVupYE0rRnG4YJf+SmDyjg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Abraham <ta.omasab@gmail.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <spk.linux@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

> Hi Lukasz,
> 
> I haven't replied yet as I wanted to see what the general feed of
> Rafael is going to be :)
> 
> As this is something new and wasn't sure if we really want this..

Do you want to say that we have enough tests and we don't need more ?

I always thought that we shall have as much regression tests as
possible.


> 
> On 21 July 2014 12:32, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > This commit adds first regression test "cpufreq_freq_test.sh" for
> > the cpufreq subsystem.
> 
> That's not enough, Tell us why we should continue reading this mail..

Hmm... If "regression" and "test" don't catch the attention of a
diligent maintainer, then I cannot do much more to encourage him to
read the whole e-mail :-)

I can imagine that maintainers are very busy, therefore I've prepared
README file with detailed description of the script operation.

> 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> >
> > ---
> > Changes for v2:
> > - Replace *_PATCH with *_PATH for variables names
> > - Corrected mistakes in the README file
> > - Providing detailed explanation of the patch in the README file
> > ---
> >  drivers/cpufreq/tests/README               |  33 +++++++
> >  drivers/cpufreq/tests/cpufreq_freq_test.sh | 149
> > +++++++++++++++++++++++++++++
> 
> Probably a better place would be tools/power/cpufreq/
> 
> @Rafael?

Rafael, I'm open for suggestions.

> 
> >  2 files changed, 182 insertions(+)
> >  create mode 100644 drivers/cpufreq/tests/README
> >  create mode 100755 drivers/cpufreq/tests/cpufreq_freq_test.sh
> >
> > diff --git a/drivers/cpufreq/tests/README
> > b/drivers/cpufreq/tests/README new file mode 100644
> > index 0000000..3e9cd80
> > --- /dev/null
> > +++ b/drivers/cpufreq/tests/README
> > @@ -0,0 +1,33 @@
> > +This file contains list of cpufreq's available regression tests
> > with a short +usage description.
> > +
> > +1. cpufreq_freq_test.sh
> > +
> > +Description:
> > +------------
> > +This script is supposed to test if cpufreq attributes exported by
> > sysfs are +exposing correct values.
> > +
> > +To achieve this goal it saves the current governor and changes it
> > to +"performance". Afterwards, it reads the
> > "scaling_available_frequencies" +property. With the list of
> > supported frequencies it is able to enforce each of +them by
> > writing to "scaling_max_freq" attribute. To make the test more
> > reliable +a superfluous load with gzip is created to be sure that
> > we are running with +highest possible frequency. This high load is
> > regulated with the 'sleep' +duration. After this time the
> > "cpufreq_cur_freq" is read and compared with the +original value.
> > As the last step the original governor is restored.
> 
> I couldn't make out the purpose of this test and why we need it. How
> do we ensure that "cpufreq attributes exported by sysfs are exposing
> correct values"?

First of all the cpufreq attributes are part of the subsystem API.
There are systems which actually depend on them, so we would be better
off to test if they work as intended.

Secondly, the test takes those values and then with use of other
attribute enforce the value, which is then read via cat'ing
cpufreq_cur_freq. If any of the attributes is wrong then we will spot
the error immediately.

> 
> And actually what do we mean by this statement even? What kind of
> errors can be there in exposing these values.

Errors with cpufreq and CCF cooperation - especially when some parts of
cpufreq code uses direct write to MUX, DIV or PLL SoC registers.

Also, one can check if permutations of changing all available
frequencies are working properly.

This script allowed me to find at least two bugs at Exynos cpufreq
subsystem in the past. And those fixes are already applied to mainline.

> 
> I want to understand the purpose of this script very clearly first
> and then only will look at the details.

There is a clean shell script code to go through it, the README file
with detailed description of the script purpose and operation.

What else shall I write?


> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
