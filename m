Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF2429CF5
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323210; cv=none; b=LwUxzut5uUtTMiYqi3fBdnNOy3zx3UNYiIJahcLYiMSEYPI3/nbRepZKVAInh35XfvVWwCwNoGPy9LfNzzIY4vqaJUZSM7LbeD4cwzihugFx0HBtiZJzNWWy91FE6sNTNrXg22LB8NgBjdnJkXOMKqxP/TWozUaZ811/6f91WWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323210; c=relaxed/simple;
	bh=b+WlYkXUtzeeUpMx/EuBIHn1VoeL5Yks1lD1ocApD0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YH/NRpQkvS/qFF9zVtMA0ogWG3k0AverO3n0/vz8y3cJIFrhWk1wiEqOVCt4XNxa3lqayCB1VvHZuxp0a9IKTFb1omJZeAJMii4BbH8yovRAHz2XQjlVbMu5hd18vyvLZaeovKpggf3sSZnQWYHeVMYBUcYhjz6fGyc2/jbV74Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrRAbNDu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrRAbNDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EE71F00A3F
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323202;
	bh=+0KipX/0aG5Ib1iPKm1V/Ma3tZxWDS/T3p4CGI4gSq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DrRAbNDu1G7tZFStCTbF0EPQTifasbBfKzbJRf4qy1T/vap6IICrO0pPkU9rjh2Ll
	 P+9A/XgTsF6sY6hmmw2IXGcoFWpBvK2mmERuRlxgcfLMqLvlZNoCit1bggITJ7HRQy
	 HhvHQgsV0No7KTyEUr9yzil+Ei1V/oXIBxTj9T9tj/5JM0zxgjLKWaA9BujvT4a2MA
	 zk7Fedy10JrNLrXKzOJ63n0jFFL6zR7eMihLRNOvEIuCHKQ69uVprjiNlW40sJScfm
	 f+iCjGko89sTclek9kA6m0H6raPdmSUXdI7kN2Wtjfkx2PDKgwmOMdzdwUTznNyFV2
	 q3PhMM/uM3neg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso1106125e87.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 07:40:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RouBgiTcROYdj3HqxivnmpWxqu2rbAGtZWEgHCcfZLhEXDRp96aGBMz5QXiewC6nzlqQQZQl/72Sw==@vger.kernel.org
X-Gm-Message-State: AFuF++md3PG5JksSpe1YIluCRr2ZrBauQoCFbhpW6morwF4GmM3s0EsT
	lGTo0K1K23r6Hx9F7NdPm/ydL7emTJCd+dbuO8/fIIbzRKVoqV5RfVEpqGZRRd6G4l5TdWoM4cW
	3V+ZWIt5ITTCJ6qE0KVjSDBYzJr37tew=
X-Received: by 2002:a05:6512:839b:b0:5ae:bf45:e3be with SMTP id
 2adb3069b0e04-5b484264a17mr1483182e87.21.1787323200241; Fri, 21 Aug 2026
 07:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809062549.1415955-1-christian.loehle@arm.com>
 <15234e9c-b9a5-434d-836f-e2e2ebc036c9@arm.com> <CAJZ5v0iEczt7CQYSsK5LpHKyRK7O97o+q1VE+-CSKS=HRFdpEw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iEczt7CQYSsK5LpHKyRK7O97o+q1VE+-CSKS=HRFdpEw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 21 Aug 2026 16:39:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iorhODU0fO3YNOO9BoK-wJqb-EsCkBfFfXuXgKCKgVwQ@mail.gmail.com>
X-Gm-Features: AcwNN1UsirurcOMu0CFe5esRlaDdsF3W94QLb_mevRGSUnX70DRdw3TuuOLuCb0
Message-ID: <CAJZ5v0iorhODU0fO3YNOO9BoK-wJqb-EsCkBfFfXuXgKCKgVwQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] ACPI: CPPC: Fix register access and lifetime bugs
To: Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	zhongqiu.han@oss.qualcomm.com, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, jarredwhite@linux.microsoft.com, 
	Shubhang Kaushik OS <shubhang@os.amperecomputing.com>, vanshikonda@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 12:31=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Aug 20, 2026 at 12:07=E2=80=AFPM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 8/9/26 07:25, Christian Loehle wrote:
> > > First of all, sorry this got so out of hand, initially this was just
> > > trying to fix some relatively simple issues found by sashiko in an
> > > earlier (unrelated) series.
> > > But with me touching more and more code and going through rounds of A=
I
> > > review that kept finding more and more pre-existing issues I've arriv=
ed
> > > at this.
> > >
> > > This series fixes correctness and robustness issues found while revie=
wing
> > > the CPPC control path. They affect malformed _CPC handling, error
> > > propagation, PCC ownership and cleanup, CPC object lifetime, register=
 field
