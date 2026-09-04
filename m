Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3893E396565
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541133; cv=none; b=kUaNvRh5QoAbKEDkuFDusru3hHaamA56nmeVfZAovVfzUuTcSqhF35kR4/aKgS1rDdQzkSsxuPZv28IPT7PZj6V3Owv4xjjkZ1ETwV44V8odgCt9iwCmBgkb/Y/Q0xecBhznUzGd0BRekH55/h3LwS3ha7/gRttNsjHg/IoTcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541133; c=relaxed/simple;
	bh=IIEiENsAolAsbdFN0vGhtPCO7sbVXNCoR9+9X419amU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4J0KHnySknBUJP7n5OzK6h2MuqENaRyCm6svxscRSEemNzbnZ/aTpkFRsIyRIotHXKfR/M7mxDeT3aou1VhNI+NfYOp8/V4/BgYKAIz9BH+M8lVlzce+RV45yCb9/Riep6jORza2aQBxv2dKmfLv1bSBvZL+uVNXfEy0/8pJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUa3L7x0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUa3L7x0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27EB1F00ACA
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541130;
	bh=yjo7Jz7WHkevnQRFVyBEQ9wg2BDkKMWeNpnWNtrgTE8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nUa3L7x0n17x51kZdNj1UyhNzHb8OLlczp1S5sMxom6U14ah+i6xzuXwsWUbvjKBZ
	 M3bhhy7eWhE7Y8ndXEMCRsq2+ac2eF5jWT5j4F4NHS9Kvpyx+Owcgp57svZ2SrEebt
	 23bKxS4Llduaw8OvQrxpurbKWfuarVWCT5zxBC8GrKxkGWdZOn+d07f4h2NXU4JKvH
	 4QRM+3EqEvPOWwLcWbiPJhUldrLkqcusrzm/z+w1nV8N0zmj46/FLnydOn6AWhxY/H
	 xaLEpy6wSISspfmYHXZ/KvVcI4OZAwZkcBQLSiOb8Pxm9TfQQw6go+KtU05Bn3r+fz
	 aNSOVdqIjuRRw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39c953950dfso13359581fa.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 09:58:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzYsCaIruSgMg4FcFEKIbUA4BAx2w7iKr6B5BJAfv8rHBc+iF/LeG+bT1JTN4f9BB9gCmJysWddfA==@vger.kernel.org
X-Gm-Message-State: AFuF++mmrZBpepLZGm2ItSKjWuiglQeIHG+VsKVVrfHuHUy9eNdNP2Ir
	5MSPw41G/1ks5g1U4TneAk37Ntgt35/uvaT6fvieC6ht2I43LdEtuEw4C9VqnLGPAXJvb7imzA7
	00WRFMVx+b/7XTGBFZkS6ZAJF3NlN9No=
X-Received: by 2002:a2e:bc1e:0:b0:3a3:2e11:96c0 with SMTP id
 38308e7fff4ca-3a371a9f831mr16370981fa.3.1788541129101; Fri, 04 Sep 2026
 09:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830115644.2056983-1-christian.loehle@arm.com>
 <20260830115644.2056983-3-christian.loehle@arm.com> <e363804d-78d7-4f09-8d49-f70a4dfc6f71@arm.com>
 <CAJZ5v0j=n4uf=GFVDumb2v1sqcS_f293BG2iCD-Vmp2vpLC=xg@mail.gmail.com>
 <CAJZ5v0igEL-WvvCSadRkGDdZaXRJM0kPAH8i918T+FaDg9oZ5A@mail.gmail.com> <7985c629-8d36-4562-a789-074d35e9f260@arm.com>
