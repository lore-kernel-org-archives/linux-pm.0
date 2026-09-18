Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499EC3090C2
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745503; cv=none; b=u6mM6sSHui/nUmcg5UbSx2JHew69PzOPdV66AxHgc0wVVV1rCHkgOawcDLjR6SwlUlHnSTWrm1silhNtNdVLmKkqcmlX8AVRatZ0BhkII08RoU1xIHu90tEB5HnPxO1s/ljp0/p61s3vXuagvQqn1UB1OQ8BaDYB+rmWL0M25mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745503; c=relaxed/simple;
	bh=NYpfN1QHa7+IeiVK9GnrGAPwxafbXLCF1X62l0Ah3Qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Niczv+HlBZg6lcKeltx1uMan22FU/bS7j5rAtXDRDa1HK2SK0EKTvyy91fxUJsoCrDuw7amyMrxE8p3nsdsrH8zocOziQykoLdI9GkXSUZXUPBa6bimgkHKqm9FwKs8iXjs+TBycwPZ3htgwb/FFe5qy4AyXlazI7eGPK0z6TOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLNPmfXs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLNPmfXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D327E1F000FF
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745501;
	bh=6qsHazZAB3tm1KKBiR8k6LTPxnI7bhlnvhEBpphtxJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aLNPmfXsKqwHpTSBXYb4Ez4NLJv4TuYCBCpWto0+fxgII7rW1k2C8zuN1vAZ1G5bu
	 H6Wvz2dHWG83+6koYO8Bxfrsgg2+rsvsN92o2AkjGvXajn5BoJUUv8Ar4JySAkSyie
	 vMMIilDTRyVP+IaLZV2gji36brp4uz1dOXgkkTq9137RnWJjwL66QKTXSp6oD//q4c
	 EepF8KZKAGsria529+pxhpwZHVM+Lzf7gTOO+XFdK5kI05V+EsB/38k6QgwbAPL0bz
	 j9bCTVkeVqNK11FH8dryePxQVlhWEYslew297fSFyPV69sajWfV88WL6ur844QwS99
	 1j6XKgZcb2UWw==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d5eso8675511fa.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 08:31:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz1Rc9XkwhW5Z4MfYbjaWv9kN29w7evMxkCGKF8Q/LqoCxmTBLO4B1isHOatSOfAYTLseFRWwsGow==@vger.kernel.org
X-Gm-Message-State: AFuF++l45JepCrjhjDl7WP1dmEr7ZI9QBhSxVPJSP4VUSbBQNK6c0xM/
	NqE+wNe6aGf9pzeBn3gEtFknwgcr9lE6h1SoETvR8AWF9KTsqlBvYoUnbPH/uz0tjG/7BHuCGcX
	Et86A76EnZ044RcIIYoIW9VTK4IhRFzQ=
X-Received: by 2002:a2e:a803:0:b0:3a3:2a41:e33b with SMTP id
 38308e7fff4ca-3a5fc058e9fmr6211221fa.14.1789745499024; Fri, 18 Sep 2026
 08:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916162805.1039247-1-christian.loehle@arm.com> <4882af43-844f-4b99-bc8e-213da21a579c@nvidia.com>