> > > access, cross-processor aliases, and Performance Limited clearing.
> > >
> > > Series structure
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Patches 1-8 are deliberately small, independently useful fixes. They
> > > validate the _CPC encoding consumed by cppc-acpi, propagate control-w=
rite
> > > errors, serialize PCC payload updates, correct 64-bit field masks, an=
d fix
> > > descriptor and PCC lifetime handling.
> > >
> > > Patches 9-15 are the register-layout hardening portion. Geometry vali=
dation
> > > is more substantial because safe RMW and alias handling depend on the
> > > physical access unit, not merely on a logical _CPC entry or _PSD doma=
in.
> > > These patches normalize and validate each supported address space bef=
ore
> > > building probe-only physical interval registries. Keeping this work i=
n the
> > > same posting gives the complete safety boundary and a single base for
> > > review, while each transport and bug retains its own Fixes provenance=
.
> > > Feel free to treat the two parts as independent series, I didn't spli=
t it
> > > because they're all technically fixes and to get Sashiko review for t=
he
> > > whole lot.
> > >
> > > No interval lookup is added to the scheduler hot path. Full-width
> > > SystemMemory writes remain lockless. RMW locking remains necessary on=
ly for
> > > a partial field, where we must preserve the other bits in its access
> > > unit. The existing per-descriptor raw lock continues to cover disjoin=
t
> > > partial fields within one _CPC package; probe rejects cross-descripto=
r
> > > layouts that it cannot protect.
> > >
> > > Parsing and control semantics
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > >
> > > The parser now validates the package header before indexing it, bound=
s the
> > > BYTE and DWORD Integer forms before conversion, and validates the Gen=
eric
> > > Register descriptor consumed by cppc-acpi. NumEntries may not exceed =
the AML
> > > package count, but additional trailing package elements are ignored b=
ecause
> > > doing so is safe and preserves compatibility with padded firmware. Th=
e parser
> > > likewise tolerates trailing ResourceTemplate data instead of imposing=
 a new
> > > EndTag compatibility requirement.
> > >
> > > Writable controls must be Buffer-encoded registers. Minimum and Maxim=
um
> > > Performance are checked as the pair required by ACPI 6.6 Sections
> > > 8.4.6.1.2.1 and 8.4.6.1.2.2. Object presence is kept separate from th=
e
> > > Integer-zero convention for absent optional fields, so Lowest Perform=
ance
> > > may retain the valid abstract value zero.
> > >
> > > Performance Limited is one deliberate compatibility exception. ACPI l=
ists
> > > it as required, but permits a platform with no limiting indication to
> > > always return zero, and deployed firmware represents that case with a=
 NULL
> > > descriptor. CPPC control does not depend on this status register, so =
we
> > > continue to accept that encoding. A present _CPC package which otherw=
ise
> > > fails parsing or initialization now emits an error instead of silentl=
y
> > > preventing cpufreq registration.
> > >
> > > Compound performance and EPP updates propagate errors and perform eve=
ry
> > > fallible non-PCC write before modifying the PCC payload. Updates acro=
ss
> > > address spaces cannot be atomic, but a known non-PCC failure can no l=
onger
> > > commit only the PCC portion or leave an unsent value for a later comm=
and.
> > >
> > > SystemMemory locking and support boundary
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > A partial SystemMemory field requires RMW to preserve the rest of its
> > > access unit. Commit 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage")=
 used
