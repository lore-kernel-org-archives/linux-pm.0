From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH] x86: Move away from /dev/cpu/*/msr
Date: Wed, 15 Jun 2016 16:00:28 +0200
Message-ID: <20160615140028.GD32588@pd.tnic>
References: <20160615100029.GB32588@pd.tnic>
 <CADjb_WSTH6b2vpM2A=Kp_NKdUzVEoAhPNAQgU0jCuLS2_o55xw@mail.gmail.com>
 <20160615103622.GA19822@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160615103622.GA19822@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: chenyu <yu.chen.surf@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Renninger <trenn@suse.com>, Kan Liang <kan.liang@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 15, 2016 at 12:36:22PM +0200, Borislav Petkov wrote:
> Ah, yes, good point. Will change.

Ok, got a bit more involved - I also need to disable preemption around
smp_call_function_single(). Here's what I have now. It seems to work
too.

static ssize_t
energy_policy_pref_hint_show(struct device *dev, struct device_attribute *attr,
                             char *buf)
{
        u64 epb;

        preempt_disable();
        if (rdmsrl_on_cpu(dev->id, MSR_IA32_ENERGY_PERF_BIAS, &epb))
                epb = -1;
        preempt_enable();

        return sprintf(buf, "%d\n", (unsigned int)(epb & 0xFULL));
}

static ssize_t
energy_policy_pref_hint_store(struct device *dev, struct device_attribute *attr,
                              const char *buf, size_t count)
{
        u32 val;
        u64 epb;

        if (kstrtou32(buf, 10, &val) < 0)
                return -EINVAL;

        if (val > 15)
                return -EINVAL;

        preempt_disable();

        if (rdmsrl_on_cpu(dev->id, MSR_IA32_ENERGY_PERF_BIAS, &epb)) {
                count = -EINVAL;
                goto out;
        }

        if ((epb & 0xf) == val)
                goto out;

        if (wrmsrl_on_cpu(dev->id, MSR_IA32_ENERGY_PERF_BIAS, (epb & ~0xFULL) | val))
                count = -EINVAL;

out:
        preempt_enable();
        return count;
}

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
