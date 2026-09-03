Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A207A4A2A70
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463738; cv=none; b=O50b+GEGN2hV1PJrg3WVYQf8Pf6EzH45y1F1RZGLD4haZoBjbZ3JM/3epOokYqkNqxmnTI+qjJ2DlcuYBrvAMmR7No6zqf43nfIgHX3xffv436xI2kiYmnq8axkFgooe6eDx5FGZ4O3kOJ3J2mozfpkeQ6ClE79kFcoSeBgs3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463738; c=relaxed/simple;
	bh=hEOE0ycrR7hHwPNFmq60DZ861ycmN3zkIht0c1SYwBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joTmuNOODz6BKao68Z6wpST2SIYvve3Lbphy6YdJ8Cw0P2I0olMdaLTsfmX+Chg3jJ95ObAANwUHGEBK3H79sU3oRdjdYd6AWR4Bfe02tFlwD2xbKKCX5iHiIRv2cfZ0TDcOIJ1Hk9rYCGxb/jZ7igsaYBQ3lDuq0EVrc9OVVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSBrPpz9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSBrPpz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6160B1F0155C
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 19:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788463725;
	bh=6HMXD0SViuBG1T2qWvq6Di5raTSK7+rhtmup3GCHTyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aSBrPpz94oKdz5y5yAMXYVMC+e3OboSahpUJj8S8eAyPyDNNxRrUsL4+MZuSohOii
	 1GgJWi/7mGL+5MbcXWrRpEiAffokOq2/hlSK8ReuhCv8f0wJ21PUj+i6bm8U4NjgY+
	 wcRM2S+hqpEw2qnxN+SHOMX+/atmyWsSV0SidfMGXbZxWboLt7/3U8qlBrcbcgheug
	 +QgaanE7KjAcGEEt3QsVTDNeouQFg1VntxJCj0BSe9CdH9rQvpA4weO6ldQDPjekC8
	 HH0O6yaOP7HedgjXtWg2hXiIGIskAmohOE/FxRVBbwHCVD2Ak3YfFoWNV+JcKiOVj+
	 KOpIAz4pD9KRA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39faa67fab8so2539231fa.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 12:28:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw0syc6Zs/9KhdfvxyV+jgWVbWBPCVm7CLowXWloc3oR48WBHBI9vcA8wDcyxbjDwe7PhKJnIgVQg==@vger.kernel.org
X-Gm-Message-State: AFuF++nnFcHEpPKibieuo/0CiqW7LLkvLPA2DaidLcI7Idid0eU+cv2Z
	1BSMC7CIthp/hwyROh/Uj7a0H8JAbf5KizO/bJOXuHTrmzkZ0gLcvLn2hNxyEpjWci1ZPZAsgsh
	wXIkPUaNy2JBBaxE+cDU45E7bb2BO2To=
X-Received: by 2002:a05:651c:1986:b0:39f:a2be:bc4a with SMTP id
 38308e7fff4ca-3a371ad6cc3mr1670321fa.4.1788463723352; Thu, 03 Sep 2026
 12:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830115644.2056983-1-christian.loehle@arm.com>
 <20260830115644.2056983-3-christian.loehle@arm.com> <e363804d-78d7-4f09-8d49-f70a4dfc6f71@arm.com>