> > > a per-_CPC lock and noted that a global lock would be needed if physi=
cal
> > > registers were shared between packages.
> > >
> > > ACPI does not make _PSD a physical-register ownership boundary. Rathe=
r than
> > > put a global raw lock or lookup into the scheduler path, this series =
makes
> > > the cheaper per-descriptor model's assumptions enforceable at probe.
> > >
> > > Supported SystemMemory layouts are:
> > >
> > >   - naturally aligned 8-, 16-, 32-, and 64-bit access units;
> > >   - lockless full-width controls;
> > >   - read-only aliases;
> > >   - exact full-width writable aliases, including 64-bit aliases on 64=
-bit
> > >     kernels;
> > >   - disjoint partial writers within one descriptor, serialized by its
> > >     rmw_lock; and
> > >   - a partial writer sharing an access unit with a disjoint read-only
> > >     field.
> > >
> > > Probe rejects overlapping logical fields involving a writer, another =
field
> > > inside a full-width writable access unit, cross-descriptor partial wr=
iters,
> > > unaligned accesses, and exact writable 64-bit aliases on 32-bit kerne=
ls.
> > > These layouts were not safely supported by the old per-descriptor loc=
k or
> > > generic writeq(); rejecting them turns possible corruption into a vis=
ible
> > > probe failure rather than removing working support.
> > >
> > > PCC access and locking
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > The PCC protocol requires OSPM to acquire the subspace before changin=
g its
> > > command or payload. Single-register and EPP updates now hold pcc_lock
> > > across ownership acquisition, payload staging, and command submission=
.
> > >
> > > ACPI 6.6's implementation example places a mandatory 32-bit Delivered
> > > Performance Counter at unaligned PCC offset 0x116. Performance contro=
ls may
> > > also use byte-multiple widths such as 24 bits. PCC therefore uses
> > > byte-oriented I/O with explicit little-endian encoding for zero-offse=
t,
> > > byte-multiple fields from 8 through 64 bits. A short per-subspace pay=
load
> > > lock protects concurrent aliased copies made under the shared side of
> > > pcc_lock; it does not replace the protocol ownership lock.
> > >
> > > Bit-level PCC fields require RMW and remain unsupported. An unsupport=
ed
> > > optional field is marked absent, but a present inaccessible CPPC Enab=
le
> > > fails probe because OSPM must write it before using CPPC. Thus the
> > > ACPI-legal one-bit CPPC Enable used by the specification example is a
> > > documented kernel limitation. The old accessor could not program it
> > > correctly either, so an explicit error is safer than silently proceed=
ing
> > > without enabling CPPC.
> > >
> > > Every retained PCC field is bounds checked against the shared-memory
> > > region. A subspace-keyed interval registry permits read-only overlap =
and
> > > exact same-control aliases while rejecting every other writable overl=
ap
> > > across processors.
> > >
> > > SystemIO support boundary
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > >
> > > SystemIO supports Bit Offset zero, full 8-, 16-, or 32-bit accesses e=
nding
> > > at or below port 0xffff, including legacy Access Size zero when Bit W=
idth
> > > supplies the size. Partial fields never worked because the driver nei=
ther
> > > shifted them nor preserved adjacent bits, so they now fail visibly in=
stead
> > > of being misprogrammed.
> > >
> > > On kernels without CONFIG_HAS_IOPORT, SystemIO entries are rejected o=
r
> > > disabled according to the affected control's semantics. Runtime acces=
sors
> > > also return -EOPNOTSUPP rather than treating an I/O port as a
> > > physical-memory address. A global port interval registry rejects
> > > cross-processor writable overlap.
> > >
> > > Write-only and Performance Limited controls
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Between _CPC revisions 3 and 4, Desired Performance changed from
> > > Read/Write to Write, and revision 4 added write-only OSPM Nominal
> > > Performance. ACPI 6.6 Section 4.6.3 says reads from write-only positi=
ons
> > > are undefined. Explicit reads of both controls are rejected, as are
> > > SystemMemory layouts which would implicitly read them for RMW. Full-w=
idth
> > > writes remain supported.
> > >
> > > Performance Limited is sticky, write-zero-to-clear, and requires
> > > interlocked accesses under ACPI 6.6 Section 8.4.6.1.3.2. The old sepa=
rate
> > > read and write could clear a new event reported between transactions.=
 The
> > > clear path now writes zero only to requested status bits and one to t=
he
> > > other defined bits. Partial SystemMemory forms cannot be used because=
 a
> > > spinlock cannot interlock an enclosing RMW with platform updates. QWo=
rd
> > > forms cannot be used on 32-bit kernels, where the MMIO accessor may b=
e
> > > split into two 32-bit operations; naturally aligned, full-width QWord=
s
> > > remain supported on 64-bit kernels. Since CPPC control does not depen=
d on
> > > Performance Limited status, an unusable description disables that sta=
tus
> > > register instead of rejecting the processor's otherwise usable _CPC.
> > >
> > > Lifetime and cleanup
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > CPC descriptors are released through their kobject callback, keeping =
their
> > > storage and mappings alive for outstanding sysfs references. Every PC=
C
> > > allocation, reference, and acquired channel is unwound on probe failu=
re,
> > > and the per-CPU PCC index is initialized before every early return. P=
CC
> > > allocation uses a separate temporary result, so its success cannot tu=
rn a
> > > later parse failure into a successful probe return.
> > >
> > > Changes since v2
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >   - Relaxed the exact NumEntries/package-count match to tolerate safe=
 trailing
> > >     package elements while still rejecting any count that could cause=
 an
