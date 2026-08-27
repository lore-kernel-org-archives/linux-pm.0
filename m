Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE2C2F8E8A;
	Thu, 27 Aug 2026 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812273; cv=none; b=D/nwGEVPgebCGMnA8QQrb42zG1h/WDUSC3RkzwsVd0I2nYj9Rl3a1jdKfe2dcK1Cc8KwYc2vsT0Ff+Ex6cwgGm5jBI5rmrusu9b+R5+6xM134xqdiiTorEFaj1xiegrQL8XY6z/mAjgvPiqDJ7crXWHkgAGq9mFORD/bSJzN6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812273; c=relaxed/simple;
	bh=O03Oq6ceZ9TqW0sI1/CgazZY0U3i0impAVcmXtgD6h4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ryy8vUAUHHTHXC0d+N1tqvuTIgWDqI5X2kB22/UPVZ0cADoaZjRXypq4gx94aZllLqR/oJMiI2+SjgHGYwXsvbPYc3bgjFgoyr4TUTf9fD1P3E3x/+WvMs/9oZJgABkWuZnUh8Ik9gAAZWOk1Hw0DThBd+21G8rZNBWmgJ1bGqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r1pfjT25; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r1pfjT25"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AE3E1691;
	Wed, 26 Aug 2026 23:31:05 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.73.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E50063F85F;
	Wed, 26 Aug 2026 23:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787812269; bh=O03Oq6ceZ9TqW0sI1/CgazZY0U3i0impAVcmXtgD6h4=;
	h=From:To:Cc:Subject:Date:From;
	b=r1pfjT2521GcJEknPv93waVohgSsZ7tzWfwj9Iiscf+enXXRoE/n2i+6pypaYzXMn
	 IJfuhSChzjlnw1R+Ul7yGp4eUJVybHBHZ7kvvGBpkFxZDZs0GCBPSqKErlOoFx+HwP
	 E9t66rXr+5KRX0oWVlgCUnxcYbEPv/Qfdz0uKyEU=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	zhongqiu.han@oss.qualcomm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v5 00/15] ACPI: CPPC: Fix register access and lifetime bugs
Date: Thu, 27 Aug 2026 07:30:45 +0100
Message-Id: <20260827063100.2741066-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First of all, sorry this got so out of hand, initially this was just
trying to fix some relatively simple issues found by sashiko in an
earlier (unrelated) series.
But with me touching more and more code and going through rounds of AI
review that kept finding more and more pre-existing issues I've arrived
at this.

This series fixes correctness and robustness issues found while reviewing
the CPPC control path. They affect malformed _CPC handling, error
propagation, PCC ownership and cleanup, CPC object lifetime, register field
access, cross-processor aliases, and Performance Limited clearing.

Series structure
================

Patches 1-8 are deliberately small, independently useful fixes. They
validate the _CPC encoding consumed by cppc-acpi, propagate control-write
errors, serialize PCC payload updates, correct 64-bit field masks, and fix
descriptor and PCC lifetime handling.

Patches 9-15 are the register-layout hardening portion. Geometry validation
is more substantial because safe RMW and alias handling depend on the
physical access unit, not merely on a logical _CPC entry or _PSD domain.
These patches normalize and validate each supported address space before
building probe-only physical interval registries. Keeping this work in the
same posting gives the complete safety boundary and a single base for
review, while each transport and bug retains its own Fixes provenance.
Feel free to treat the two parts as independent series, I didn't split it
because they're all technically fixes and to get Sashiko review for the
whole lot.

No interval lookup is added to the scheduler hot path. Full-width
SystemMemory writes remain lockless. RMW locking remains necessary only for
a partial field, where we must preserve the other bits in its access
unit. The existing per-descriptor raw lock continues to cover disjoint
partial fields within one _CPC package; probe rejects cross-descriptor
layouts that it cannot protect.

Parsing and control semantics
=============================

The parser now validates the package header before indexing it, bounds the
BYTE and DWORD Integer forms before conversion, and validates the Generic
Register descriptor consumed by cppc-acpi. NumEntries may not exceed the
AML package count, but additional trailing package elements are ignored
because doing so is safe and preserves compatibility with padded firmware.
The parser likewise tolerates trailing ResourceTemplate data instead of
imposing a new EndTag compatibility requirement.