In-Reply-To: <e363804d-78d7-4f09-8d49-f70a4dfc6f71@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 3 Sep 2026 21:27:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j=n4uf=GFVDumb2v1sqcS_f293BG2iCD-Vmp2vpLC=xg@mail.gmail.com>
X-Gm-Features: AcwNN1U6I1OsjpvMa2zXdGmf_9DIMGmVx2oTf8p1dyr-QK1JIya4aOTVEcA0elI
Message-ID: <CAJZ5v0j=n4uf=GFVDumb2v1sqcS_f293BG2iCD-Vmp2vpLC=xg@mail.gmail.com>
Subject: Re: [PATCH v6 02/15] ACPI: CPPC: Validate _CPC entry and control semantics
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 3:32=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 8/30/26 12:56, Christian Loehle wrote:
> > Writable _CPC controls are Register descriptors encoded as Buffer objec=
ts.
> > Integer entries represent fixed values or unsupported optional register=
s;
> > Autonomous Selection Integer 1 is the special immutable form which enab=
les
> > operation without Desired Performance.
> >
> > The parser accepts arbitrary object types and cpc_write() assumes that =
its
> > argument contains a GAS. Malformed firmware can therefore make it inter=
pret
> > an Integer union member as a register.
> >
> > Validate the portion of each encoding consumed by the driver: bound Int=
eger
> > DWORD forms to 32 bits, and require Buffer entries to start with a comp=
lete
> > Generic Register descriptor with the expected header. Continue tolerati=
ng
> > Integer 0 for an absent optional register and retain type checks in
> > cpc_write() as defense in depth. Reject an attempt to disable immutable
> > Autonomous Selection instead of silently applying only the EPP part of =
the
> > request.
> >
> > Capability registers are read into u64 temporaries but exposed through =
u32
> > fields. Reject values above U32_MAX instead of allowing them to be
> > truncated. In particular, a truncated Highest Performance value can bec=
ome
> > a zero divisor in the performance-to-frequency conversion. Enforce the
> > required ordering from Highest through Nominal, Lowest Nonlinear, and
> > Lowest Performance, and constrain a present Guaranteed Performance to t=
he
> > inclusive Lowest-to-Nominal range. Also reject reversed frequency ancho=
rs
> > and unequal frequency anchors with identical performance anchors. Those
> > invalid tuples otherwise make affine-conversion differences wrap or div=
ide
> > by zero.
> >
> > Check mandatory object presence separately from the Integer-zero conven=
tion
> > for absent optional fields. ACPI does not reserve zero in the abstract
> > Lowest Performance scale, so accept a present Lowest Performance DWORD =
of
> > zero when distinct frequency anchors provide a usable nonzero physical
> > minimum. Retain the old rejection when that mapping is unavailable and =
the
> > fallback conversion would expose a 0 kHz cpufreq endpoint.
> >
> > Minimum Performance also defines zero as a real no-limit value, but the
> > exported cppc_set_perf() interface historically used zero to omit a bou=
nd.
> > Add explicit validity flags so callers can request zero without changin=
g
> > that legacy convention. Populate the flags when reading the controls an=
d
> > mark the bounds supplied by amd-pstate explicitly.
> >
> > Performance Limited is listed as a required Buffer, but the interface d=
oes
> > not depend on it to control performance and the specification permits a
> > platform with no limiting indication to always report zero. Preserve
> > the compatibility with firmware that represents that case using a NULL
> > register descriptor instead of disabling CPPC entirely.
> >
> > Emit an error when a present _CPC package fails parsing or initializati=
on
> > so such firmware and resource failures no longer silently suppress cpuf=
req.
> > Initialize malformed-package failures to -EINVAL and preserve specific
> > allocation, mapping, and unsupported-access errors in that diagnostic.
> >
> > Fixes: 337aadff8e45 ("ACPI: Introduce CPU performance controls using CP=
PC")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian=
.loehle%40arm.com
> > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > ---
> >  drivers/acpi/cppc_acpi.c     | 172 ++++++++++++++++++++++++++++++-----
> >  drivers/cpufreq/amd-pstate.c |  12 ++-
> >  include/acpi/cppc_acpi.h     |   2 +
> >  3 files changed, 159 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 3b8cdf88e31d..6f3ffa4a1845 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -129,6 +129,21 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_=
ptr);
> >                               !!(cpc)->cpc_entry.int_value :          \
> >                               !IS_NULL_REG(&(cpc)->cpc_entry.reg))
> >
> > +static bool cpc_is_writable(const struct cpc_register_resource *cpc)
> > +{
> > +     return cpc->type =3D=3D ACPI_TYPE_BUFFER &&
> > +            !IS_NULL_REG(&cpc->cpc_entry.reg);
> > +}
> > +
> > +static bool cpc_entry_present(const struct cpc_register_resource *cpc)
> > +{
> > +     if (cpc->type =3D=3D ACPI_TYPE_INTEGER)
> > +             return true;
> > +
> > +     return cpc->type =3D=3D ACPI_TYPE_BUFFER &&
> > +            !IS_NULL_REG(&cpc->cpc_entry.reg);
> > +}
> > +
> >  /*
> >   * Each bit indicates the optionality of the register in per-cpu
> >   * cpc_regs[] with the corresponding index. 0 means mandatory and 1
> > @@ -142,6 +157,29 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_=
ptr);
> >   */
> >  #define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_idx))=
)
> >
> > +static bool cpc_integer_entry_valid(unsigned int reg_idx, u64 value)
> > +{
> > +     switch (reg_idx) {
> > +     case HIGHEST_PERF:
> > +     case NOMINAL_PERF:
> > +     case LOW_NON_LINEAR_PERF:
> > +     case LOWEST_PERF:
> > +     case CTR_WRAP_TIME:
> > +     case REFERENCE_PERF:
> > +     case LOWEST_FREQ:
> > +     case NOMINAL_FREQ:
> > +             return value <=3D U32_MAX;
>
>
> Sashiko:
> "Does this incorrectly restrict the counter wraparound time to 32 bits?
> The ACPI specification allows firmware to provide a 64-bit QWord integer
> for the Counter Wraparound Time. The cppc_perf_fb_ctrs structure already
> models this as a 64-bit value internally
> If firmware provides a valid 64-bit integer exceeding U32_MAX for this
> register, cpc_integer_entry_valid() will return false and completely abor=
t
> CPPC initialization for the CPU. Can we remove this restriction for
> CTR_WRAP_TIME?"
> This is true. ACPI spec 6.6 and 6.5 (Table 8.23) describe it as
> Integer (DWORD) or Buffer
> The 64-bit internal representation is only for the case of firmware
> providing it as Buffer.
>
> > +     case AUTO_SEL_ENABLE:
> > +             return value <=3D 1;
> > +     case DESIRED_PERF:
> > +             /* Validated against Autonomous Selection after parsing. =
*/
> > +             return value =3D=3D 0;
> > +     default:
> > +             /* Tolerate the customary Integer 0 for an absent option.=
 */
> > +             return value =3D=3D 0 && IS_OPTIONAL_CPC_REG(reg_idx);
> > +     }
> > +}
> > +
> Sashiko:
> "Does this incorrectly restrict the counter wraparound time to 32 bits?
> The ACPI specification allows firmware to provide a 64-bit QWord integer
> for the Counter Wraparound Time. The cppc_perf_fb_ctrs structure already
> models this as a 64-bit value internally.
> If firmware provides a valid 64-bit integer exceeding U32_MAX for this
> register, cpc_integer_entry_valid() will return false and completely abor=
t
> CPPC initialization for the CPU. Can we remove this restriction for
> CTR_WRAP_TIME?"

