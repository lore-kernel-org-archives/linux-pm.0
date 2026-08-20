Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A79402432
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221955; cv=none; b=AIprsxdi6ZPWOxWsx2Y2BefvjIPkPanU+yedOrP/BBi3AKh9w9wKFAhmBZm9mdQP64n1d3R/jSAR7STwBN92Ywo/ViUjTYbmsaMiTGX5p/3LScq/TOxhuYmQ+XeWL3OFec3reGHava0xBAm+GP6YtEnv8l5wCt0Bo1TqHSLDwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221955; c=relaxed/simple;
	bh=sDPzYe9JncuwbZfBDhdtJ9fdDK6hZTVoySejR//PWlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVwvvwDXae7Kr1K7GK0vHXK0bnR1e2hm/Er61e4fYChbRmYnD/AmzxmCUREKEsCBYSnrGVtdmfHWhg22RJrc4mN/xcWf04SHaW7abPa8iCknFSDvsahklnIkzw8VXmAN/zsSwy3xPtK6zgH7ebfiIrtM0s5j9Gt2V/lCN4eE/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grXeOUuD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grXeOUuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64D41F00AC4
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 10:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787221953;
	bh=+fY1qokqOB5N+jK7I/HllteQjETL0RakTv8fU8h2cZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=grXeOUuDtRV7gKnVYhgTJjGHumGcyFKmwhsoLiptO4L6W75NXQjKwZRvxEEqge+Fr
	 /1G0stGjbB9D0yW89X5pH3GJ8gjE7gQkyVtULIZ9+67fMksvHoAWmxFnBabSBuIZHL
	 HXnag23fM9aMnoB0ZZ4PDiKz3iSuNNJe/gUDLLTOQNL4f5OvUAfM+cNtKJ+eUdmfLu
	 +3Vnqm65BfbPbuujsCchjaB0X7BZjK9Z6WA39/4HObdNqOsXbKkcklklH6ibbxVd42
	 13MsOadpKw6Uog5k2HBAw3/+pLuuNEHAyTPcL/AVAIIPgIqBBlu7EK5NodSP9/WnA7
	 uQBHiHPCFF+PQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so3412294e87.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 03:32:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrvw2YSRYLzcgNlMikbXu3y7ffrdUOpVbqlRvPg0/vKPhPZ4s3vhNdlPnZOP8cD/CgXO3zBK/q4vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCng056gXtxgxEmGq/VniEmhZSv/p4d8n8kDtL9FFKaUa3dnLB
	1ra1X0h1azyHnJYPljtK1Q09m2g1U5qRYZvh9xUsdJd1U4N8wdJ2OzE/9Ux2EPGNQ91FzQE6q+H
	0scFfvxnZKpP6R0Ol2taNpnHpmvsI1dc=
X-Received: by 2002:a05:6512:b91:b0:5b3:f69:ff05 with SMTP id
 2adb3069b0e04-5b478b762a4mr4037758e87.8.1787221952108; Thu, 20 Aug 2026
 03:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809062549.1415955-1-christian.loehle@arm.com> <15234e9c-b9a5-434d-836f-e2e2ebc036c9@arm.com>
In-Reply-To: <15234e9c-b9a5-434d-836f-e2e2ebc036c9@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 20 Aug 2026 12:31:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iEczt7CQYSsK5LpHKyRK7O97o+q1VE+-CSKS=HRFdpEw@mail.gmail.com>
X-Gm-Features: AcwNN1VsZVAftnERtkvkf8H9elQ9iou7bv5y2tHKnh6foL2h_KFq6T3IT_sif4A
Message-ID: <CAJZ5v0iEczt7CQYSsK5LpHKyRK7O97o+q1VE+-CSKS=HRFdpEw@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] ACPI: CPPC: Fix register access and lifetime bugs
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	jarredwhite@linux.microsoft.com, 
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
	Shubhang Kaushik OS <shubhang@os.amperecomputing.com>, vanshikonda@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 12:07=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 8/9/26 07:25, Christian Loehle wrote:
> > First of all, sorry this got so out of hand, initially this was just
> > trying to fix some relatively simple issues found by sashiko in an
> > earlier (unrelated) series.
> > But with me touching more and more code and going through rounds of AI
> > review that kept finding more and more pre-existing issues I've arrived
> > at this.
> >
> > This series fixes correctness and robustness issues found while reviewi=
ng
> > the CPPC control path. They affect malformed _CPC handling, error
> > propagation, PCC ownership and cleanup, CPC object lifetime, register f=
ield
> > access, cross-processor aliases, and Performance Limited clearing.
> >
> > Series structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Patches 1-8 are deliberately small, independently useful fixes. They
> > validate the _CPC encoding consumed by cppc-acpi, propagate control-wri=
te
> > errors, serialize PCC payload updates, correct 64-bit field masks, and =
fix
> > descriptor and PCC lifetime handling.
> >
> > Patches 9-15 are the register-layout hardening portion. Geometry valida=
tion
> > is more substantial because safe RMW and alias handling depend on the
> > physical access unit, not merely on a logical _CPC entry or _PSD domain=
.
> > These patches normalize and validate each supported address space befor=
e
> > building probe-only physical interval registries. Keeping this work in =
the
> > same posting gives the complete safety boundary and a single base for
> > review, while each transport and bug retains its own Fixes provenance.
> > Feel free to treat the two parts as independent series, I didn't split =
it
> > because they're all technically fixes and to get Sashiko review for the
> > whole lot.
> >
> > No interval lookup is added to the scheduler hot path. Full-width
> > SystemMemory writes remain lockless. RMW locking remains necessary only=
 for
> > a partial field, where we must preserve the other bits in its access
> > unit. The existing per-descriptor raw lock continues to cover disjoint
> > partial fields within one _CPC package; probe rejects cross-descriptor
> > layouts that it cannot protect.
> >
> > Parsing and control semantics
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >
> > The parser now validates the package header before indexing it, bounds =
the
> > BYTE and DWORD Integer forms before conversion, and validates the Gener=
ic
> > Register descriptor consumed by cppc-acpi. NumEntries may not exceed th=
e AML
> > package count, but additional trailing package elements are ignored bec=
ause
> > doing so is safe and preserves compatibility with padded firmware. The =
parser
> > likewise tolerates trailing ResourceTemplate data instead of imposing a=
 new
> > EndTag compatibility requirement.
> >
> > Writable controls must be Buffer-encoded registers. Minimum and Maximum
> > Performance are checked as the pair required by ACPI 6.6 Sections
> > 8.4.6.1.2.1 and 8.4.6.1.2.2. Object presence is kept separate from the
> > Integer-zero convention for absent optional fields, so Lowest Performan=
ce
> > may retain the valid abstract value zero.
> >
> > Performance Limited is one deliberate compatibility exception. ACPI lis=
ts
> > it as required, but permits a platform with no limiting indication to
> > always return zero, and deployed firmware represents that case with a N=
ULL
> > descriptor. CPPC control does not depend on this status register, so we
> > continue to accept that encoding. A present _CPC package which otherwis=
e
> > fails parsing or initialization now emits an error instead of silently
> > preventing cpufreq registration.
> >
> > Compound performance and EPP updates propagate errors and perform every
> > fallible non-PCC write before modifying the PCC payload. Updates across
> > address spaces cannot be atomic, but a known non-PCC failure can no lon=
ger
> > commit only the PCC portion or leave an unsent value for a later comman=
d.
> >
> > SystemMemory locking and support boundary
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > A partial SystemMemory field requires RMW to preserve the rest of its
> > access unit. Commit 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage") u=
sed
> > a per-_CPC lock and noted that a global lock would be needed if physica=
l
> > registers were shared between packages.
> >
> > ACPI does not make _PSD a physical-register ownership boundary. Rather =
than
> > put a global raw lock or lookup into the scheduler path, this series ma=
kes
> > the cheaper per-descriptor model's assumptions enforceable at probe.
> >
> > Supported SystemMemory layouts are:
> >
> >   - naturally aligned 8-, 16-, 32-, and 64-bit access units;
> >   - lockless full-width controls;
> >   - read-only aliases;
> >   - exact full-width writable aliases, including 64-bit aliases on 64-b=
it
> >     kernels;
> >   - disjoint partial writers within one descriptor, serialized by its
> >     rmw_lock; and
> >   - a partial writer sharing an access unit with a disjoint read-only
> >     field.
> >
> > Probe rejects overlapping logical fields involving a writer, another fi=
eld
> > inside a full-width writable access unit, cross-descriptor partial writ=
ers,
> > unaligned accesses, and exact writable 64-bit aliases on 32-bit kernels=
.
> > These layouts were not safely supported by the old per-descriptor lock =
or
> > generic writeq(); rejecting them turns possible corruption into a visib=
le
> > probe failure rather than removing working support.
> >
> > PCC access and locking
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The PCC protocol requires OSPM to acquire the subspace before changing =
its
> > command or payload. Single-register and EPP updates now hold pcc_lock
> > across ownership acquisition, payload staging, and command submission.
> >
> > ACPI 6.6's implementation example places a mandatory 32-bit Delivered
> > Performance Counter at unaligned PCC offset 0x116. Performance controls=
 may