> > >     out-of-bounds walk.
> > >   - Made patch 10 independently preserve immutable-autonomous setups =
whose
> > >     inaccessible Desired Performance register requires RMW, rather th=
an
> > >     relying on patch 11 to restore that exception.
> > >
> > > Sashiko v2 review not addressed
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >   - Kept Guaranteed Performance Buffer-only. The suggestion was to ac=
cept a
> > >     nonzero Integer, but ACPI 6.6 Table 8.23 permits only a Buffer fo=
r this
> > >     entry.
> > >
> > > Deferred follow-up work
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Sashiko also identified a broader pre-existing lifetime question whic=
h this
> > > series does not attempt to solve. In-kernel accessors read the per-CP=
U
> > > cpc_desc_ptr without acquiring a reference, while processor teardown =
can
> > > unpublish and eventually release the descriptor and its PCC data. The=
 kobject
> > > change here fixes the concrete sysfs lifetime bug, but a NULL pcc_dat=
a check
> > > would not protect a caller which already holds a stale pointer. Closi=
ng this
> > > properly requires defining the kernel accessor lifetime contract and =
then
> > > using CPU-hotplug serialization / safe referencing across all callers=
,
> > > therefore will be handled by a follow-up.
> > >
> > > ACPI-legal bit-level PCC and SystemIO fields also remain unsupported.=
 In
> > > particular, the ACPI example's one-bit PCC CPPC Enable register canno=
t be
> > > implemented by the old whole-value accessors. Supporting these descri=
ptions
> > > requires transport-specific field extraction and an RMW operation whi=
ch obeys
> > > PCC ownership or safely preserves adjacent SystemIO bits, just accept=
ing the
> > > descriptors would silently program the wrong value. Therefore continu=
e to
> > > disable optional inaccessible fields where safe and reject a present
> > > inaccessible CPPC Enable control.
> > > Full support, if even needed, belongs in a separate follow-up.
> > >
> > > The review additionally suggested validating the complete AML
> > > ResourceTemplate, including its EndTag. We currently validate the Reg=
ister
> > > descriptor we consume and tolerate trailing firmware data. I don't re=
ally
> > > see the point of ever doing this, but definitely not in this series,
> > > where I'm trying to guarantee that no reasonably working platform is
> > > regressing.
> > >
> > > Patches 1, 2, 4-7, and 9 address findings reported by Sashiko while
> > > reviewing:
> > >
> > >   https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.l=
oehle%40arm.com
> > >
> > > Patches 3, 5, 6, 9, 10, and 15 address findings from the follow-up re=
view:
> > >
> > >   https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.l=
oehle%40arm.com
> > >
> > > Patches 1 and 10 address findings from the v2 review:
> > >
> > >   https://sashiko.dev/#/patchset/20260808082644.1251332-1-christian.l=
oehle%40arm.com
> > >
> > > The series is based on Rafael's bleeding-edge
> > > 77acf59d7cf1 ("Merge branch 'acpi-cppc' into bleeding-edge")
> > > the base-commit specified below is linux-next for Sashiko review.
> > > It applies cleanly on either.
> > >
> > > Christian Loehle (15):
> > >   ACPI: CPPC: Validate the _CPC package header
> > >   ACPI: CPPC: Validate _CPC entry and control semantics
> > >   ACPI: CPPC: Propagate performance-control write errors
> > >   ACPI: CPPC: Use 64-bit masks for register fields
> > >   ACPI: CPPC: Serialize PCC single-register payload updates
> > >   ACPI: CPPC: Serialize PCC EPP payload updates
> > >   ACPI: CPPC: Release CPC descriptors through kobject
> > >   ACPI: CPPC: Release PCC data after probe failures
> > >   ACPI: CPPC: Reject unsafe cross-CPU SystemMemory RMW
> > >   ACPI: CPPC: Reject reads and RMW of write-only controls
> > >   ACPI: CPPC: Validate and access PCC register layouts
> > >   ACPI: CPPC: Validate SystemIO register layouts
> > >   ACPI: CPPC: Validate PCC overlaps across processors
> > >   ACPI: CPPC: Validate SystemIO overlaps across processors
> > >   ACPI: CPPC: Clear Performance Limited without a stale read
> > >
> > >  drivers/acpi/cppc_acpi.c | 1298 ++++++++++++++++++++++++++++++++----=
--
> > >  include/acpi/cppc_acpi.h |    7 +-
> > >  2 files changed, 1116 insertions(+), 189 deletions(-)
> > >
> > > base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
> >
> > Gentle ping on this in particular to the CCs not involved in the merge =
window.
> > Even just a Tested-by: that the new CPC validation didn't break your pl=
atform would
> > be appreciated!
>
> Yes, please.
>
> My current plan is to apply the first part of the series for 7.3-rc1
> tomorrow and queue up the rest of the series for 7.4 after the end of
> the merge window.

So I've gone ahead and applied the whole lot.

I plan to send a pull request with it by the end of the next week.

> Also, the other CPPC-related pending material is gated on this, so it
> won't get in before this series has been applied completely.

So this means until 7.3-rc1 is out if all goes well.
