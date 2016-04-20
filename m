From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4 0/2] Skylake PSys support
Date: Wed, 20 Apr 2016 11:28:51 -0700
Message-ID: <1461176931.8946.150.camel@linux.intel.com>
References: <1460930581-29748-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20160420135945.GY3448@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160420135945.GY3448@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net, x86@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-04-20 at 15:59 +0200, Peter Zijlstra wrote:
> On Sun, Apr 17, 2016 at 03:02:59PM -0700, Srinivas Pandruvada wrote:
> >=20
> > Skylake processor supports a new set of RAPL registers for
> > controlling
> > entire SoC instead of just CPU package called PSys. This change
> > adds
> > support in two sub systems:
> >=20
> > x86/perf: Adds basic support for Skylake RAPL and PSys support
> >=20
> > powercap/rapl: A new platform domain to the current power capping
> > Intel
> > RAPL driver.
> >=20
> > Srinivas Pandruvada (2):
> > =C2=A0 perf/x86/intel/rapl: support Skylake RAPL domains
> > =C2=A0 powercap: intel_rapl: PSys support
> >=20
> > =C2=A0arch/x86/events/intel/rapl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 5=
1 +++++++++++++++++++++++++++-
> > -
> > =C2=A0arch/x86/include/asm/msr-index.h |=C2=A0=C2=A02 ++
> > =C2=A0drivers/powercap/intel_rapl.c=C2=A0=C2=A0=C2=A0=C2=A0| 69
> > ++++++++++++++++++++++++++++++++++++++++
> > =C2=A03 files changed, 120 insertions(+), 2 deletions(-)
> These two patches depend on one another, right?=20
Yes.
> Because the first patch
> adds the MSR the second patch uses?
>=20
> How should we go about merging this? The perf-rapl stuff normally
> goes
> through tip while the powercap stuff goes through Rafael's tree.
Do you want me to only send PERF patch and wait for this to be merged
before sending powercap?

Thanks,
Srinivas