> > also use byte-multiple widths such as 24 bits. PCC therefore uses
> > byte-oriented I/O with explicit little-endian encoding for zero-offset,
> > byte-multiple fields from 8 through 64 bits. A short per-subspace paylo=
ad
> > lock protects concurrent aliased copies made under the shared side of
> > pcc_lock; it does not replace the protocol ownership lock.
> >
> > Bit-level PCC fields require RMW and remain unsupported. An unsupported
> > optional field is marked absent, but a present inaccessible CPPC Enable
> > fails probe because OSPM must write it before using CPPC. Thus the
> > ACPI-legal one-bit CPPC Enable used by the specification example is a
> > documented kernel limitation. The old accessor could not program it
> > correctly either, so an explicit error is safer than silently proceedin=
g
> > without enabling CPPC.
> >
> > Every retained PCC field is bounds checked against the shared-memory
> > region. A subspace-keyed interval registry permits read-only overlap an=
d
> > exact same-control aliases while rejecting every other writable overlap
> > across processors.
> >
> > SystemIO support boundary
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > SystemIO supports Bit Offset zero, full 8-, 16-, or 32-bit accesses end=
ing
> > at or below port 0xffff, including legacy Access Size zero when Bit Wid=
th
> > supplies the size. Partial fields never worked because the driver neith=
er
> > shifted them nor preserved adjacent bits, so they now fail visibly inst=
ead
> > of being misprogrammed.
> >
> > On kernels without CONFIG_HAS_IOPORT, SystemIO entries are rejected or
> > disabled according to the affected control's semantics. Runtime accesso=
rs
> > also return -EOPNOTSUPP rather than treating an I/O port as a
> > physical-memory address. A global port interval registry rejects
> > cross-processor writable overlap.
> >
> > Write-only and Performance Limited controls
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Between _CPC revisions 3 and 4, Desired Performance changed from
> > Read/Write to Write, and revision 4 added write-only OSPM Nominal
> > Performance. ACPI 6.6 Section 4.6.3 says reads from write-only position=
s
> > are undefined. Explicit reads of both controls are rejected, as are
> > SystemMemory layouts which would implicitly read them for RMW. Full-wid=
th
> > writes remain supported.
> >
> > Performance Limited is sticky, write-zero-to-clear, and requires
> > interlocked accesses under ACPI 6.6 Section 8.4.6.1.3.2. The old separa=
te
> > read and write could clear a new event reported between transactions. T=
he
> > clear path now writes zero only to requested status bits and one to the
> > other defined bits. Partial SystemMemory forms cannot be used because a
> > spinlock cannot interlock an enclosing RMW with platform updates. QWord
> > forms cannot be used on 32-bit kernels, where the MMIO accessor may be
> > split into two 32-bit operations; naturally aligned, full-width QWords
> > remain supported on 64-bit kernels. Since CPPC control does not depend =
on
> > Performance Limited status, an unusable description disables that statu=
s
> > register instead of rejecting the processor's otherwise usable _CPC.
> >
> > Lifetime and cleanup
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > CPC descriptors are released through their kobject callback, keeping th=
eir
> > storage and mappings alive for outstanding sysfs references. Every PCC
> > allocation, reference, and acquired channel is unwound on probe failure=
,
> > and the per-CPU PCC index is initialized before every early return. PCC
> > allocation uses a separate temporary result, so its success cannot turn=
 a
