From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/3] cpufreq: ondemand: Change the calculation of
 target frequency
Date: Fri, 14 Jun 2013 00:38:41 +0200
Message-ID: <20130613223841.GF32112@pd.tnic>
References: <q46r5iepl3sunqe5eemv66hk.1370694869222@email.android.com>
 <7661669.NhG4BEI8zO@vostro.rjw.lan>
 <51B64BC6.6040400@semaphore.gr>
 <16929930.1G36b4NkSe@vostro.rjw.lan>
 <51BA380A.1040009@semaphore.gr>
 <20130613214007.GA32127@pd.tnic>
 <51BA41E9.8020004@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51BA41E9.8020004@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Borislav Petkov <bp@suse.de>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 14, 2013 at 01:04:25AM +0300, Stratos Karafotis wrote:
> I believe that ondemand has better performance with this patch in
> medium loads. Maybe these operations produce small to medium loads
> (lower than up_threshold) and push the CPU to medium frequencies.
> Without the patch CPU stays longer to min frequency.

Yep, this is my impression too.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
