From: Gleb Natapov <gleb@kernel.org>
Subject: Re: intel_pstate divide error with v3.13-rc4-256-gb7000ad
Date: Fri, 27 Dec 2013 14:47:49 +0200
Message-ID: <20131227124749.GE10961@minantech.com>
References: <CA+5PVA6YpKc6kYK5UiTnGLZpB8uts=-QPtyhotAyZ2kuoG8PPQ@mail.gmail.com>
 <CAKohpomqHApogDEXA5LyWk-+B-Y1mwNQ63-wL3PPGz64s_3Dmw@mail.gmail.com>
 <20131227122422.62857cec@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131227122422.62857cec@alan.etchedpixels.co.uk>
Sender: cpufreq-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Josh Boyer <jwboyer@fedoraproject.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 27, 2013 at 12:24:22PM +0000, One Thousand Gnomes wrote:
> On Tue, 24 Dec 2013 21:36:01 +0530
> Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > Adding Dirk..
> > 
> > On 24 December 2013 20:06, Josh Boyer <jwboyer@fedoraproject.org> wrote:
> > > Hi All,
> > >
> > > We've had a report [1] that the pstate driver causes KVM guests to
> > > fail to boot because of a divide error.  See the backtrace below.
> > >
> > >     4.839784] Intel P-state driver initializing.
> > > [    4.859972] Intel pstate controlling: cpu 0
> > > [    4.867653] cpufreq: __cpufreq_add_dev: ->get() failed
> > 
> > After a call to ->init(), ->get() is supposed to work.
> > @Dirk: Any idea why it failed?
> > 
> > And then I don't know what made this divide by zero to happen :)
> 
> > > [    4.878127] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> 
> Emulator bug perhaps ?
>
KVM does not emulate P-states at all. intel_pstate_init() calls
intel_pstate_msrs_not_valid() before printing "Intel P-state driver
initializing."  which suppose to fail since it checks that two reads of
MSR_IA32_APERF return different values, but KVM does not emulate this msr
at all, so both calls should return zero (KVM suppose to inject #GP, all rdmsrl
are patched to be rdmsrl_safe in a guest).

Anything interesting in host dmesg? Is it reproducible? 

--
			Gleb.