Capability values read from registers must also fit the u32 fields exposed
to CPPC callers. Reject wider values instead of truncating them, which could
otherwise turn Highest Performance into a zero divisor.

Writable controls must be Buffer-encoded registers. Minimum and Maximum
Performance are checked as the pair required by ACPI 6.6 Sections
8.4.6.1.2.1 and 8.4.6.1.2.2. Object presence is kept separate from the
Integer-zero convention for absent optional fields, so Lowest Performance
may retain the valid abstract value zero.

Performance Limited is one deliberate compatibility exception. ACPI lists
it as required, but permits a platform with no limiting indication to
always return zero, and deployed firmware represents that case with a NULL
descriptor. CPPC control does not depend on this status register, so we
continue to accept that encoding. A present _CPC package which otherwise
fails parsing or initialization now emits an error instead of silently
preventing cpufreq registration.

Compound performance and EPP updates propagate errors and perform every
fallible non-PCC write before modifying the PCC payload. Updates across
address spaces cannot be atomic, but a known non-PCC failure can no longer
commit only the PCC portion or leave an unsent value for a later command.
All requested PCC fields are validated before the first payload store, so
a malformed later field cannot leave an earlier value for a subsequent
doorbell to commit. Writable Minimum and Maximum Performance controls are
programmed even when their requested value is zero, because zero can be a
valid abstract performance level rather than an omitted update.

SystemMemory locking and support boundary
=========================================

A partial SystemMemory field requires RMW to preserve the rest of its
access unit. Commit 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage") used
a per-_CPC lock and noted that a global lock would be needed if physical
registers were shared between packages.

ACPI does not make _PSD a physical-register ownership boundary. Rather than
put a global raw lock or lookup into the scheduler path, this series makes
the cheaper per-descriptor model's assumptions enforceable at probe.

Supported SystemMemory layouts are:

  - naturally aligned 8-, 16-, 32-, and 64-bit access units;
  - lockless full-width controls;
  - read-only aliases;
  - exact full-width writable aliases, including 64-bit aliases on 64-bit
    kernels;
  - disjoint partial writers within one descriptor, serialized by its
    rmw_lock, when neither must preserve another write-only field; and
  - a partial writer sharing an access unit with a disjoint read-only
    field, except Performance Limited.

Probe rejects overlapping logical fields involving a writer, another field
inside a full-width writable access unit, cross-descriptor partial writers,
writers sharing Performance Limited's access unit, writers which would
preserve a write-only neighbour, unaligned accesses, and exact writable
64-bit aliases on 32-bit kernels. These layouts were not safely supported
by the old per-descriptor lock or generic writeq(); rejecting them turns
possible corruption into a visible probe failure rather than removing
working support.

PCC access and locking
======================

The PCC protocol requires OSPM to acquire the subspace before changing its
command or payload. Single-register and EPP updates now hold pcc_lock
across ownership acquisition, payload staging, and command submission.
Concurrent Phase-I callers intentionally store the same true value to the
pending-command flag under the shared side of pcc_lock, so that store uses
WRITE_ONCE(); transitions back to false remain exclusively locked.

ACPI 6.6's implementation example places a mandatory 32-bit Delivered
Performance Counter at unaligned PCC offset 0x116. Performance controls may
also use byte-multiple widths such as 24 bits. PCC therefore uses
byte-oriented I/O with explicit little-endian encoding for zero-offset,
byte-multiple fields from 8 through 64 bits. A short per-subspace payload
lock protects concurrent aliased copies made under the shared side of
pcc_lock; it does not replace the protocol ownership lock.

Bit-level PCC fields require RMW and remain unsupported. An unsupported
optional field is marked absent, but a present inaccessible CPPC Enable
fails probe because OSPM must write it before using CPPC. Thus the
ACPI-legal one-bit CPPC Enable used by the specification example is a
documented kernel limitation. The old accessor could not program it
correctly either, so an explicit error is safer than silently proceeding
without enabling CPPC.

Every retained PCC field is bounds checked against the shared-memory
region. A subspace-keyed interval registry permits read-only overlap and
exact same-control aliases while rejecting every other writable overlap
across processors. A lifecycle mutex serializes allocation, reference
updates, first channel setup, and teardown of each shared PCC object.