In-Reply-To: <7985c629-8d36-4562-a789-074d35e9f260@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 18:57:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jp9q-ZzOKXsOVpvF0ABytHXU9qeSdGyHdhLUL-cLX4sA@mail.gmail.com>
X-Gm-Features: AcwNN1XpEMZ4AN7L_-NDzCgbDR62URPBeW_PnE05tzKA8N7tW0gyQMxPUdk4OWA
Message-ID: <CAJZ5v0jp9q-ZzOKXsOVpvF0ABytHXU9qeSdGyHdhLUL-cLX4sA@mail.gmail.com>
Subject: Re: [PATCH v6 02/15] ACPI: CPPC: Validate _CPC entry and control semantics
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 10:02=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 9/3/26 20:44, Rafael J. Wysocki (Intel) wrote:
> > On Thu, Sep 3, 2026 at 9:27=E2=80=AFPM Rafael J. Wysocki (Intel)
> > <rafael@kernel.org> wrote:
> >>
> >> On Sun, Aug 30, 2026 at 3:32=E2=80=AFPM Christian Loehle
> >> <christian.loehle@arm.com> wrote:
> >>>
> >>> On 8/30/26 12:56, Christian Loehle wrote:
> >>>> Writable _CPC controls are Register descriptors encoded as Buffer ob=
jects.
> >>>> Integer entries represent fixed values or unsupported optional regis=
ters;
> >>>> Autonomous Selection Integer 1 is the special immutable form which e=
nables
> >>>> operation without Desired Performance.
> >>>>
> >>>> The parser accepts arbitrary object types and cpc_write() assumes th=
at its
> >>>> argument contains a GAS. Malformed firmware can therefore make it in=
terpret
> >>>> an Integer union member as a register.
> >>>>
> >>>> Validate the portion of each encoding consumed by the driver: bound =
Integer
> >>>> DWORD forms to 32 bits, and require Buffer entries to start with a c=
omplete
> >>>> Generic Register descriptor with the expected header. Continue toler=
ating
> >>>> Integer 0 for an absent optional register and retain type checks in
> >>>> cpc_write() as defense in depth. Reject an attempt to disable immuta=
ble
> >>>> Autonomous Selection instead of silently applying only the EPP part =
of the
> >>>> request.
> >>>>
> >>>> Capability registers are read into u64 temporaries but exposed throu=
gh u32
> >>>> fields. Reject values above U32_MAX instead of allowing them to be
> >>>> truncated. In particular, a truncated Highest Performance value can =
become
> >>>> a zero divisor in the performance-to-frequency conversion. Enforce t=
he
> >>>> required ordering from Highest through Nominal, Lowest Nonlinear, an=
d
> >>>> Lowest Performance, and constrain a present Guaranteed Performance t=
o the
> >>>> inclusive Lowest-to-Nominal range. Also reject reversed frequency an=
chors
> >>>> and unequal frequency anchors with identical performance anchors. Th=
ose
> >>>> invalid tuples otherwise make affine-conversion differences wrap or =
divide
> >>>> by zero.
> >>>>
> >>>> Check mandatory object presence separately from the Integer-zero con=
vention
> >>>> for absent optional fields. ACPI does not reserve zero in the abstra=
ct
> >>>> Lowest Performance scale, so accept a present Lowest Performance DWO=
RD of
> >>>> zero when distinct frequency anchors provide a usable nonzero physic=
al
> >>>> minimum. Retain the old rejection when that mapping is unavailable a=
nd the
> >>>> fallback conversion would expose a 0 kHz cpufreq endpoint.
> >>>>
> >>>> Minimum Performance also defines zero as a real no-limit value, but =
the
> >>>> exported cppc_set_perf() interface historically used zero to omit a =
bound.
> >>>> Add explicit validity flags so callers can request zero without chan=
ging
> >>>> that legacy convention. Populate the flags when reading the controls=
 and
> >>>> mark the bounds supplied by amd-pstate explicitly.
> >>>>
> >>>> Performance Limited is listed as a required Buffer, but the interfac=
e does
> >>>> not depend on it to control performance and the specification permit=
s a
> >>>> platform with no limiting indication to always report zero. Preserve
> >>>> the compatibility with firmware that represents that case using a NU=
LL
> >>>> register descriptor instead of disabling CPPC entirely.
> >>>>
> >>>> Emit an error when a present _CPC package fails parsing or initializ=
ation
> >>>> so such firmware and resource failures no longer silently suppress c=
pufreq.
> >>>> Initialize malformed-package failures to -EINVAL and preserve specif=
ic
> >>>> allocation, mapping, and unsupported-access errors in that diagnosti=
c.
> >>>>
> >>>> Fixes: 337aadff8e45 ("ACPI: Introduce CPU performance controls using=
 CPPC")
> >>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >>>> Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christ=
ian.loehle%40arm.com
> >>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >>>> ---
> >>>>  drivers/acpi/cppc_acpi.c     | 172 ++++++++++++++++++++++++++++++--=
---
> >>>>  drivers/cpufreq/amd-pstate.c |  12 ++-
> >>>>  include/acpi/cppc_acpi.h     |   2 +
> >>>>  3 files changed, 159 insertions(+), 27 deletions(-)
> >>>>
> >>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >>>> index 3b8cdf88e31d..6f3ffa4a1845 100644
> >>>> --- a/drivers/acpi/cppc_acpi.c
> >>>> +++ b/drivers/acpi/cppc_acpi.c
> >>>> @@ -129,6 +129,21 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_de=
sc_ptr);
> >>>>                               !!(cpc)->cpc_entry.int_value :        =
  \