It looks like you pasted the same comment twice.  Or did Sashiko hallucinat=
e?

> GUARANTEED_PERF and TIME_WINDOW: both are Buffer-only Register descriptor=
s.
> Nonzero Integer encodings are invalid and Integer 0 is tolerated because
> the previous parser allowed it too. I don't know of any platform describi=
ng
> this myself.
>
> >  /*
> >   * Arbitrary Retries in case the remote processor is slow to respond
> >   * to PCC commands. Keeping it high enough to cover emulators where
> > @@ -150,6 +188,8 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_p=
tr);
> >  #define NUM_RETRIES 500ULL
> >
> >  #define OVER_16BTS_MASK ~0xFFFFULL
> > +#define CPC_GENERIC_REGISTER_DESCRIPTOR 0x82
> > +#define CPC_GENERIC_REGISTER_LENGTH (sizeof(struct cpc_reg) - 3)
> >
> >  #define define_one_cppc_ro(_name)            \
> >  static struct kobj_attribute _name =3D         \
> > @@ -773,8 +813,10 @@ int acpi_cppc_processor_probe(struct acpi_processo=
r *pr)
> >       acpi_handle handle =3D pr->handle;
> >       unsigned int num_ent, i, cpc_rev;
> >       int pcc_subspace_id =3D -1;
> > +     bool cpc_present =3D false;
> >       acpi_status status;
> >       int ret =3D -ENODATA;
> > +     int err;
> >
> >       if (!osc_sb_cppc2_support_acked) {
> >               pr_debug("CPPC v2 _OSC not acked\n");
> > @@ -791,6 +833,8 @@ int acpi_cppc_processor_probe(struct acpi_processor=
 *pr)
> >               ret =3D -ENODEV;
> >               goto out_buf_free;
> >       }
> > +     cpc_present =3D true;
> > +     ret =3D -EINVAL;
> >
> >       out_obj =3D (union acpi_object *) output.pointer;
> >       if (out_obj->package.count < 2) {
> > @@ -871,11 +915,32 @@ int acpi_cppc_processor_probe(struct acpi_process=
or *pr)
> >               cpc_obj =3D &out_obj->package.elements[i];
> >
> >               if (cpc_obj->type =3D=3D ACPI_TYPE_INTEGER) {
> > -                     cpc_ptr->cpc_regs[i-2].type =3D ACPI_TYPE_INTEGER=
;
> > -                     cpc_ptr->cpc_regs[i-2].cpc_entry.int_value =3D cp=
c_obj->integer.value;
> > +                     if (!cpc_integer_entry_valid(i - 2,
> > +                                                  cpc_obj->integer.val=
ue)) {
> > +                             pr_debug("Invalid Integer _CPC register %=
u for CPU:%d\n",
> > +                                      i - 2, pr->id);
> > +                             ret =3D -EINVAL;
> > +                             goto out_free;
> > +                     }
> > +                     cpc_ptr->cpc_regs[i - 2].type =3D ACPI_TYPE_INTEG=
ER;
> > +                     cpc_ptr->cpc_regs[i - 2].cpc_entry.int_value =3D =
cpc_obj->integer.value;
> >               } else if (cpc_obj->type =3D=3D ACPI_TYPE_BUFFER) {
> > +                     if (cpc_obj->buffer.length < sizeof(*gas_t)) {
> > +                             pr_debug("Invalid register descriptor for=
 CPU:%d\n",
> > +                                      pr->id);
> > +                             ret =3D -EINVAL;
> > +                             goto out_free;
> > +                     }
> > +
> >                       gas_t =3D (struct cpc_reg *)
> >                               cpc_obj->buffer.pointer;
> > +                     if (gas_t->descriptor !=3D CPC_GENERIC_REGISTER_D=
ESCRIPTOR ||
> > +                         gas_t->length !=3D CPC_GENERIC_REGISTER_LENGT=
H) {
> > +                             pr_debug("Invalid register resource for C=
PU:%d\n",
> > +                                      pr->id);
> > +                             ret =3D -EINVAL;
> > +                             goto out_free;
> > +                     }
> >
> >                       /*
> >                        * The PCC Subspace index is encoded inside
> > @@ -886,8 +951,11 @@ int acpi_cppc_processor_probe(struct acpi_processo=
r *pr)
> >                       if (gas_t->space_id =3D=3D ACPI_ADR_SPACE_PLATFOR=
M_COMM) {
> >                               if (pcc_subspace_id < 0) {
> >                                       pcc_subspace_id =3D gas_t->access=
_width;
> > -                                     if (pcc_data_alloc(pcc_subspace_i=
d))
> > +                                     err =3D pcc_data_alloc(pcc_subspa=
ce_id);
> > +                                     if (err) {
> > +                                             ret =3D err;
> >                                               goto out_free;
> > +                                     }
> >                               } else if (pcc_subspace_id !=3D gas_t->ac=
cess_width) {
> >                                       pr_debug("Mismatched PCC ids in _=
CPC for CPU:%d\n",
> >                                                pr->id);
> > @@ -900,14 +968,18 @@ int acpi_cppc_processor_probe(struct acpi_process=
or *pr)
> >
> >                                       if (!osc_cpc_flexible_adr_space_c=
onfirmed) {
> >                                               pr_debug("Flexible addres=
s space capability not supported\n");
> > +                                             ret =3D -EOPNOTSUPP;
> >                                               if (!cpc_supported_by_cpu=
())
> >                                                       goto out_free;
> > +                                             ret =3D -EINVAL;
> >                                       }
> >
> >                                       access_width =3D GET_BIT_WIDTH(ga=
s_t) / 8;
> >                                       addr =3D ioremap(gas_t->address, =
access_width);
> > -                                     if (!addr)
> > +                                     if (!addr) {
> > +                                             ret =3D -ENOMEM;
> >                                               goto out_free;
> > +                                     }
> >                                       cpc_ptr->cpc_regs[i-2].sys_mem_va=
ddr =3D addr;
> >                               }
> >                       } else if (gas_t->space_id =3D=3D ACPI_ADR_SPACE_=
SYSTEM_IO) {
> > @@ -929,14 +1001,17 @@ int acpi_cppc_processor_probe(struct acpi_proces=
sor *pr)
> >                               }
> >                               if (!osc_cpc_flexible_adr_space_confirmed=
) {
> >                                       pr_debug("Flexible address space =
capability not supported\n");
> > +                                     ret =3D -EOPNOTSUPP;
> >                                       if (!cpc_supported_by_cpu())
> >                                               goto out_free;
> > +                                     ret =3D -EINVAL;
> >                               }
> >                       } else {
> >                               if (gas_t->space_id !=3D ACPI_ADR_SPACE_F=
IXED_HARDWARE || !cpc_ffh_supported()) {
> >                                       /* Support only PCC, SystemMemory=
, SystemIO, and FFH type regs. */
> >                                       pr_debug("Unsupported register ty=
pe (%d) in _CPC\n",
> >                                                gas_t->space_id);
> > +                                     ret =3D -EOPNOTSUPP;
> >                                       goto out_free;
> >                               }
> >                       }
> > @@ -961,15 +1036,35 @@ int acpi_cppc_processor_probe(struct acpi_proces=
sor *pr)
> >       }
> >       per_cpu(cpu_pcc_subspace_idx, pr->id) =3D pcc_subspace_id;
> >
> > +     /*
> > +      * Performance Limited is required by the specification, but tole=
rate a
> > +      * NULL descriptor used by firmware which cannot report limiting =
events.
> > +      * CPPC control does not depend on this status.
> > +      */
> > +     for (i =3D 0; i < num_ent - 2; i++) {
> > +             if (i !=3D DESIRED_PERF && i !=3D PERF_LIMITED &&
> > +                 !IS_OPTIONAL_CPC_REG(i) &&
> > +                 !cpc_entry_present(&cpc_ptr->cpc_regs[i])) {
> > +                     pr_debug("CPU:%d lacks mandatory _CPC register %u=
\n",
> > +                              pr->id, i);
> > +                     ret =3D -EINVAL;
> > +                     goto out_free;
> > +             }
> > +     }
> > +
> >       /*
> >        * In CPPC v1, DESIRED_PERF is mandatory. In CPPC v2, it is optio=
nal
> >        * only when AUTO_SEL_ENABLE is supported.
> >        */
> > -     if (!CPC_SUPPORTED(&cpc_ptr->cpc_regs[DESIRED_PERF]) &&
> > +     if (!cpc_is_writable(&cpc_ptr->cpc_regs[DESIRED_PERF]) &&
> >           (!osc_sb_cppc2_support_acked ||
> > -          !CPC_SUPPORTED(&cpc_ptr->cpc_regs[AUTO_SEL_ENABLE])))
> > -             pr_warn("Desired perf. register is mandatory if CPPC v2 i=
s not supported "
> > -                     "or autonomous selection is disabled\n");
> > +          cpc_ptr->cpc_regs[AUTO_SEL_ENABLE].type !=3D ACPI_TYPE_INTEG=
ER ||
> > +          cpc_ptr->cpc_regs[AUTO_SEL_ENABLE].cpc_entry.int_value !=3D =
1)) {
> > +             pr_debug("CPU:%d lacks a writable Desired Performance reg=
ister\n",
> > +                      pr->id);
> > +             ret =3D -EINVAL;
> > +             goto out_free;
> > +     }
> >
> >       /*
> >        * Initialize the remaining cpc_regs as unsupported.
> > @@ -1037,6 +1132,8 @@ int acpi_cppc_processor_probe(struct acpi_process=
or *pr)
> >       kfree(cpc_ptr);
> >
> >  out_buf_free:
> > +     if (cpc_present)
> > +             pr_err("CPU%d: failed to initialize _CPC: %d\n", pr->id, =
ret);
> >       kfree(output.pointer);
> >       return ret;
> >  }
> > @@ -1217,11 +1314,18 @@ static int cpc_write(int cpu, struct cpc_regist=
er_resource *reg_res, u64 val)
> >       u64 prev_val;
> >       void __iomem *vaddr =3D NULL;
> >       int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
> > -     struct cpc_reg *reg =3D &reg_res->cpc_entry.reg;
> > +     struct cpc_reg *reg;
> >       struct cpc_desc *cpc_desc;
> >       unsigned long flags;
> >       bool locked =3D false;
> >
> > +     if (reg_res->type !=3D ACPI_TYPE_BUFFER)
> > +             return -EOPNOTSUPP;
> > +
> > +     reg =3D &reg_res->cpc_entry.reg;
> > +     if (IS_NULL_REG(reg))
> > +             return -EOPNOTSUPP;
> > +
> >       size =3D GET_BIT_WIDTH(reg);
> >
> >       if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
> > @@ -1364,7 +1468,9 @@ static int cppc_get_reg_val(int cpu, enum cppc_re=
gs reg_idx, u64 *val)
> >
> >       reg =3D &cpc_desc->cpc_regs[reg_idx];
> >
> > -     if ((reg->type =3D=3D ACPI_TYPE_INTEGER && IS_OPTIONAL_CPC_REG(re=
g_idx) &&
> > +     /* Desired may be absent for immutable autonomous selection. */
> > +     if ((reg->type =3D=3D ACPI_TYPE_INTEGER &&
> > +          (IS_OPTIONAL_CPC_REG(reg_idx) || reg_idx =3D=3D DESIRED_PERF=
) &&
> >            !reg->cpc_entry.int_value) || (reg->type !=3D ACPI_TYPE_INTE=
GER &&
> >            IS_NULL_REG(&reg->cpc_entry.reg))) {
> >               pr_debug("CPC register is not supported\n");
> > @@ -1415,7 +1521,7 @@ static int cppc_set_reg_val(int cpu, enum cppc_re=
gs reg_idx, u64 val)
> >       reg =3D &cpc_desc->cpc_regs[reg_idx];
> >
> >       /* if a register is writeable, it must be a buffer and not null *=
/
> > -     if ((reg->type !=3D ACPI_TYPE_BUFFER) || IS_NULL_REG(&reg->cpc_en=
try.reg)) {
> > +     if (!cpc_is_writable(reg)) {
> >               pr_debug("CPC register is not supported\n");
> >               return -EOPNOTSUPP;
> >       }
> > @@ -1505,7 +1611,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_pe=
rf_caps *perf_caps)
> >       struct cpc_register_resource *highest_reg, *lowest_reg,
> >               *lowest_non_linear_reg, *nominal_reg, *reference_reg,
> >               *guaranteed_reg, *low_freq_reg =3D NULL, *nom_freq_reg =
=3D NULL;
> > -     u64 high, low, guaranteed, nom, ref, min_nonlinear,
> > +     u64 high, low, guaranteed =3D 0, nom, ref, min_nonlinear,
> >           low_f =3D 0, nom_f =3D 0;
> >       int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> >       struct cppc_pcc_data *pcc_ss_data =3D NULL;
> > @@ -1588,7 +1694,12 @@ int cppc_get_perf_caps(int cpunum, struct cppc_p=
erf_caps *perf_caps)
> >               goto out_err;
> >       perf_caps->lowest_nonlinear_perf =3D min_nonlinear;
> >
> > -     if (!high || !low || !nom || !ref || !min_nonlinear) {
> > +     if (!high || !nom || !ref || !min_nonlinear ||
> > +         high > U32_MAX || low > U32_MAX || guaranteed > U32_MAX ||
> > +         nom > U32_MAX || ref > U32_MAX || min_nonlinear > U32_MAX ||
> > +         high < nom || nom < min_nonlinear || min_nonlinear < low ||
> > +         (CPC_SUPPORTED(guaranteed_reg) &&
> > +          (guaranteed < low || guaranteed > nom))) {
> >               ret =3D -EFAULT;
> >               goto out_err;
> >       }
> > @@ -1605,6 +1716,19 @@ int cppc_get_perf_caps(int cpunum, struct cppc_p=
erf_caps *perf_caps)
> >               if (ret)
> >                       goto out_err;
> >       }
> > +     /*
> > +      * Require ordered anchors and a nonzero slope when frequencies d=
iffer.
> > +      * A zero Lowest Performance needs that affine mapping to produce=
 a
> > +      * nonzero physical minimum frequency.
> > +      */
> > +     if (low_f > U32_MAX || nom_f > U32_MAX ||
> > +         (!low && (!low_f || !nom_f || low_f =3D=3D nom_f)) ||
> > +         (low_f && nom_f &&
> > +          (nom_f < low_f || nom < low ||
> > +           (nom_f !=3D low_f && nom =3D=3D low)))) {
> > +             ret =3D -EFAULT;
> > +             goto out_err;
> > +     }
> >
> >       perf_caps->lowest_freq =3D low_f;
> >       perf_caps->nominal_freq =3D nom_f;
> > @@ -1779,6 +1903,9 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_c=
trls *perf_ctrls, bool enable)
> >
> >       auto_sel_reg =3D &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> >       epp_set_reg =3D &cpc_desc->cpc_regs[ENERGY_PERF];
> > +     if (!enable && auto_sel_reg->type =3D=3D ACPI_TYPE_INTEGER &&
> > +         auto_sel_reg->cpc_entry.int_value =3D=3D 1)
> > +             return -EOPNOTSUPP;
> >
> >       epp_ffh_sysmem =3D CPC_SUPPORTED(epp_set_reg) &&
> >               (CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_=
reg));
> > @@ -1791,13 +1918,13 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf=
_ctrls *perf_ctrls, bool enable)
> >                       return -ENODEV;
> >               }
> >
> > -             if (CPC_SUPPORTED(auto_sel_reg)) {
> > +             if (cpc_is_writable(auto_sel_reg)) {
> >                       ret =3D cpc_write(cpu, auto_sel_reg, enable);
> >                       if (ret)
> >                               return ret;
> >               }
> >
> > -             if (CPC_SUPPORTED(epp_set_reg)) {
> > +             if (cpc_is_writable(epp_set_reg)) {
> >                       ret =3D cpc_write(cpu, epp_set_reg, perf_ctrls->e=
nergy_perf);
> >                       if (ret)
> >                               return ret;
> > @@ -1996,6 +2123,8 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls=
 *perf_ctrls)
> >       max_perf_reg =3D &cpc_desc->cpc_regs[MAX_PERF];
> >       energy_perf_reg =3D &cpc_desc->cpc_regs[ENERGY_PERF];
> >       auto_sel_reg =3D &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> > +     perf_ctrls->max_perf_valid =3D false;
> > +     perf_ctrls->min_perf_valid =3D false;
> >
> >       /* Are any of the regs PCC ?*/
> >       if (CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg) ||
> > @@ -2020,6 +2149,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls=
 *perf_ctrls)
> >               ret =3D cpc_read(cpu, max_perf_reg, &max);
> >               if (ret)
> >                       goto out_err;
> > +             perf_ctrls->max_perf_valid =3D true;
> >       }
> >       perf_ctrls->max_perf =3D max;
> >
> > @@ -2027,6 +2157,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls=
 *perf_ctrls)
