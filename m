From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even when kthread kicked
Date: Wed, 23 May 2018 02:42:32 -0700
Message-ID: <6A76301E-E383-439D-AD1E-6DC2B2CAC3CE@joelfernandes.org>
References: <20180518185501.173552-1-joel@joelfernandes.org> <20180522103415.cuutobi5kbhj4gcw@vireshk-i7> <20180522220953.GB40506@joelaf.mtv.corp.google.com> <20180523090101.6xifikvjpirqafox@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523090101.6xifikvjpirqafox@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Joel Fernandes (Google.)" <joelaf@google.com>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>, claudio@evidence.eu.com, kernel-team@android.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On May 23, 2018 2:01:01 AM PDT, Viresh Kumar <viresh=2Ekumar@linaro=2Eorg>=
 wrote:
>On 22-05-18, 15:09, Joel Fernandes wrote:
>> I agree with the race you describe for single policy slow-switch=2E
>Good find :)
>>=20
>> The mainline sugov_work could also do such reordering in sugov_work,
>I think=2E Even
>> with the mutex_unlock in mainline's sugov_work, that work_in_progress
>write could
>> be reordered by the CPU to happen before the read of next_freq=2E AIUI,
>> mutex_unlock is expected to be only a release-barrier=2E
>>=20
>> Although to be safe, I could just put an smp_mb() there=2E I believe
>with that,
>> no locking would be needed for such case=2E
>>=20
>> I'll send out a v3 with Acks for the original patch, and the send out
>the
>> smp_mb() as a separate patch if that's Ok=2E
>
>Maybe it would be better to get the fix (with smp_mb) first and then
>this optimization patch on the top? That would mean that the fix can
>get applied to stable kernels easily=2E

Probably=2E But then Rafael is changing single policy to use the lock so t=
hen barrier wouldn't be needed at all=2E In that case, both mine and Rafael=
 new patch can go into stable which handles your race ( optimization =3D=3D=
 fix in this case :P )

thanks,

- Joel

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
