From: Gleb Natapov <gleb@kernel.org>
Subject: Re: intel_pstate divide error with v3.13-rc4-256-gb7000ad
Date: Fri, 27 Dec 2013 19:01:48 +0200
Message-ID: <20131227170147.GH10961@minantech.com>
References: <CA+5PVA6YpKc6kYK5UiTnGLZpB8uts=-QPtyhotAyZ2kuoG8PPQ@mail.gmail.com>
 <CAKohpomqHApogDEXA5LyWk-+B-Y1mwNQ63-wL3PPGz64s_3Dmw@mail.gmail.com>
 <20131227122422.62857cec@alan.etchedpixels.co.uk>
 <20131227124749.GE10961@minantech.com>
 <CA+5PVA60GSC0tTLJWLtVqb5eTPMzrszxtoBnUP8B_Q_60=oGyw@mail.gmail.com>
 <52BD8B8B.1050209@redhat.com>
 <20131227165248.GG10961@minantech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131227165248.GG10961@minantech.com>
Sender: cpufreq-owner@vger.kernel.org
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, "Richard W.M. Jones" <rjones@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 27, 2013 at 06:52:48PM +0200, Gleb Natapov wrote:
> On Fri, Dec 27, 2013 at 03:15:39PM +0100, Kashyap Chamarthy wrote:
> > [. . .]
> > 
> > >> KVM does not emulate P-states at all. intel_pstate_init() calls
> > >> intel_pstate_msrs_not_valid() before printing "Intel P-state driver
> > >> initializing."  which suppose to fail since it checks that two reads of
> > >> MSR_IA32_APERF return different values, but KVM does not emulate this msr
> > >> at all, so both calls should return zero (KVM suppose to inject #GP, all rdmsrl
> > >> are patched to be rdmsrl_safe in a guest).
> > >>
> > >> Anything interesting in host dmesg?
> > 
> > Heya Gleb,
> > 
> > Here's the relevant dmesg snippet (full dmesg, refer the attachment below):
> That's guest dmesg. What about host one? Can you ftrace the failure?
> 
Ugh, it looks like guest dmesg but there are KVM messages there too ("[
281.443662] kvm [2452]: vcpu0 unhandled rdmsr: 0xe8" is unhandled access
to MSR_IA32_APERF I was talking about above), so I guess this is nested
guest invocation?  Does it happen in non nested guest?

--
			Gleb.