> >               ret =3D cpc_read(cpu, min_perf_reg, &min);
> >               if (ret)
> >                       goto out_err;
> > +             perf_ctrls->min_perf_valid =3D true;
> >       }
> >       perf_ctrls->min_perf =3D min;
> >
> > @@ -2113,14 +2244,11 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctr=
ls *perf_ctrls)
> >       if (CPC_SUPPORTED(desired_reg))
> >               cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
> >
> > -     /*
> > -      * Only write if min_perf and max_perf not zero. Some drivers pas=
s zero
> > -      * value to min and max perf, but they don't mean to set the zero=
 value,
> > -      * they just don't want to write to those registers.
> > -      */
> > -     if (perf_ctrls->min_perf && CPC_SUPPORTED(min_perf_reg))
> > +     if (CPC_SUPPORTED(min_perf_reg) &&
> > +         (perf_ctrls->min_perf || perf_ctrls->min_perf_valid))
> >               cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
> > -     if (perf_ctrls->max_perf && CPC_SUPPORTED(max_perf_reg))
> > +     if (CPC_SUPPORTED(max_perf_reg) &&
> > +         (perf_ctrls->max_perf || perf_ctrls->max_perf_valid))
> >               cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
> >
> >       if (regs_in_pcc)
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.=
c
> > index d4ff8b228f86..63f0ca5f19b3 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -544,7 +544,13 @@ static int shmem_update_perf(struct cpufreq_policy=
 *policy, u8 min_perf,
> >                            u8 des_perf, u8 max_perf, u8 epp, bool fast_=
switch)
> >  {
> >       struct amd_cpudata *cpudata =3D policy->driver_data;
> > -     struct cppc_perf_ctrls perf_ctrls;
> > +     struct cppc_perf_ctrls perf_ctrls =3D {
> > +             .max_perf =3D max_perf,
> > +             .min_perf =3D min_perf,
> > +             .desired_perf =3D des_perf,
> > +             .max_perf_valid =3D true,
> > +             .min_perf_valid =3D true,
> > +     };
> >       u64 value, prev;
> >       int ret;
> >
> > @@ -577,10 +583,6 @@ static int shmem_update_perf(struct cpufreq_policy=
 *policy, u8 min_perf,
> >       if (value =3D=3D prev)
> >               return 0;
> >
> > -     perf_ctrls.max_perf =3D max_perf;
> > -     perf_ctrls.min_perf =3D min_perf;
> > -     perf_ctrls.desired_perf =3D des_perf;
> > -
> >       ret =3D cppc_set_perf(cpudata->cpu, &perf_ctrls);
> >       if (ret)
> >               return ret;
> > diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> > index 94a6277edab2..5dcbe65c5ddc 100644
> > --- a/include/acpi/cppc_acpi.h
> > +++ b/include/acpi/cppc_acpi.h
> > @@ -141,6 +141,8 @@ struct cppc_perf_ctrls {
> >       u32 desired_perf;
> >       u32 energy_perf;
> >       bool auto_sel;
> > +     bool max_perf_valid;
> > +     bool min_perf_valid;
> >  };
> >
> >  struct cppc_perf_fb_ctrs {
>
