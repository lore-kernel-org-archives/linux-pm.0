Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED45293EE;
	Wed, 16 Sep 2026 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576139; cv=none; b=Goof2l8tK1RP2CZIZc9sHN0RSmf0D0zBQVVw5I00dslVPepB/VonEEfq9FJYP/mCk0Jc19OsekuAscfqR7uVGHqbmL1jaLOGvx1YecefSQ5/vwGvRELGnVskrSX9pQzEIxuDYKPh+DMTkERk21+sLFlVo/Sww3BaClwhpr2AsS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576139; c=relaxed/simple;
	bh=+GWH8lgLg4HvnyhSrckaExsJdcchJNKi750cectG9qY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ggrotbu4hvc5rJnMHnR7xMjOLIyTWDbspQyBmiZxblK+lkkeorZA2g5NggrNNrEOD9aE8hFgeUH9+k9LnfSd1iqcfQBFbUS/fTt7OMsbxkaOxT8DCv+Gx/hatjJ/boEw7t4D7SvXXAy4Pzr3VYQlW4t9U2nivi57QptwBf+IX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KnMHbsTe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KnMHbsTe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D30EA1516;
	Wed, 16 Sep 2026 09:28:48 -0700 (PDT)
Received: from e127648.carmbridge.arm.com (unknown [10.0.129.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A57C63F7B4;
	Wed, 16 Sep 2026 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789576132; bh=+GWH8lgLg4HvnyhSrckaExsJdcchJNKi750cectG9qY=;
	h=From:To:Cc:Subject:Date:From;
	b=KnMHbsTeixKTJ4Hz2jnO8sfzb1bklqkG8CLGKKLhUeoJdqXj28tQh6LyAnvuYO0sT
	 gTfuBBoZnljKD3iIRDESgKSPLQHpLm/KizLjArd5v1gIktYRTeIj9KpAW3i9aNtK4N
	 CzzN+EJdVlAHsx4BPBuBc1i/icYx4AsMFghZX6Ak=
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
Subject: [PATCH v7 0/20] ACPI: CPPC: Fix register access and lifetime bugs
Date: Wed, 16 Sep 2026 17:27:45 +0100
Message-Id: <20260916162805.1039247-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes malformed _CPC handling, control-write error propagation,
PCC ownership and cleanup, CPC sysfs lifetime, register-field access,
cross-processor aliases, and Performance Limited clearing.

Series structure
================

Patches 1-7 cover parsing and control semantics, error propagation,
PCC update serialization, and descriptor/PCC cleanup. Patches 8-15
validate the register layouts and aliases which the existing accessors and
locking can safely support, and correct Performance Limited clearing.
Patch 16 bounds x86 and arm64 FFH fields before accessing hardware, checks
x86 MSR numbers, and dispatches FFH before generic Access Size decoding.
Patch 17 propagates failed cross-CPU FFH calls on arm64 and RISC-V before
using callback output, including counter reads for an offline CPU.
Patch 18 accepts a request to retain immutable Autonomous Selection as a
no-op, rejects unsupported amd-pstate transitions to passive mode before
changing state or removing the driver, and restores cppc-cpufreq's previous
mode if a later bounds update fails. The immutable-capability query is
serialized with descriptor publication and removal.
Patch 19 selects the frequency-invariance callback per CPU, avoiding
uninitialized deferred work in policies mixing PCC and direct counters.
Patch 20 creates the FIE worker when policy initialization encounters PCC
counters, before publishing callbacks. This covers offline and later-added
PCC members without making direct-counter FIE depend on worker setup.

The layout fixes are more substantial: a physical access unit can contain
several fields or be shared across processors and _PSD domains. Probe-time
interval registries enforce the assumptions of the existing
descriptor-local locking model. They add no lookup to the scheduler path;
standalone full-width SystemMemory writes remain lockless. Disjoint fields
within one descriptor retain their shared lock when their access units
overlap, including a full-width byte beside a wider partial-field access.

Behavior description
==================

The parser validates the package before indexing its entries and the
Generic Register descriptor consumed by the driver. It tolerates trailing
package/ResourceTemplate data and legacy Integer-zero absent controls.
Buffer-backed capabilities and bound readbacks are checked before narrowing
to u32. Minimum and Maximum Performance must form a usable pair, and
an explicit minimum-valid flag preserves a zero Minimum Performance
readback across cpufreq initialization and exit. Maximum Performance and
amd-pstate's unsaved firmware-minimum restore requests retain their existing
zero-means-omitted convention.

Lowest Performance must remain nonzero, as before the series. Accepting zero
needs separate changes to consumers which assume a zero frequency origin
or use a zero capability as an absence sentinel. This does not change the
explicit zero Minimum Performance update used to remove a lower bound.
Invalid firmware-provided Lowest/Nominal Frequency values remain an error.

PCC ownership is acquired before staging payload updates. Direct-only,
batched PCC, and mixed-address-space performance updates retain their
separate ordering requirements. PCC lifecycle locking and payload-copy
serialization protect different state.

Frequency-invariance policy teardown remembers which PCC work was
initialized, so it can drain that work after processor removal unpublishes
the CPC descriptor. Callback selection uses that same per-CPU initialization
state rather than looking up the potentially removed descriptor again.
Worker creation is serialized and occurs only when initializing PCC
counters, before that policy publishes callbacks. Setup failure leaves
that policy without FIE, but does not disable direct-counter or already
active policies. Direct-only systems create no worker or deadline
reservation. Direct-counter CPUs continue updating in the tick.
This does not solve the separate runtime-accessor lifetime races with
processor removal (which I will post in a later series).

SystemMemory permits read-only overlaps, supported exact writable aliases,
and safe descriptor-local partial writes. A full-width writer may share a
larger read access unit across descriptors when their logical fields are
disjoint. Only controls written by the CPPC library count as competing
writers (i.e. OSPM Nominal Performance is not written). Its write-only
readback protections still apply. The validation rejects cross-descriptor
partial writers which its locks cannot serialize and accesses which replay
a write-only neighbour's undefined readback. SystemIO permits read-only
aliases with write-only controls, but not with readable controls whose
readback would select the wrong register. Unsupported optional controls are
disabled only where doing so cannot silently change the operating mode.
Present but inaccessible Enable or Autonomous Selection controls fail
probe, including sub-byte PCC forms which the existing writer cannot
program. This may reject firmware-enabled configurations that previously
worked until the driver attempted an unsupported control access.
Optional-writer fallback only changes unpublished descriptors. A conflict
with an already-published writer can still fail probe; making recovery
independent of CPU discovery order requires runtime quiescence support.

Performance Limited is sticky, but ACPI does not define the effect of
writing one. A selective clear can either replay stale status or set a bit
on a plain read/write implementation. Write 0x3 to the perf_limited
attribute to clear both bits with one literal-zero register write;
selective clears return -EOPNOTSUPP. Partial SystemMemory/SystemIO status
fields remain readable but cannot be cleared generically. This is a status
acknowledgement, not a lossless event log.

Inaccessible status ranges remain visible to overlap validation without
being accessed. Sumit Gupta's NVIDIA T41 quirk widens only the verified
two-bit, offset-zero DWord descriptor whose remaining bits are unimplemented,
allowing that platform to use the safe clear-all operation.

The general SystemMemory/SystemIO alignment checks retain the x86 exception
for unaligned accesses. Performance Limited currently inherits that policy.
This is not a guarantee of an indivisible device transaction at an unaligned
address; the stricter status-atomicity question remains separate work. No
torn access or affected platform has been demonstrated by the reviews.

Testing
=======

An earlier iteration was built and booted on Orion O6-01, with CPPC sysfs,
frequency changes, advancing counters and module reloads checked. The
subsequent AMD transition guard and FIE fixes have passed source/model
checks and checkpatch, but this tip has not yet been built or booted.
Those checks are not AMD hardware, mixed-PCC hotplug or concurrency tests.

Changes since v6
================

Patch 1: Validate the _CPC package header
  Unchanged from v6.

Patch 2: Validate _CPC entry and control semantics
  Allow the full 64-bit Integer Counter Wraparound Time and emit FW_BUG
  once for tolerated legacy Integer-zero Buffer placeholders. (Rafael)
  Drop v6's zero Lowest Performance support: nonzero frequency anchors do
  not make it safe for all consumers. Retain the pre-series nonzero check.
  Reject Minimum/Maximum readbacks above U32_MAX before narrowing them.
  Keep only min_perf_valid: an explicit zero minimum removes a lower bound,
  whereas zero Maximum Performance retains its legacy omitted-update
  meaning. Document the flag and leave it clear for amd-pstate's unsaved
  firmware-minimum restore requests.

Patch 3: Propagate performance-control write errors
  Adjust for patch 2's minimum-only validity flag; a zero maximum remains
  an omitted update.

Patch 4: Serialize PCC single-register payload updates (v6 patch 5)
  Reject unsupported PCC widths before taking the exclusive lock, so a
  malformed request cannot abort an older valid performance batch.
  Match both subspace and generation when completing failed PCC writes;
  equal generation numbers in another subspace must not receive the error.

Patch 5: Serialize PCC EPP payload updates (v6 patch 6)
  Preflight PCC widths and SystemIO writer geometry before changing any
  direct control. This keeps the patch independently safe before the later
  probe-time layout validation. Pass the subspace to error completion.
  Patches 10 and 11 remove these preflights once probe guarantees them.

Patch 6: Release CPC descriptors through kobject (v6 patch 7)
  Track initialized PCC frequency-invariance work independently of the CPC
  descriptor, so policy exit still drains it after descriptor unpublication.
  Make the counter-transport query tolerate a missing descriptor. Broader
  runtime-accessor lifetime protection remains deferred.

Patch 7: Release PCC data after probe failures (v6 patch 8)
  No functional changes from v6. Only clarify the channel-reuse comment.

Patch 8: Reject unsafe cross-CPU SystemMemory RMW (v6 patch 9)
  Mark successful relaxed MMIO writes pending for lock-handoff ordering.
  Use the interval walk to lock both same-descriptor overlapping accesses,
  including mixed-width full/partial fields, without another overlap pass.
  Permit a full-width writer beside a disjoint logical read-only field,
  including across descriptors when the reader uses a larger access unit.
  Do not count OSPM Nominal Performance as a competing writer: Linux does
  not write it. Its write-only readback protections remain in patch 9.
  Exact-alias coalescing and representative promotion were already in v6
  and remain present; they are not additions in this version.

Patch 9: Reject direct reads of write-only controls (v6 patch 10)
  Also reject readable SystemMemory fields whose logical bits overlap a
  write-only control, including retained inaccessible fields. Treat a
  retained zero-width field conservatively before the no-writer shortcut.
  Reuse the logical-field overlap check instead of a separate full-width
  ownership helper. Remove the duplicate Desired Performance getter check;
  the common getter already enforces write-only semantics.

Patch 10: Validate and access PCC register layouts (v6 patch 11)
  Fail probe for a present inaccessible Autonomous Selection control,
  instead of hiding it without establishing the hardware's operating mode.
  Separate the final bound-pair check from mandatory-control validation.
  Remove setter PCC-width preflights once probe validates every published
  writer, and remove unreachable PCC branches in the memory accessors.
  Keep actual access-error handling and ownership serialization.

Patch 11: Validate SystemIO register layouts (v6 patch 12)
  Allow a read-only port alias with a write-only control, but reject aliases
  with readable controls whose readback would select the wrong register.
  Remove the EPP setter's duplicate SystemIO geometry preflight once probe
  enforces it. Read-only partial-field support and the x86 exception to
  natural alignment were already in v6 and remain unchanged.

Patch 12: Validate PCC overlaps across processors (v6 patch 13)
  Replace the separate same-descriptor overlap pass with registry checks.
  Drop v6's expansion to additional byte-multiple PCC writer widths; retain
  the existing 8/16/32/64-bit widths, subject to control-specific limits.
  Keep one interval record per descriptor entry; PCC alias coalescing is
  deferred. Correct Fixes to 80b8286aeec0 (CPPC request batching).

Patch 13: Validate SystemIO overlaps across processors (v6 patch 14)
  Apply patch 11's direction-aware alias policy across processors and
  remove the now-redundant same-descriptor overlap pass. Retain per-entry
  interval records; SystemIO alias coalescing remains deferred.

Patch 14: Clear Performance Limited without a stale read (v6 patch 15)
  Stop assuming write-zero-to-clear semantics for written ones. Reject
  selective clears and implement clear-all (sysfs 0x3) with one literal-zero
  register write, avoiding both stale readback and fabricated status. (Sumit)
  Extend the readable-but-not-clearable fallback to partial SystemIO fields.
  Extend inaccessible-range retention to PCC and SystemIO, including status
  crossing the PCC payload end or port 0xffff. PCC claims retain their own
  subspace without selecting or retaining an unnecessary access channel.
  Permit disabling only unpublished, disjoint optional SystemMemory writers
  which share a status access unit; never hide a required or Autonomous
  Selection control. Published writers are not changed during another probe.
  Compare bit geometry as well as byte ranges for exact PCC/SystemIO aliases,
  and count only accessible controls as writers in those registries.
  Make status fallback warnings once-only and document the clear-all and
  unsupported-access behavior in the sysfs ABI.

Patch 15: Keep Performance Limited clearable on NVIDIA T41 (new)
  Add Sumit's quirk for the verified two-bit, offset-zero DWord layout.
  Use a cached DSDT match and quirk flags, applying the fixup to the private
  GAS copy before validation and mapping. Distinguish lookup failures from
  non-matches and leave failures retryable. Keep all quirk plumbing here,
  so patch 14 remains independently buildable without unused declarations.

Patch 16: Validate FFH register fields before hardware access (new)
  Reject invalid x86 field geometry and GAS addresses that would truncate
  to another 32-bit MSR number. Bound arm64 AMU fields in both single and
  paired readers. Dispatch FFH before generic Access Size decoding can
  shift by an invalid amount using an architecture-specific field.

Patch 17: Propagate errors from cross-CPU FFH calls (new)
  Return failed SMP-call errors on arm64 and RISC-V before consuming
  uninitialized callback output. Also check RISC-V callback errors before
  copying a read value. Keep this as a separate backportable error-path fix.

Patch 18: Accept requests to retain immutable autonomous selection (new)
  Treat setting immutable Autonomous Selection Integer 1 to one as a
  successful no-op; disabling it still fails. Distinguish immutable-one
  descriptors from writable controls currently reading one. Reject an
  unsupported amd-pstate transition to passive before changing the mode or
  unregistering the working driver, checking known offline CPUs too.
  Serialize the immutable query with descriptor publication/removal,
  including probe failure, since CPU-hotplug locking does not pin it.
  On a later bounds-update failure, restore cppc-cpufreq's previous mode
  rather than always disabling selection.

Patch 19: Select the frequency-invariance callback per CPU (new)
  Register the PCC callback only on CPUs with PCC counters. A shared policy
  can also contain direct-counter CPUs, whose irq_work is not initialized.
  Select from the recorded work-initialization state, so descriptor removal
  between initialization and publication cannot change the callback choice.
  Keep callback registration after the complete counter-initialization
  pass, so an online CPU's failed initial read publishes no CPPC callbacks.

Patch 20: Create the FIE worker before enabling PCC callbacks (new)
  Create the worker when initializing PCC counters, rather than relying
  on an online-only startup scan. Serialize creation and reuse it until
  driver teardown. Offline members and later PCC policies are covered.
  On setup failure, skip FIE for that policy without changing the global
  setting or affecting existing policies. Direct-only systems do not
  allocate an unused worker or consume deadline admission bandwidth.

Dropped v6 patch 4: Use 64-bit masks for register fields
  All supported CPPC configurations are already 64-bit, so this is only
  a cleanup I'll submit later on.

Separate lifetime work
======================

The PCC mailbox teardown fixes are posted separately: [1] is their cover,
[2] frees the channel before unmapping its shared memory, and [3] serializes
channel updates with shared-memory teardown. They are not included here;
this series alone does not close the mailbox IRQ-teardown races.

[1] https://lore.kernel.org/all/20260903111328.805352-1-christian.loehle@arm.com/
[2] https://lore.kernel.org/all/20260903111328.805352-2-christian.loehle@arm.com/
[3] https://lore.kernel.org/all/20260903111328.805352-3-christian.loehle@arm.com/

Christian Loehle (19):
  ACPI: CPPC: Validate the _CPC package header
  ACPI: CPPC: Validate _CPC entry and control semantics
  ACPI: CPPC: Propagate performance-control write errors
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
  ACPI: CPPC: Validate FFH register fields before hardware access
  ACPI: CPPC: Propagate errors from cross-CPU FFH calls
  ACPI: CPPC: Accept requests to retain immutable autonomous selection
  cpufreq: CPPC: Select the frequency-invariance callback per CPU
  cpufreq: CPPC: Create the FIE worker before enabling PCC callbacks

Sumit Gupta (1):
  ACPI: CPPC: Keep Performance Limited clearable on NVIDIA T41

 Documentation/ABI/testing/sysfs-devices-system-cpu |   16 +-
 arch/arm64/kernel/topology.c                       |   14 +-
 arch/x86/kernel/acpi/cppc.c                        |   14 +
 drivers/acpi/cppc_acpi.c                           | 2209 +++++++++++++++++---
 drivers/acpi/riscv/cppc.c                          |   26 +-
 drivers/acpi/utils.c                               |   13 +-
 drivers/cpufreq/amd-pstate.c                       |   31 +-
 drivers/cpufreq/cppc_cpufreq.c                     |   73 +-
 include/acpi/cppc_acpi.h                           |   18 +-
 9 files changed, 2024 insertions(+), 390 deletions(-)

base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
--
2.34.1