> >>>>                               !IS_NULL_REG(&(cpc)->cpc_entry.reg))
> >>>>
> >>>> +static bool cpc_is_writable(const struct cpc_register_resource *cpc=
)
> >>>> +{
> >>>> +     return cpc->type =3D=3D ACPI_TYPE_BUFFER &&
> >>>> +            !IS_NULL_REG(&cpc->cpc_entry.reg);
> >>>> +}
> >>>> +
> >>>> +static bool cpc_entry_present(const struct cpc_register_resource *c=
pc)
> >>>> +{
> >>>> +     if (cpc->type =3D=3D ACPI_TYPE_INTEGER)
> >>>> +             return true;
> >>>> +
> >>>> +     return cpc->type =3D=3D ACPI_TYPE_BUFFER &&
> >>>> +            !IS_NULL_REG(&cpc->cpc_entry.reg);
> >>>> +}
> >>>> +
> >>>>  /*
> >>>>   * Each bit indicates the optionality of the register in per-cpu
> >>>>   * cpc_regs[] with the corresponding index. 0 means mandatory and 1
> >>>> @@ -142,6 +157,29 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_de=
sc_ptr);
> >>>>   */
> >>>>  #define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_id=
x)))
> >>>>
> >>>> +static bool cpc_integer_entry_valid(unsigned int reg_idx, u64 value=
)
> >>>> +{
> >>>> +     switch (reg_idx) {
> >>>> +     case HIGHEST_PERF:
> >>>> +     case NOMINAL_PERF:
> >>>> +     case LOW_NON_LINEAR_PERF:
> >>>> +     case LOWEST_PERF:
> >>>> +     case CTR_WRAP_TIME:
> >>>> +     case REFERENCE_PERF:
> >>>> +     case LOWEST_FREQ:
> >>>> +     case NOMINAL_FREQ:
> >>>> +             return value <=3D U32_MAX;
> >>>
> >>>
> >>> Sashiko:
> >>> "Does this incorrectly restrict the counter wraparound time to 32 bit=
s?
> >>> The ACPI specification allows firmware to provide a 64-bit QWord inte=
ger
> >>> for the Counter Wraparound Time. The cppc_perf_fb_ctrs structure alre=
ady
> >>> models this as a 64-bit value internally
> >>> If firmware provides a valid 64-bit integer exceeding U32_MAX for thi=
s
> >>> register, cpc_integer_entry_valid() will return false and completely =
abort
> >>> CPPC initialization for the CPU. Can we remove this restriction for
> >>> CTR_WRAP_TIME?"
> >>
> >>> This is true. ACPI spec 6.6 and 6.5 (Table 8.23) describe it as
> >>> Integer (DWORD) or Buffer
> >>> The 64-bit internal representation is only for the case of firmware
> >>> providing it as Buffer.
> >
> > Sashiko is right, the table in the spec is wrong.  If it is Integer,
> > it is 64-bit.
> >
> > The size of an Integer in ASL cannot be restricted.
>
> Duh, thanks!
>
> >
> >>>
> >>>> +     case AUTO_SEL_ENABLE:
> >>>> +             return value <=3D 1;
> >>>> +     case DESIRED_PERF:
> >>>> +             /* Validated against Autonomous Selection after parsin=
g. */
> >>>> +             return value =3D=3D 0;
> >>>> +     default:
> >>>> +             /* Tolerate the customary Integer 0 for an absent opti=
on. */
> >>>> +             return value =3D=3D 0 && IS_OPTIONAL_CPC_REG(reg_idx);
> >>>> +     }
> >>>> +}
> >>>> +
> >>> Sashiko:
> >>> "Does this incorrectly restrict the counter wraparound time to 32 bit=
s?
> >>> The ACPI specification allows firmware to provide a 64-bit QWord inte=
ger
> >>> for the Counter Wraparound Time. The cppc_perf_fb_ctrs structure alre=
ady
> >>> models this as a 64-bit value internally.
> >>> If firmware provides a valid 64-bit integer exceeding U32_MAX for thi=
s
> >>> register, cpc_integer_entry_valid() will return false and completely =
abort
> >>> CPPC initialization for the CPU. Can we remove this restriction for
> >>> CTR_WRAP_TIME?"
> >>
> >> It looks like you pasted the same comment twice.  Or did Sashiko hallu=
cinate?
> >
> > Well, its other comment is actually different from the first one.  Let
> > me paste it:
>
> Apparently I hallucinated :)
>
> >
> > Will this strict rejection break CPPC initialization on compliant firmw=
are
> > that provides non-zero integers for other optional capabilities?
> > For capability registers not explicitly listed in the switch statement
> > above, such as GUARANTEED_PERF or TIME_WINDOW, the ACPI 6.5 specificati=
on
> > explicitly allows platforms to provide fixed non-zero values encoded as
> > Integer objects.
> >
> > When firmware provides a valid non-zero integer for these optional
> > registers, this default case enforces that the value must be zero. Sinc=
e
> > acpi_cppc_processor_probe() fails and returns -EINVAL when this returns
> > false, it will completely disable cpufreq and CPPC support for the CPU.
> > Should we allow non-zero integer values for these other optional regist=
ers?
> >
> >>> GUARANTEED_PERF and TIME_WINDOW: both are Buffer-only Register descri=
ptors.
> >>> Nonzero Integer encodings are invalid and Integer 0 is tolerated beca=
use
> >>> the previous parser allowed it too. I don't know of any platform desc=
ribing
> >>> this myself.
> >
> > Strictly speaking Integer 0 is not allowed, see
> >
> > https://uefi.org/specs/ACPI/6.6/08_Processor_Configuration_and_Control.=
html#cpc-continuous-performance-control
>
> I'm happy to reject it too, I was just being careful here because I only =
have
> a tiny subset of ACPI platforms to test this on with and it's for -fixes

Instead of rejecting it entirely, you may log an FW_BUG message when
it is used, to avoid breaking legacy platforms that possibly used it.