SystemIO support boundary
=========================

SystemIO supports Bit Offset zero, naturally aligned, full 8-, 16-, or
32-bit accesses ending at or below port 0xffff, including legacy Access
Size zero when Bit Width supplies the size. Partial fields never worked
because the driver neither shifted them nor preserved adjacent bits, so
they now fail visibly instead of being misprogrammed.

On kernels without CONFIG_HAS_IOPORT, SystemIO entries are rejected or
disabled according to the affected control's semantics. Runtime accessors
also return -EOPNOTSUPP rather than treating an I/O port as a
physical-memory address. A global port interval registry rejects
cross-processor writable overlap.

Write-only and Performance Limited controls
===========================================

Between _CPC revisions 3 and 4, Desired Performance changed from
Read/Write to Write, and revision 4 added write-only OSPM Nominal
Performance. ACPI 6.6 Section 4.6.3 says reads from write-only positions
are undefined. Explicit reads of both controls are rejected. Partial
SystemMemory fields remain writable because RMW replaces every bit of the
field and therefore does not propagate its undefined readback, provided no
other writer shares the access unit and would preserve that field.

Performance Limited is sticky, write-zero-to-clear, and requires
interlocked accesses under ACPI 6.6 Section 8.4.6.1.3.2. The old separate
read and write could clear a new event reported between transactions. The
clear path now writes zero only to requested status bits and one to the
other defined bits. Partial SystemMemory forms remain readable but cannot
be cleared because a spinlock cannot interlock an enclosing RMW with
platform updates. Probe also rejects another writable field sharing its
access unit. QWord forms cannot be used on 32-bit kernels, where the MMIO
accessor may be split into two 32-bit operations; naturally aligned,
full-width QWords remain supported on 64-bit kernels. Since CPPC control
does not depend on Performance Limited status, an unreadable description
disables that status register instead of rejecting the processor's
otherwise usable _CPC.

Lifetime and cleanup
====================

CPC descriptors are released through their kobject callback, keeping their
storage and mappings alive for outstanding sysfs references. Every PCC
allocation, reference, and acquired channel is unwound on probe failure,
and the per-CPU PCC index is initialized before every early return. PCC
allocation uses a separate temporary result, so its success cannot turn a
later parse failure into a successful probe return. Shared PCC allocation,
reference updates, channel initialization, and teardown are serialized. A
repeated processor start reuses an already published descriptor instead of
resetting its PCC index and leaking or detaching the existing state.

Changes since v4
================

  - Validated all requested PCC control widths before the first payload
    store, preventing a later malformed field from leaving an earlier
    staged value for a subsequent doorbell to commit.
  - Marked the intentional concurrent same-value pending-command store with
    WRITE_ONCE().
  - Serialized shared PCC allocation, reference updates, channel setup, and
    teardown, and published channel readiness only after initializing its
    lock and wait queue.
  - Rejected another writable field sharing a SystemMemory access unit with
    a write-only field, because its RMW would preserve and replay undefined
    readback.
  - Rejected capability values which do not fit the u32 interface instead
    of allowing truncation and a possible zero divisor.
  - Programmed writable Minimum and Maximum Performance controls when the
    requested value is zero, which is valid when Lowest Performance is zero.
  - Reused an existing CPC descriptor on a repeated processor start instead
    of resetting its PCC index before a retry could fail.

Changes since v3
================

  - Allowed partial SystemMemory Desired and OSPM Nominal controls when RMW
    discards their undefined readback, supporting NVIDIA's separate 9-bit
    controls in _CPC revision 4.
  - Reported an unavailable Desired Performance control as unsupported from
    the common getter instead of returning a synthetic zero.
  - Required natural alignment for SystemIO access units, preventing faults
    on architectures which implement port I/O through Device-memory MMIO.
  - Kept partial Performance Limited fields readable but not clearable,
    rejected another writer sharing their access unit, reported fully
    inaccessible forms as unsupported instead of returning a synthetic
    zero, and consolidated each nonfatal fallback into a single warning.

