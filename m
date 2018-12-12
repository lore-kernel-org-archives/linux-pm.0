From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [solved] *powersave* governor shown despite disabled in
 configuration
Date: Wed, 12 Dec 2018 22:26:11 +0100
Message-ID: <f6bbee19-d5fd-4deb-03a7-488f40be5103@molgen.mpg.de>
References: <8786b234-eb4d-fb79-d6e0-e71f45ed3120@molgen.mpg.de>
 <20181211065152.t2anuhy6t4n2zjrd@isilmar-4.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211065152.t2anuhy6t4n2zjrd@isilmar-4.linta.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


Dear Dominik,


Thank you for your quick response.


Am 11.12.18 um 07:51 schrieb Dominik Brodowski:
> On Mon, Dec 10, 2018 at 04:30:05PM +0100, Paul Menzel wrote:

>> With Linux 4.14.76, the scaling governor *powersave* is shown as
>> being available despite being disabled in the configuration.
> 
> Which cpufreq driver do you use? Presumably intel_pstate?

Yes, intel_pstate.

> That driver exposes internal policies / "governors" named 
> "performance" and "powersave", which are unrelated to
> CONFIG_CPU_FREQ_GOV_POWERSAVE.
Indeed, that confused me, and I didn’t read the documentation
carefully enough.

> They are not generic scaling governors, but their names are the same as the
> names of some of those governors.  Moreover, confusingly enough, they generally
> do not work in the same way as the generic governors they share the names with.
> For example, the ``powersave`` P-state selection algorithm provided by
> ``intel_pstate`` is not a counterpart of the generic ``powersave`` governor
> (roughly, it corresponds to the ``schedutil`` and ``ondemand`` governors).
> 
> There are two P-state selection algorithms provided by ``intel_pstate`` in the
> active mode: ``powersave`` and ``performance``.  The way they both operate
> depends on whether or not the hardware-managed P-states (HWP) feature has been
> enabled in the processor and possibly on the processor model.


Kind regards,

Paul


[1]: https://www.kernel.org/doc/html/latest/admin-guide/pm/intel_pstate.html
