From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
Date: Wed, 19 Sep 2018 14:50:39 -0700
Message-ID: <20180919215039.mb7prmmfs5jek3aj@vireshk-mac-ubuntu>
References: <20180919182247.1101-1-natechancellor@gmail.com>
 <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, ilia.lin@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 19-09-18, 14:45, Nick Desaulniers wrote:
> On Wed, Sep 19, 2018 at 11:22 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> > the function qcom_cpufreq_kryo_probe() to the function
> > .init.text:qcom_cpufreq_kryo_get_msm_id()
> > The function qcom_cpufreq_kryo_probe() references
> > the function __init qcom_cpufreq_kryo_get_msm_id().
> > This is often because qcom_cpufreq_kryo_probe lacks a __init
> > annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
> >
> > Add the '__init' annotation to qcom_cpufreq_kryo_probe so that there is
> > no more mismatch warning.
> 
> I wonder why this driver has an exit function marked __init rather
> than __exit?

I think it was just a mistake.

> Does that mean it gets cleaned up after kernel init, and
> so on unloading of the driver, the kernel jumps to unmapped memory?

The __init/exit sections are only useful when the driver is builtin
and so there is no unloading. Yeah, if you would have tried to call
shutdown for the kernel, it may have crashed or something. I don't
know.

> Does this patch now produce a warning for `qcom_cpufreq_kryo_driver`
> referencing `qcom_cpufreq_kryo_probe`?

Why should it ? It doesn't though.

-- 
viresh