In-Reply-To: <4882af43-844f-4b99-bc8e-213da21a579c@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 18 Sep 2026 17:30:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hsEQjPcUr7+6Kbnh=YHdjT9ZMvzcPMfs6ZDHENfJ4jBA@mail.gmail.com>
X-Gm-Features: AcwNN1VvKSR71oIzCNVhZhgpdF8t7UkQsdhZCedDI5G7jYLSnZdOgJVQHKxsREc
Message-ID: <CAJZ5v0hsEQjPcUr7+6Kbnh=YHdjT9ZMvzcPMfs6ZDHENfJ4jBA@mail.gmail.com>
Subject: Re: [PATCH v7 0/20] ACPI: CPPC: Fix register access and lifetime bugs
To: Sumit Gupta <sumitg@nvidia.com>, Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 8:31=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
> Hi Christian,
>
>
> On 16/09/26 21:57, Christian Loehle wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > This series fixes malformed _CPC handling, control-write error propagat=
ion,
> > PCC ownership and cleanup, CPC sysfs lifetime, register-field access,
> > cross-processor aliases, and Performance Limited clearing.
> >
> > Series structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Patches 1-7 cover parsing and control semantics, error propagation,
> > PCC update serialization, and descriptor/PCC cleanup. Patches 8-15
> > validate the register layouts and aliases which the existing accessors =
and
> > locking can safely support, and correct Performance Limited clearing.
> > Patch 16 bounds x86 and arm64 FFH fields before accessing hardware, che=
cks
> > x86 MSR numbers, and dispatches FFH before generic Access Size decoding=
.
> > Patch 17 propagates failed cross-CPU FFH calls on arm64 and RISC-V befo=
re
> > using callback output, including counter reads for an offline CPU.
> > Patch 18 accepts a request to retain immutable Autonomous Selection as =
a
> > no-op, rejects unsupported amd-pstate transitions to passive mode befor=
e
> > changing state or removing the driver, and restores cppc-cpufreq's prev=
ious
> > mode if a later bounds update fails. The immutable-capability query is
> > serialized with descriptor publication and removal.
> > Patch 19 selects the frequency-invariance callback per CPU, avoiding
> > uninitialized deferred work in policies mixing PCC and direct counters.
> > Patch 20 creates the FIE worker when policy initialization encounters P=
CC
> > counters, before publishing callbacks. This covers offline and later-ad=
ded
> > PCC members without making direct-counter FIE depend on worker setup.
> >
> > The layout fixes are more substantial: a physical access unit can conta=
in
> > several fields or be shared across processors and _PSD domains. Probe-t=
ime
> > interval registries enforce the assumptions of the existing
> > descriptor-local locking model. They add no lookup to the scheduler pat=
h;
> > standalone full-width SystemMemory writes remain lockless. Disjoint fie=
lds
> > within one descriptor retain their shared lock when their access units
> > overlap, including a full-width byte beside a wider partial-field acces=
s.
> >
> > Behavior description
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The parser validates the package before indexing its entries and the
> > Generic Register descriptor consumed by the driver. It tolerates traili=
ng
> > package/ResourceTemplate data and legacy Integer-zero absent controls.
> > Buffer-backed capabilities and bound readbacks are checked before narro=
wing
> > to u32. Minimum and Maximum Performance must form a usable pair, and
> > an explicit minimum-valid flag preserves a zero Minimum Performance
> > readback across cpufreq initialization and exit. Maximum Performance an=
d
> > amd-pstate's unsaved firmware-minimum restore requests retain their exi=
sting
> > zero-means-omitted convention.
> >
> > Lowest Performance must remain nonzero, as before the series. Accepting=
 zero
> > needs separate changes to consumers which assume a zero frequency origi=
n
> > or use a zero capability as an absence sentinel. This does not change t=
he
> > explicit zero Minimum Performance update used to remove a lower bound.
> > Invalid firmware-provided Lowest/Nominal Frequency values remain an err=
or.
> >
> > PCC ownership is acquired before staging payload updates. Direct-only,
> > batched PCC, and mixed-address-space performance updates retain their
> > separate ordering requirements. PCC lifecycle locking and payload-copy
> > serialization protect different state.
> >
> > Frequency-invariance policy teardown remembers which PCC work was
> > initialized, so it can drain that work after processor removal unpublis=
hes
> > the CPC descriptor. Callback selection uses that same per-CPU initializ=
ation
> > state rather than looking up the potentially removed descriptor again.
> > Worker creation is serialized and occurs only when initializing PCC
> > counters, before that policy publishes callbacks. Setup failure leaves
> > that policy without FIE, but does not disable direct-counter or already
> > active policies. Direct-only systems create no worker or deadline
> > reservation. Direct-counter CPUs continue updating in the tick.
> > This does not solve the separate runtime-accessor lifetime races with
> > processor removal (which I will post in a later series).
> >
> > SystemMemory permits read-only overlaps, supported exact writable alias=
es,
> > and safe descriptor-local partial writes. A full-width writer may share=
 a
