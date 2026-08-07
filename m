Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337B64766A1
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102676; cv=none; b=re7BTZGZwvTFyEnyBzQAHA+Pa3FjlwgNRDvdxydC52uyBFxfEXHPWS9QUSxqRDwmORLoBJE6IUW3cexEWP2k5+s7cUHP21N7448hPCc0enLcIs8EpIBKGAyGl44B6PfkvKyGJ3BQJ4OnQEGxclOmXPvxdLXnHZgkrw8ukcyqHBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102676; c=relaxed/simple;
	bh=MM5GtapRkJAPnyRknFZG6mSeF0vYacp6mnOwcKVLM+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2H89xfaQBGhaukWhyyvXX3hMhnzMypOih6dHMwec5aFQjnXOWqM1deJ4pGWq/Ic1Cb6NTeLuO/Mfgp7PuMJA4EUV0CrwRDva9ahQKmJUnjGWTByL01NdHvCProToRBco4EDDttKj8yvXW+TSKh9IGs8c1OuwvEW41ppaLu4PIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmChs4Ol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmChs4Ol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697211F00A3D
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786102669;
	bh=N5GOwi7FBPBU18RHR0YTpOFqaClgMcFBCONWFCcaeXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BmChs4Ol+HvqfIznuG2SjE0ViogY5JDcI5sqSI49tSTv/aSJV/LEAwe1xGsDFkpfJ
	 AK9Ns0UwP3tQoC78nxStOMBfFzCoLGGsvXeakEp9jwHAtu57bTYA/Ekpp4pI305nyD
	 jZOzEnlaWF8CfOgrKJ16boqiizIN0rOLxRIoIjI5FEi+YckW3+l+pgoPc8gpcVvfoD
	 XZqnwJhO1IYjc74W0YLi+QNB191l0Vq4kaGmdBvl+DtevGmOHeV4fF1M9YAXt/vHYM
	 ccJyImHQf+vEKiRYu9v/qI2H8idXqomh3jr8oi0aCVs8pHrTUf+RMUE0y3bApcWyrF
	 0W3iRqCrzxlFQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so2283171e87.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 04:37:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqImLjzZgOIPgGS5Dk+O3K/ZgilV9NeHntKeEZeA1icuh1adWcpANZAEYEI2A8U/SZWFooiLv6KcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQfeOhcU087zkkTtM1wqIHcAm5//Rv05ciYJ6lnl9UmxVbAHvw
	6jAK4fXE8vPVwc4OK1b7xPBTf7PRtEjRACs9hX6y9L5z1Nws+uIq6RUHxkQgm6BxuurfE0L24wH
	3HYWUOSDyw5WA5FBOVh3drVmYTrdjtAw=
X-Received: by 2002:a05:6512:1244:b0:5b2:eb46:1e61 with SMTP id
 2adb3069b0e04-5b3023b51edmr2085370e87.6.1786102667635; Fri, 07 Aug 2026
 04:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807111303.1062391-1-christian.loehle@arm.com>
In-Reply-To: <20260807111303.1062391-1-christian.loehle@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 13:37:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jFLousHhyXZ+u5D7Yi63eQYihsHojQ5j0gGwTSRGof7A@mail.gmail.com>
X-Gm-Features: AUfX_myVPGAtleQrXJdz0-mbYhCAv359PohFCLq4m5BanHDKUefmvGU9F_10sS8
Message-ID: <CAJZ5v0jFLousHhyXZ+u5D7Yi63eQYihsHojQ5j0gGwTSRGof7A@mail.gmail.com>
Subject: Re: [PATCH 00/15] ACPI: CPPC: Fix register access and lifetime bugs
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 1:13=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> First of all, sorry this got so out of hand, initially this was just
> trying to fix some relatively simple issues found by sashiko in an
> earlier (unrelated) series.

First of all, thanks for taking care of this!

> But with me touching more and more code and going through rounds of AI
> review that kept finding more and more pre-existing issues I've arrived
> at this.

So 7.4 material, overall.

