From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [Update][PATCH v3 2/3] cpufreq: intel_pstate: Do not reinit performance limits in ->setpolicy
Date: Wed, 29 Mar 2017 15:16:04 -0700
Message-ID: <004201d2a8da$12e74910$38b5db30$@net>
References: <2694426.SgxlQuL17D@aspire.rjw.lan> <2326598.n0dkg1GrdM@aspire.rjw.lan> <2188688.SPioTUuSuO@aspire.rjw.lan> jZL3cbFe8sVy3jZL4c6fog tLegcUXspnsYHtLehcsgkR
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: tLegcUXspnsYHtLehcsgkR
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Doug Smythies' <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

Hi  Rafael,

Disregard.
I see this was fixed in kernel 4.11-rc4.
While kernel 4.11-rc4 was where I thought I started from earlier,
actually I was running 4.11-rc2 at the time.

sorry for the noise.

On 2017.03.29 15:01 Doug Smythies wrote:
> Sorry for the delay, but I didn't notice until today that this
> commit causes a regression, at least in my computer.
>
> I have not figured out exactly what is wrong, as I must
> admit I am finding these policy interactions difficult
> to follow.
>
> On 2017.03.02 14:29 Rafael J. Wysocki wrote:
>>From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> If the current P-state selection algorithm is set to "performance"
>> in intel_pstate_set_policy(), the limits may be initialized from
>
> ... [cut] ...
>
> Going back to kernel 4.11-rc1 I get this after boot**:
>
> $ uname -a
> Linux s15 4.11.0-rc1-stock #217 SMP Sun Mar 5 15:34:38 PST 2017 x86_64 x86_64 x86_64 GNU/Linux