> > larger read access unit across descriptors when their logical fields ar=
e
> > disjoint. Only controls written by the CPPC library count as competing
> > writers (i.e. OSPM Nominal Performance is not written). Its write-only
> > readback protections still apply. The validation rejects cross-descript=
or
> > partial writers which its locks cannot serialize and accesses which rep=
lay
> > a write-only neighbour's undefined readback. SystemIO permits read-only
> > aliases with write-only controls, but not with readable controls whose
> > readback would select the wrong register. Unsupported optional controls=
 are
> > disabled only where doing so cannot silently change the operating mode.
> > Present but inaccessible Enable or Autonomous Selection controls fail
> > probe, including sub-byte PCC forms which the existing writer cannot
> > program. This may reject firmware-enabled configurations that previousl=
y
> > worked until the driver attempted an unsupported control access.
> > Optional-writer fallback only changes unpublished descriptors. A confli=
ct
> > with an already-published writer can still fail probe; making recovery
> > independent of CPU discovery order requires runtime quiescence support.
> >
> > Performance Limited is sticky, but ACPI does not define the effect of
> > writing one. A selective clear can either replay stale status or set a =
bit
> > on a plain read/write implementation. Write 0x3 to the perf_limited
> > attribute to clear both bits with one literal-zero register write;
> > selective clears return -EOPNOTSUPP. Partial SystemMemory/SystemIO stat=
us
> > fields remain readable but cannot be cleared generically. This is a sta=
tus
> > acknowledgement, not a lossless event log.
> >
> > Inaccessible status ranges remain visible to overlap validation without
> > being accessed. Sumit Gupta's NVIDIA T41 quirk widens only the verified
> > two-bit, offset-zero DWord descriptor whose remaining bits are unimplem=
ented,
> > allowing that platform to use the safe clear-all operation.
> >
> > The general SystemMemory/SystemIO alignment checks retain the x86 excep=
tion
> > for unaligned accesses. Performance Limited currently inherits that pol=
icy.
> > This is not a guarantee of an indivisible device transaction at an unal=
igned
> > address; the stricter status-atomicity question remains separate work. =
No
> > torn access or affected platform has been demonstrated by the reviews.
> >
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > An earlier iteration was built and booted on Orion O6-01, with CPPC sys=
fs,
> > frequency changes, advancing counters and module reloads checked. The
> > subsequent AMD transition guard and FIE fixes have passed source/model
> > checks and checkpatch, but this tip has not yet been built or booted.
> > Those checks are not AMD hardware, mixed-PCC hotplug or concurrency tes=
ts.
> >
> > Changes since v6
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Patch 1: Validate the _CPC package header
> >    Unchanged from v6.
> >
> > Patch 2: Validate _CPC entry and control semantics
> >    Allow the full 64-bit Integer Counter Wraparound Time and emit FW_BU=
G
> >    once for tolerated legacy Integer-zero Buffer placeholders. (Rafael)
> >    Drop v6's zero Lowest Performance support: nonzero frequency anchors=
 do