> This series fixes correctness and robustness issues found while reviewing
> the CPPC control path. They affect malformed _CPC handling, error
> propagation, PCC ownership and cleanup, CPC object lifetime, register fie=
ld
> access, cross-processor aliases, and Performance Limited clearing.
>
> Series structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Patches 1-8 are deliberately small, independently useful fixes. They
> validate the _CPC encoding consumed by cppc-acpi, propagate control-write
> errors, serialize PCC payload updates, correct 64-bit field masks, and fi=
x
> descriptor and PCC lifetime handling.
>
> Patches 9-15 are the register-layout hardening portion. Geometry validati=
on
> is more substantial because safe RMW and alias handling depend on the
> physical access unit, not merely on a logical _CPC entry or _PSD domain.
> These patches normalize and validate each supported address space before
> building probe-only physical interval registries. Keeping this work in th=
e
> same posting gives the complete safety boundary and a single base for
> review, while each transport and bug retains its own Fixes provenance.
> Feel free to treat the two parts as independent series, I didn't split it
> because they're all technically fixes and to get Sashiko review for the
> whole lot.

OK

I may end up taking the first part in for the second half of the 7.3
merge window, but we'll see.  That depends on how much review from
people they get during the next week.

I generally would like to see some review of the entire series from
the people who care.

> No interval lookup is added to the scheduler hot path. Full-width
> SystemMemory writes remain lockless. RMW locking remains necessary only f=
or
> a partial field, where we must preserve the other bits in its access
> unit. The existing per-descriptor raw lock continues to cover disjoint
> partial fields within one _CPC package; probe rejects cross-descriptor
> layouts that it cannot protect.

It would be good to put the part below into documentation of some sort.