Changes since v2
================

  - Relaxed the exact NumEntries/package-count match to tolerate safe
    trailing package elements while still rejecting any count that could
    cause an out-of-bounds walk.
  - Made patch 10 independently preserve immutable-autonomous setups whose
    inaccessible Desired Performance register requires RMW, rather than
    relying on patch 11 to restore that exception.

Sashiko v2 review not addressed
===============================

  - Kept Guaranteed Performance Buffer-only. The suggestion was to accept a
    nonzero Integer, but ACPI 6.6 Table 8.23 permits only a Buffer for this
    entry.

Sashiko v4 review requiring no code change
==========================================

  - Kept nonzero Integers restricted to entries whose object type includes
    Integer in ACPI 6.6 Table 8.23. Guaranteed Performance and Energy
    Performance Preference are Buffer-only registers.
  - Kept Desired Performance optional only when OSPM advertises CPPC2 and
    Autonomous Selection Enable is encoded as Integer 1. ACPI 6.6 Section
    8.4.6.1.2.3 explicitly requires that immutable encoding; a writable
    Buffer does not qualify.

Deferred follow-up work
=======================

Sashiko also identified a broader pre-existing lifetime question which this
series does not attempt to solve. In-kernel accessors read the per-CPU
cpc_desc_ptr without acquiring a reference, while processor teardown can
unpublish and eventually release the descriptor and its PCC data. The
kobject change here fixes the concrete sysfs lifetime bug, but a NULL
pcc_data check would not protect a caller which already holds a stale
pointer. Closing this properly requires defining the kernel accessor
lifetime contract and then using CPU-hotplug serialization / safe
referencing across all callers, therefore will be handled by a follow-up.

ACPI-legal bit-level PCC and SystemIO fields also remain unsupported. In
particular, the ACPI example's one-bit PCC CPPC Enable register cannot be
implemented by the old whole-value accessors. Supporting these
descriptions requires transport-specific field extraction and an RMW
operation which obeys PCC ownership or safely preserves adjacent SystemIO
bits, just accepting the descriptors would silently program the wrong
value. Therefore continue to disable optional inaccessible fields where
safe and reject a present inaccessible CPPC Enable control.
Full support, if even needed, belongs in a separate follow-up.

The review additionally suggested validating the complete AML
ResourceTemplate, including its EndTag. We currently validate the Register
descriptor we consume and tolerate trailing firmware data. I don't really
see the point of ever doing this, but definitely not in this series,
where I'm trying to guarantee that no reasonably working platform is
regressing.

Patches 1, 2, 4-7, and 9 address findings reported by Sashiko while
reviewing:

  https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com

Patches 3, 5, 6, 9, 10, and 15 address findings from the follow-up review:

  https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com

Patches 1 and 10 address findings from the v2 review:

  https://sashiko.dev/#/patchset/20260808082644.1251332-1-christian.loehle%40arm.com

The series is based on Linus' tree.

Christian Loehle (15):
  ACPI: CPPC: Validate the _CPC package header
  ACPI: CPPC: Validate _CPC entry and control semantics
  ACPI: CPPC: Propagate performance-control write errors
  ACPI: CPPC: Use 64-bit masks for register fields
  ACPI: CPPC: Serialize PCC single-register payload updates
  ACPI: CPPC: Serialize PCC EPP payload updates
  ACPI: CPPC: Release CPC descriptors through kobject
  ACPI: CPPC: Release PCC data after probe failures
  ACPI: CPPC: Reject unsafe cross-CPU SystemMemory RMW
  ACPI: CPPC: Reject direct reads of write-only controls
  ACPI: CPPC: Validate and access PCC register layouts
  ACPI: CPPC: Validate SystemIO register layouts
  ACPI: CPPC: Validate PCC overlaps across processors
  ACPI: CPPC: Validate SystemIO overlaps across processors
  ACPI: CPPC: Clear Performance Limited without a stale read

 drivers/acpi/cppc_acpi.c | 1438 ++++++++++++++++++++++++++++++++++++++--------
 include/acpi/cppc_acpi.h |    8 +-
 2 files changed, 1217 insertions(+), 229 deletions(-)

base-commit: b81e34131907d2c243c51117a4aff8dbe22ccc9c
--
2.34.1