> > later parse failure into a successful probe return.
> >
> > Changes since v2
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >   - Relaxed the exact NumEntries/package-count match to tolerate safe t=
railing
> >     package elements while still rejecting any count that could cause a=
n
> >     out-of-bounds walk.
> >   - Made patch 10 independently preserve immutable-autonomous setups wh=
ose
> >     inaccessible Desired Performance register requires RMW, rather than
> >     relying on patch 11 to restore that exception.
> >
> > Sashiko v2 review not addressed
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >   - Kept Guaranteed Performance Buffer-only. The suggestion was to acce=
pt a
> >     nonzero Integer, but ACPI 6.6 Table 8.23 permits only a Buffer for =
this
> >     entry.
> >
> > Deferred follow-up work
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Sashiko also identified a broader pre-existing lifetime question which =
this
> > series does not attempt to solve. In-kernel accessors read the per-CPU
> > cpc_desc_ptr without acquiring a reference, while processor teardown ca=
n
> > unpublish and eventually release the descriptor and its PCC data. The k=
object
> > change here fixes the concrete sysfs lifetime bug, but a NULL pcc_data =
check
> > would not protect a caller which already holds a stale pointer. Closing=
 this
> > properly requires defining the kernel accessor lifetime contract and th=
en
> > using CPU-hotplug serialization / safe referencing across all callers,
> > therefore will be handled by a follow-up.
> >
> > ACPI-legal bit-level PCC and SystemIO fields also remain unsupported. I=
n
> > particular, the ACPI example's one-bit PCC CPPC Enable register cannot =
be
> > implemented by the old whole-value accessors. Supporting these descript=
ions
> > requires transport-specific field extraction and an RMW operation which=
 obeys
> > PCC ownership or safely preserves adjacent SystemIO bits, just acceptin=
g the
> > descriptors would silently program the wrong value. Therefore continue =
to
> > disable optional inaccessible fields where safe and reject a present
> > inaccessible CPPC Enable control.
> > Full support, if even needed, belongs in a separate follow-up.
> >
> > The review additionally suggested validating the complete AML
> > ResourceTemplate, including its EndTag. We currently validate the Regis=
ter
> > descriptor we consume and tolerate trailing firmware data. I don't real=
ly
> > see the point of ever doing this, but definitely not in this series,
> > where I'm trying to guarantee that no reasonably working platform is
> > regressing.
> >
> > Patches 1, 2, 4-7, and 9 address findings reported by Sashiko while
> > reviewing:
> >
> >   https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loe=
hle%40arm.com
> >
> > Patches 3, 5, 6, 9, 10, and 15 address findings from the follow-up revi=
ew:
> >
> >   https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loe=
hle%40arm.com
> >
> > Patches 1 and 10 address findings from the v2 review:
> >
> >   https://sashiko.dev/#/patchset/20260808082644.1251332-1-christian.loe=
hle%40arm.com
> >
> > The series is based on Rafael's bleeding-edge
> > 77acf59d7cf1 ("Merge branch 'acpi-cppc' into bleeding-edge")
> > the base-commit specified below is linux-next for Sashiko review.
> > It applies cleanly on either.
> >
> > Christian Loehle (15):
> >   ACPI: CPPC: Validate the _CPC package header
> >   ACPI: CPPC: Validate _CPC entry and control semantics
> >   ACPI: CPPC: Propagate performance-control write errors
> >   ACPI: CPPC: Use 64-bit masks for register fields
> >   ACPI: CPPC: Serialize PCC single-register payload updates
> >   ACPI: CPPC: Serialize PCC EPP payload updates
> >   ACPI: CPPC: Release CPC descriptors through kobject
> >   ACPI: CPPC: Release PCC data after probe failures
> >   ACPI: CPPC: Reject unsafe cross-CPU SystemMemory RMW
> >   ACPI: CPPC: Reject reads and RMW of write-only controls
> >   ACPI: CPPC: Validate and access PCC register layouts
> >   ACPI: CPPC: Validate SystemIO register layouts
> >   ACPI: CPPC: Validate PCC overlaps across processors
> >   ACPI: CPPC: Validate SystemIO overlaps across processors
> >   ACPI: CPPC: Clear Performance Limited without a stale read
> >
> >  drivers/acpi/cppc_acpi.c | 1298 ++++++++++++++++++++++++++++++++------
> >  include/acpi/cppc_acpi.h |    7 +-
> >  2 files changed, 1116 insertions(+), 189 deletions(-)
> >
> > base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
>
> Gentle ping on this in particular to the CCs not involved in the merge wi=
ndow.
> Even just a Tested-by: that the new CPC validation didn't break your plat=
form would
> be appreciated!

Yes, please.

My current plan is to apply the first part of the series for 7.3-rc1
tomorrow and queue up the rest of the series for 7.4 after the end of
the merge window.

Also, the other CPPC-related pending material is gated on this, so it
won't get in before this series has been applied completely.

Thanks!