> >    not make it safe for all consumers. Retain the pre-series nonzero ch=
eck.
> >    Reject Minimum/Maximum readbacks above U32_MAX before narrowing them=
.
> >    Keep only min_perf_valid: an explicit zero minimum removes a lower b=
ound,
> >    whereas zero Maximum Performance retains its legacy omitted-update
> >    meaning. Document the flag and leave it clear for amd-pstate's unsav=
ed
> >    firmware-minimum restore requests.
> >
> > Patch 3: Propagate performance-control write errors
> >    Adjust for patch 2's minimum-only validity flag; a zero maximum rema=
ins
> >    an omitted update.
> >
> > Patch 4: Serialize PCC single-register payload updates (v6 patch 5)
> >    Reject unsupported PCC widths before taking the exclusive lock, so a
> >    malformed request cannot abort an older valid performance batch.
> >    Match both subspace and generation when completing failed PCC writes=
;
> >    equal generation numbers in another subspace must not receive the er=
ror.
> >
> > Patch 5: Serialize PCC EPP payload updates (v6 patch 6)
> >    Preflight PCC widths and SystemIO writer geometry before changing an=
y
> >    direct control. This keeps the patch independently safe before the l=
ater
> >    probe-time layout validation. Pass the subspace to error completion.
> >    Patches 10 and 11 remove these preflights once probe guarantees them=
.
> >
> > Patch 6: Release CPC descriptors through kobject (v6 patch 7)
> >    Track initialized PCC frequency-invariance work independently of the=
 CPC
> >    descriptor, so policy exit still drains it after descriptor unpublic=
ation.
> >    Make the counter-transport query tolerate a missing descriptor. Broa=
der
> >    runtime-accessor lifetime protection remains deferred.
> >
> > Patch 7: Release PCC data after probe failures (v6 patch 8)
> >    No functional changes from v6. Only clarify the channel-reuse commen=
t.
> >
> > Patch 8: Reject unsafe cross-CPU SystemMemory RMW (v6 patch 9)
> >    Mark successful relaxed MMIO writes pending for lock-handoff orderin=
g.
> >    Use the interval walk to lock both same-descriptor overlapping acces=
ses,
> >    including mixed-width full/partial fields, without another overlap p=
ass.
> >    Permit a full-width writer beside a disjoint logical read-only field=
,
> >    including across descriptors when the reader uses a larger access un=
it.
> >    Do not count OSPM Nominal Performance as a competing writer: Linux d=
oes
> >    not write it. Its write-only readback protections remain in patch 9.
> >    Exact-alias coalescing and representative promotion were already in =
v6
> >    and remain present; they are not additions in this version.
> >
> > Patch 9: Reject direct reads of write-only controls (v6 patch 10)
> >    Also reject readable SystemMemory fields whose logical bits overlap =
a
> >    write-only control, including retained inaccessible fields. Treat a
> >    retained zero-width field conservatively before the no-writer shortc=
ut.
> >    Reuse the logical-field overlap check instead of a separate full-wid=
th
> >    ownership helper. Remove the duplicate Desired Performance getter ch=
eck;
> >    the common getter already enforces write-only semantics.
> >
> > Patch 10: Validate and access PCC register layouts (v6 patch 11)
> >    Fail probe for a present inaccessible Autonomous Selection control,
> >    instead of hiding it without establishing the hardware's operating m=
ode.
> >    Separate the final bound-pair check from mandatory-control validatio=
n.
> >    Remove setter PCC-width preflights once probe validates every publis=
hed
> >    writer, and remove unreachable PCC branches in the memory accessors.
> >    Keep actual access-error handling and ownership serialization.
> >
> > Patch 11: Validate SystemIO register layouts (v6 patch 12)
> >    Allow a read-only port alias with a write-only control, but reject a=
liases
> >    with readable controls whose readback would select the wrong registe=
r.
> >    Remove the EPP setter's duplicate SystemIO geometry preflight once p=
robe
> >    enforces it. Read-only partial-field support and the x86 exception t=
o
> >    natural alignment were already in v6 and remain unchanged.
> >
> > Patch 12: Validate PCC overlaps across processors (v6 patch 13)
> >    Replace the separate same-descriptor overlap pass with registry chec=
ks.
> >    Drop v6's expansion to additional byte-multiple PCC writer widths; r=
etain
> >    the existing 8/16/32/64-bit widths, subject to control-specific limi=
ts.
> >    Keep one interval record per descriptor entry; PCC alias coalescing =
is
> >    deferred. Correct Fixes to 80b8286aeec0 (CPPC request batching).
> >
> > Patch 13: Validate SystemIO overlaps across processors (v6 patch 14)
> >    Apply patch 11's direction-aware alias policy across processors and
> >    remove the now-redundant same-descriptor overlap pass. Retain per-en=
try
> >    interval records; SystemIO alias coalescing remains deferred.
> >
> > Patch 14: Clear Performance Limited without a stale read (v6 patch 15)
> >    Stop assuming write-zero-to-clear semantics for written ones. Reject
> >    selective clears and implement clear-all (sysfs 0x3) with one litera=
l-zero
> >    register write, avoiding both stale readback and fabricated status. =
(Sumit)
> >    Extend the readable-but-not-clearable fallback to partial SystemIO f=
ields.
> >    Extend inaccessible-range retention to PCC and SystemIO, including s=
tatus
> >    crossing the PCC payload end or port 0xffff. PCC claims retain their=
 own