> Parsing and control semantics
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> The parser now validates the package header before indexing it, bounds th=
e
> BYTE and DWORD Integer forms before conversion, and validates the Generic
> Register descriptor consumed by cppc-acpi. It deliberately tolerates
> trailing ResourceTemplate data instead of imposing a new EndTag
> compatibility requirement.
>
> Writable controls must be Buffer-encoded registers. Minimum and Maximum
> Performance are checked as the pair required by ACPI 6.6 Sections
> 8.4.6.1.2.1 and 8.4.6.1.2.2. Object presence is kept separate from the
> Integer-zero convention for absent optional fields, so Lowest Performance
> may retain the valid abstract value zero.
>
> Performance Limited is one deliberate compatibility exception. ACPI lists
> it as required, but permits a platform with no limiting indication to
> always return zero, and deployed firmware represents that case with a NUL=
L
> descriptor. CPPC control does not depend on this status register, so we
> continues to accept that encoding. A present _CPC package which otherwise
> fails parsing or initialization now emits an error instead of silently
> preventing cpufreq registration.
>
> Compound performance and EPP updates propagate errors and perform every
> fallible non-PCC write before modifying the PCC payload. Updates across
> address spaces cannot be atomic, but a known non-PCC failure can no longe=
r
> commit only the PCC portion or leave an unsent value for a later command.
>
> SystemMemory locking and support boundary
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> A partial SystemMemory field requires RMW to preserve the rest of its
> access unit. Commit 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage") use=
d
> a per-_CPC lock and noted that a global lock would be needed if physical
> registers were shared between packages.
>
> ACPI does not make _PSD a physical-register ownership boundary. Rather th=
an
> put a global raw lock or lookup into the scheduler path, this series make=
s
> the cheaper per-descriptor model's assumptions enforceable at probe.
>
> Supported SystemMemory layouts are:
>
>   - naturally aligned 8-, 16-, 32-, and 64-bit access units;
>   - lockless full-width controls;
>   - read-only aliases;
>   - exact full-width writable aliases, including 64-bit aliases on 64-bit
>     kernels;
>   - disjoint partial writers within one descriptor, serialized by its
>     rmw_lock; and
>   - a partial writer sharing an access unit with a disjoint read-only
>     field.
>
> Probe rejects overlapping logical fields involving a writer, another fiel=
d
> inside a full-width writable access unit, cross-descriptor partial writer=
s,
> unaligned accesses, and exact writable 64-bit aliases on 32-bit kernels.
> These layouts were not safely supported by the old per-descriptor lock or
> generic writeq(); rejecting them turns possible corruption into a visible
> probe failure rather than removing working support.
>
> PCC access and locking
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The PCC protocol requires OSPM to acquire the subspace before changing it=
s
> command or payload. Single-register and EPP updates now hold pcc_lock
> across ownership acquisition, payload staging, and command submission.
>
> ACPI 6.6's implementation example places a mandatory 32-bit Delivered
> Performance Counter at unaligned PCC offset 0x116. Performance controls m=
ay
> also use byte-multiple widths such as 24 bits. PCC therefore uses
> byte-oriented I/O with explicit little-endian encoding for zero-offset,
> byte-multiple fields from 8 through 64 bits. A short per-subspace payload
> lock protects concurrent aliased copies made under the shared side of
> pcc_lock; it does not replace the protocol ownership lock.
>
> Bit-level PCC fields require RMW and remain unsupported. An unsupported
> optional field is marked absent, but a present inaccessible CPPC Enable
> fails probe because OSPM must write it before using CPPC. Thus the
> ACPI-legal one-bit CPPC Enable used by the specification example is a
> documented kernel limitation. The old accessor could not program it
> correctly either, so an explicit error is safer than silently proceeding
> without enabling CPPC.
>
> Every retained PCC field is bounds checked against the shared-memory
> region. A subspace-keyed interval registry permits read-only overlap and
> exact same-control aliases while rejecting every other writable overlap
> across processors.
>
> SystemIO support boundary
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> SystemIO supports Bit Offset zero, full 8-, 16-, or 32-bit accesses endin=
g
> at or below port 0xffff, including legacy Access Size zero when Bit Width
> supplies the size. Partial fields never worked because the driver neither
> shifted them nor preserved adjacent bits, so they now fail visibly instea=
d
> of being misprogrammed.
>
> On kernels without CONFIG_HAS_IOPORT, SystemIO entries are rejected or
> disabled according to the affected control's semantics. Runtime accessors
> also return -EOPNOTSUPP rather than treating an I/O port as a
> physical-memory address. A global port interval registry rejects
> cross-processor writable overlap.
>
> Write-only and Performance Limited controls
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Between _CPC revisions 3 and 4, Desired Performance changed from
> Read/Write to Write, and revision 4 added write-only OSPM Nominal
> Performance. ACPI 6.6 Section 4.6.3 says reads from write-only positions
> are undefined. Explicit reads of both controls are rejected, as are
> SystemMemory layouts which would implicitly read them for RMW. Full-width
> writes remain supported.
>
> Performance Limited is sticky, write-zero-to-clear, and requires
> interlocked accesses under ACPI 6.6 Section 8.4.6.1.3.2. The old separate
> read and write could clear a new event reported between transactions. The
> clear path now writes zero only to requested status bits and one to the
> other defined bits. Partial SystemMemory forms are rejected because a
> spinlock cannot interlock an enclosing RMW with platform updates. QWord
> forms are also rejected on 32-bit kernels, where the MMIO accessor may be
> split into two 32-bit operations; naturally aligned, full-width QWords
> remain supported on 64-bit kernels.
>
> Lifetime and cleanup
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> CPC descriptors are released through their kobject callback, keeping thei=
r
> storage and mappings alive for outstanding sysfs references. Every PCC
> allocation, reference, and acquired channel is unwound on probe failure,
> and the per-CPU PCC index is initialized before every early return. PCC
> allocation uses a separate temporary result, so its success cannot turn a
> later parse failure into a successful probe return.
>
>
> Patches 1, 2, 4-7, and 9 address findings reported by Sashiko while
> reviewing:
>
>   https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehl=
e%40arm.com
>
> The series is based on Rafael's bleeding-edge, the base-commit specified =
below is
> linux-next for Sashiko review.
>
> Christian Loehle (15):
>   ACPI: CPPC: Validate the _CPC package header
>   ACPI: CPPC: Validate _CPC entry and control semantics
>   ACPI: CPPC: Propagate performance-control write errors
>   ACPI: CPPC: Use 64-bit masks for register fields
>   ACPI: CPPC: Serialize PCC single-register payload updates
>   ACPI: CPPC: Serialize PCC EPP payload updates
>   ACPI: CPPC: Release CPC descriptors through kobject
>   ACPI: CPPC: Release PCC data after probe failures
>   ACPI: CPPC: Reject unsafe cross-CPU SystemMemory RMW
>   ACPI: CPPC: Reject reads and RMW of write-only controls
>   ACPI: CPPC: Validate and access PCC register layouts
>   ACPI: CPPC: Validate SystemIO register layouts
>   ACPI: CPPC: Validate PCC overlaps across processors
>   ACPI: CPPC: Validate SystemIO overlaps across processors
>   ACPI: CPPC: Clear Performance Limited without a stale read
>
>  drivers/acpi/cppc_acpi.c | 1231 ++++++++++++++++++++++++++++++++------
>  include/acpi/cppc_acpi.h |    7 +-
>  2 files changed, 1065 insertions(+), 173 deletions(-)
>
> base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
> --
> 2.34.1
>
