From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 3/5] x86, apic: Add freeze event support
Date: Thu, 13 Jul 2017 07:13:05 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707130712030.2332@nanos>
References: <20170708000303.21863-1-dbasehore@chromium.org> <20170708000303.21863-3-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170708000303.21863-3-dbasehore@chromium.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, platform-driver-x86@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 7 Jul 2017, Derek Basehore wrote:

> This adds support to the clock event devices created by apic to use
> freeze events. The apic is able to run a timer during freeze with near
> zero power impact on modern CPUs such as skylake. This will allow
> S0ix, suspend-to-idle, to be validated on Intel CPUs that support it.
> 
> This is needed because bugs with power settings on the SoC can prevent
> S0ix entry. There is also no way to check this before idling all of
> the CPUs.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  arch/x86/kernel/apic/apic.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 98b3dd8cf2bf..adc69d2f11ce 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -480,6 +480,26 @@ static int lapic_next_deadline(unsigned long delta,
>  	return 0;
>  }
>  
> +static int lapic_event_expired(struct clock_event_device *evt)

That want's to have a boolean return.

> +{
> +	u32 cct;
> +
> +	cct = apic_read(APIC_TMCCT);
> +	return cct == 0 ? 1 : 0;

which makes that:

      	return !cct;

> +}

Thanks,

	tglx