> >    subspace without selecting or retaining an unnecessary access channe=
l.
> >    Permit disabling only unpublished, disjoint optional SystemMemory wr=
iters
> >    which share a status access unit; never hide a required or Autonomou=
s
> >    Selection control. Published writers are not changed during another =
probe.
> >    Compare bit geometry as well as byte ranges for exact PCC/SystemIO a=
liases,
> >    and count only accessible controls as writers in those registries.
> >    Make status fallback warnings once-only and document the clear-all a=
nd
> >    unsupported-access behavior in the sysfs ABI.
> >
> > Patch 15: Keep Performance Limited clearable on NVIDIA T41 (new)
> >    Add Sumit's quirk for the verified two-bit, offset-zero DWord layout=
.
> >    Use a cached DSDT match and quirk flags, applying the fixup to the p=
rivate
> >    GAS copy before validation and mapping. Distinguish lookup failures =
from
> >    non-matches and leave failures retryable. Keep all quirk plumbing he=
re,
> >    so patch 14 remains independently buildable without unused declarati=
ons.
> >
> > Patch 16: Validate FFH register fields before hardware access (new)
> >    Reject invalid x86 field geometry and GAS addresses that would trunc=
ate
> >    to another 32-bit MSR number. Bound arm64 AMU fields in both single =
and
> >    paired readers. Dispatch FFH before generic Access Size decoding can
> >    shift by an invalid amount using an architecture-specific field.
> >
> > Patch 17: Propagate errors from cross-CPU FFH calls (new)
> >    Return failed SMP-call errors on arm64 and RISC-V before consuming
> >    uninitialized callback output. Also check RISC-V callback errors bef=
ore
> >    copying a read value. Keep this as a separate backportable error-pat=
h fix.
> >
> > Patch 18: Accept requests to retain immutable autonomous selection (new=
)
> >    Treat setting immutable Autonomous Selection Integer 1 to one as a
> >    successful no-op; disabling it still fails. Distinguish immutable-on=
e
> >    descriptors from writable controls currently reading one. Reject an
> >    unsupported amd-pstate transition to passive before changing the mod=
e or
> >    unregistering the working driver, checking known offline CPUs too.
> >    Serialize the immutable query with descriptor publication/removal,
> >    including probe failure, since CPU-hotplug locking does not pin it.
> >    On a later bounds-update failure, restore cppc-cpufreq's previous mo=
de
> >    rather than always disabling selection.
> >
> > Patch 19: Select the frequency-invariance callback per CPU (new)
> >    Register the PCC callback only on CPUs with PCC counters. A shared p=
olicy
> >    can also contain direct-counter CPUs, whose irq_work is not initiali=
zed.
> >    Select from the recorded work-initialization state, so descriptor re=
moval
> >    between initialization and publication cannot change the callback ch=
oice.
> >    Keep callback registration after the complete counter-initialization
> >    pass, so an online CPU's failed initial read publishes no CPPC callb=
acks.
> >
> > Patch 20: Create the FIE worker before enabling PCC callbacks (new)
> >    Create the worker when initializing PCC counters, rather than relyin=
g
> >    on an online-only startup scan. Serialize creation and reuse it unti=
l
> >    driver teardown. Offline members and later PCC policies are covered.
> >    On setup failure, skip FIE for that policy without changing the glob=
al
> >    setting or affecting existing policies. Direct-only systems do not
> >    allocate an unused worker or consume deadline admission bandwidth.
> >
> > Dropped v6 patch 4: Use 64-bit masks for register fields
> >    All supported CPPC configurations are already 64-bit, so this is onl=
y
> >    a cleanup I'll submit later on.
> >
> > Separate lifetime work
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The PCC mailbox teardown fixes are posted separately: [1] is their cove=
r,
> > [2] frees the channel before unmapping its shared memory, and [3] seria=
lizes
> > channel updates with shared-memory teardown. They are not included here=
;
> > this series alone does not close the mailbox IRQ-teardown races.
> >
> > [1] https://lore.kernel.org/all/20260903111328.805352-1-christian.loehl=
e@arm.com/
> > [2] https://lore.kernel.org/all/20260903111328.805352-2-christian.loehl=
e@arm.com/
> > [3] https://lore.kernel.org/all/20260903111328.805352-3-christian.loehl=
e@arm.com/
> >
> > Christian Loehle (19):
> >    ACPI: CPPC: Validate the _CPC package header
> >    ACPI: CPPC: Validate _CPC entry and control semantics
> >    ACPI: CPPC: Propagate performance-control write errors
> >    ACPI: CPPC: Serialize PCC single-register payload updates
> >    ACPI: CPPC: Serialize PCC EPP payload updates
> >    ACPI: CPPC: Release CPC descriptors through kobject
> >    ACPI: CPPC: Release PCC data after probe failures
> >    ACPI: CPPC: Reject unsafe cross-CPU SystemMemory RMW
> >    ACPI: CPPC: Reject direct reads of write-only controls
> >    ACPI: CPPC: Validate and access PCC register layouts
> >    ACPI: CPPC: Validate SystemIO register layouts
> >    ACPI: CPPC: Validate PCC overlaps across processors
> >    ACPI: CPPC: Validate SystemIO overlaps across processors
> >    ACPI: CPPC: Clear Performance Limited without a stale read
> >    ACPI: CPPC: Validate FFH register fields before hardware access
> >    ACPI: CPPC: Propagate errors from cross-CPU FFH calls
> >    ACPI: CPPC: Accept requests to retain immutable autonomous selection
> >    cpufreq: CPPC: Select the frequency-invariance callback per CPU
> >    cpufreq: CPPC: Create the FIE worker before enabling PCC callbacks
> >
> > Sumit Gupta (1):
> >    ACPI: CPPC: Keep Performance Limited clearable on NVIDIA T41
> >
> >   Documentation/ABI/testing/sysfs-devices-system-cpu |   16 +-
> >   arch/arm64/kernel/topology.c                       |   14 +-
> >   arch/x86/kernel/acpi/cppc.c                        |   14 +
> >   drivers/acpi/cppc_acpi.c                           | 2209 +++++++++++=
++++++---
> >   drivers/acpi/riscv/cppc.c                          |   26 +-
> >   drivers/acpi/utils.c                               |   13 +-
> >   drivers/cpufreq/amd-pstate.c                       |   31 +-
> >   drivers/cpufreq/cppc_cpufreq.c                     |   73 +-
> >   include/acpi/cppc_acpi.h                           |   18 +-
> >   9 files changed, 2024 insertions(+), 390 deletions(-)
> >
> > base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
> > --
> > 2.34.1
>
>
> Tested the v7 on v7.3-rc3, with both _CPC rev 3 and 4.
>
> For the entire series:
> Tested-by: Sumit Gupta <sumitg@nvidia.com>
>
>
> Patch 20/20 had a conflict in drivers/cpufreq/cppc_cpufreq.c with
> linux-next 20260916.
>
> The series applied cleanly to the base commit specified in the cover
> letter (fd73f4a66598, tag v7.3-rc3), so patch 20/20 may need to be
> rebased for the current linux-next.

Thank you both!

Series applied as 7.4 material, thanks!
