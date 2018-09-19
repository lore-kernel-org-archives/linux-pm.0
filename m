From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
Date: Wed, 19 Sep 2018 15:29:30 -0700
Message-ID: <20180919222930.GA28725@flashbox>
References: <20180919182247.1101-1-natechancellor@gmail.com>
 <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: ilia.lin@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 19, 2018 at 02:45:15PM -0700, Nick Desaulniers wrote:
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
> than __exit? Does that mean it gets cleaned up after kernel init, and
> so on unloading of the driver, the kernel jumps to unmapped memory?
> 
> Does this patch now produce a warning for `qcom_cpufreq_kryo_driver`
> referencing `qcom_cpufreq_kryo_probe`?
> 

Hmmm I could have sworn I built this before sending it, although my
config might have been messed up but yes, I do see that warning.

WARNING: vmlinux.o(.data+0x117618): Section mismatch in reference from
the variable qcom_cpufreq_kryo_driver to the function
.init.text:qcom_cpufreq_kryo_probe()                                             
The variable qcom_cpufreq_kryo_driver references
the function __init qcom_cpufreq_kryo_probe() 

I suppose v1 might be the better option then as with the other patch,
marking qcom_cpufreq_kryo_driver doesn't seem correct.

I'm open to suggestions though.

Nathan

> >
> > Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > v1 -> v2:
> >
> > Add '__init' to qcom_cpufreq_kryo_probe instead of removing it from
> > qcom_cpufreq_kryo_get_msm_id.
> >
> >  drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > index a1830fa25fc5..e001ef8ea7de 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > @@ -73,7 +73,7 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
> >         return version;
> >  }
> >
> > -static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> > +static int __init qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> >  {
> >         struct opp_table *opp_tables[NR_CPUS] = {0};
> >         enum _msm8996_version msm8996_version;
> > --
> > 2.19.0
> >
> 
> 
> --
> Thanks,
> ~Nick Desaulniers
