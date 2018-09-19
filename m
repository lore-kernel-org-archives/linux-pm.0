From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
Date: Wed, 19 Sep 2018 15:48:11 -0700
Message-ID: <20180919224811.GA4310@flashbox>
References: <20180919182247.1101-1-natechancellor@gmail.com>
 <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
 <20180919215039.mb7prmmfs5jek3aj@vireshk-mac-ubuntu>
 <20180919215418.y2jsrsj73vy3dudd@vireshk-mac-ubuntu>
 <CAJZ5v0ipkaudrv7W5VP1_e9LERF6DLZuw+HtTf2Si4p=pbv9bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ipkaudrv7W5VP1_e9LERF6DLZuw+HtTf2Si4p=pbv9bw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, ndesaulniers@google.com, ilia.lin@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 20, 2018 at 12:45:55AM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 19, 2018 at 11:54 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 19-09-18, 14:50, Viresh Kumar wrote:
> > > On 19-09-18, 14:45, Nick Desaulniers wrote:
> > > > On Wed, Sep 19, 2018 at 11:22 AM Nathan Chancellor
> > > > <natechancellor@gmail.com> wrote:
> > > > >
> > > > > WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> > > > > the function qcom_cpufreq_kryo_probe() to the function
> > > > > .init.text:qcom_cpufreq_kryo_get_msm_id()
> > > > > The function qcom_cpufreq_kryo_probe() references
> > > > > the function __init qcom_cpufreq_kryo_get_msm_id().
> > > > > This is often because qcom_cpufreq_kryo_probe lacks a __init
> > > > > annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
> > > > >
> > > > > Add the '__init' annotation to qcom_cpufreq_kryo_probe so that there is
> > > > > no more mismatch warning.
> > > >
> > > > I wonder why this driver has an exit function marked __init rather
> > > > than __exit?
> > >
> > > I think it was just a mistake.
> > >
> > > > Does that mean it gets cleaned up after kernel init, and
> > > > so on unloading of the driver, the kernel jumps to unmapped memory?
> > >
> > > The __init/exit sections are only useful when the driver is builtin
> > > and so there is no unloading. Yeah, if you would have tried to call
> > > shutdown for the kernel, it may have crashed or something. I don't
> > > know.
> > >
> > > > Does this patch now produce a warning for `qcom_cpufreq_kryo_driver`
> > > > referencing `qcom_cpufreq_kryo_probe`?
> > >
> > > Why should it ? It doesn't though.
> >
> > I thought you replied to my commit where I marked the exit routine
> > with __exit and realised just now that it wasn't the case. I haven't
> > build-tested this thing, but the question still stands. Why should it
> > ?
> 
> Because __init things go away at one point and calling them from the
> other sections is a bad idea.  OTOH, __exit things are simply not
> needed in built-in drivers and they are never there if the driver is
> built-in, so calling them from the other sections is a bad idea too.
> 
> Can you guys, please, prepare *one* patch fixing all of the
> __init/__exit annotations in this driver and post it?
> 
> Thanks,
> Rafael

Hi Rafael,

Yes, I will work on this and send out a v3 for review.

Thanks,
Nathan
