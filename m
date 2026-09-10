Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838E53ECEF
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060517; cv=none; b=UEtdP4+9fuxFe8brNjyvrhNlB0VGUJXunixI8/4mswwobjkWiYXMu7xqX3LzDL5f8q/8Yh+BiQbMddBIYRh0iG5+gp5EZRuEWKoD3PcrZhPuK7PGh8yqUTS4OJ9D6hd60d1ytAN1MrMANOuOBaRiXDCLN+yhqLX2r9cIhl5XicQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060517; c=relaxed/simple;
	bh=b+wcPJVDHniWrIIhs4dW6jTFcSBmZlFb6YpMZ3jWNAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7X6tOSIQDgl0uModlk0tpRNLsHpQWabsLpZ0rmJcpw7vyYfcCpV98xpUPqREc+56j8SDGO7l5CMd81ZBlXr8MlQgIGASTrhaHHsPaerp3V4rye3uCQr0vLvwKPj5vx6XwMaCyg3orgwyVlvn0XAm8TYOFowvcYD6g8J2vmuSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI9IBGOe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI9IBGOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BA01F008A1
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060496;
	bh=4D0v1faP0HLzJ6MUBUx3J5vRSxmxBKBAtPUFBXzifTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AI9IBGOetvGCdQxLZbyOc0IGyAzaQH6iofPllKV9lZ16dkQOhyZE7VUmUshwX6kuK
	 6nRciRMMqeBug6mdXe45dAyPurrc7wbPhSZYJz6cOsZHcp/7LqLpDSFcUUav23LcIL
	 byK8BKnmiDtiMtHSITnScTqnfwdzg6Ep6qAn/VxsZkrZ4BopqoeYbUP+lakr4fVbx0
	 paOqOGCbaQDhN6wlyfARrlsSu4js6BuLfcn2O592h4e6FUTRmV8rMR+h6ImYsTJkoe
	 3xxuaJdfgS3zNp7s1UBZOc5H6vnkGoKRMEijit2yPDo54JyDJnx/Q2u388vyRx5BOD
	 2lxPBX5s0jNyw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a5a0703ae7so240981fa.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 10:14:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzUDSwCz95L3YvSZItpXsNbXM+hKronjlw6xFfU4BQqi1v/k+eeUrBGbiPfG8wyMmLyThRtVb08IA==@vger.kernel.org
X-Gm-Message-State: AFuF++nicj5pPSHEuWtGWKbfoNG7Kg2p4F1Sdae86wNpDiU5Qti3O7CZ
	0KgVpqSQ414WLUCtLXNHZWTYznYFfP1nAVygPG0r09xmA6N4Oxtb2x/u04uhxHAyCCpJSwSlGNI
	tAkqMjpmI77HOeUc52y0XZgRr7NFC/+0=
X-Received: by 2002:a05:651c:513:b0:3a3:29d8:8b00 with SMTP id
 38308e7fff4ca-3a5910a8b1dmr5948481fa.10.1789060494759; Thu, 10 Sep 2026
 10:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830115644.2056983-1-christian.loehle@arm.com>
 <20260830115644.2056983-3-christian.loehle@arm.com> <e363804d-78d7-4f09-8d49-f70a4dfc6f71@arm.com>
 <CAJZ5v0j=n4uf=GFVDumb2v1sqcS_f293BG2iCD-Vmp2vpLC=xg@mail.gmail.com>
 <CAJZ5v0igEL-WvvCSadRkGDdZaXRJM0kPAH8i918T+FaDg9oZ5A@mail.gmail.com>
 <7985c629-8d36-4562-a789-074d35e9f260@arm.com> <CAJZ5v0jp9q-ZzOKXsOVpvF0ABytHXU9qeSdGyHdhLUL-cLX4sA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jp9q-ZzOKXsOVpvF0ABytHXU9qeSdGyHdhLUL-cLX4sA@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 10 Sep 2026 19:13:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ieZt_FSM4e=F_UjvN_oZbbiU_aHQgfFk2jifqW2Un5rw@mail.gmail.com>
X-Gm-Features: AcwNN1UwmvWaURtLTfRGsNi2UQjSLEFvMpiv6wanCX_9loXfeyZne266g8BR468
Message-ID: <CAJZ5v0ieZt_FSM4e=F_UjvN_oZbbiU_aHQgfFk2jifqW2Un5rw@mail.gmail.com>
Subject: Re: [PATCH v6 02/15] ACPI: CPPC: Validate _CPC entry and control semantics
To: Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	zhongqiu.han@oss.qualcomm.com, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 6:57=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Sep 3, 2026 at 10:02=E2=80=AFPM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 9/3/26 20:44, Rafael J. Wysocki (Intel) wrote:
> > > On Thu, Sep 3, 2026 at 9:27=E2=80=AFPM Rafael J. Wysocki (Intel)
> > > <rafael@kernel.org> wrote:
> > >>
> > >> On Sun, Aug 30, 2026 at 3:32=E2=80=AFPM Christian Loehle
> > >> <christian.loehle@arm.com> wrote:
> > >>>
> > >>> On 8/30/26 12:56, Christian Loehle wrote:
> > >>>> Writable _CPC controls are Register descriptors encoded as Buffer =
objects.
> > >>>> Integer entries represent fixed values or unsupported optional reg=
isters;
> > >>>> Autonomous Selection Integer 1 is the special immutable form which=
 enables
> > >>>> operation without Desired Performance.
> > >>>>
> > >>>> The parser accepts arbitrary object types and cpc_write() assumes =
that its
> > >>>> argument contains a GAS. Malformed firmware can therefore make it =
interpret
> > >>>> an Integer union member as a register.
> > >>>>
> > >>>> Validate the portion of each encoding consumed by the driver: boun=
d Integer
> > >>>> DWORD forms to 32 bits, and require Buffer entries to start with a=
 complete
> > >>>> Generic Register descriptor with the expected header. Continue tol=
erating
> > >>>> Integer 0 for an absent optional register and retain type checks i=
n
> > >>>> cpc_write() as defense in depth. Reject an attempt to disable immu=
table
> > >>>> Autonomous Selection instead of silently applying only the EPP par=
t of the
> > >>>> request.
> > >>>>
> > >>>> Capability registers are read into u64 temporaries but exposed thr=
ough u32
> > >>>> fields. Reject values above U32_MAX instead of allowing them to be
> > >>>> truncated. In particular, a truncated Highest Performance value ca=
n become
> > >>>> a zero divisor in the performance-to-frequency conversion. Enforce=
 the
> > >>>> required ordering from Highest through Nominal, Lowest Nonlinear, =
and
> > >>>> Lowest Performance, and constrain a present Guaranteed Performance=
 to the
> > >>>> inclusive Lowest-to-Nominal range. Also reject reversed frequency =
anchors
> > >>>> and unequal frequency anchors with identical performance anchors. =
Those
> > >>>> invalid tuples otherwise make affine-conversion differences wrap o=
r divide
> > >>>> by zero.
> > >>>>
> > >>>> Check mandatory object presence separately from the Integer-zero c=
onvention
> > >>>> for absent optional fields. ACPI does not reserve zero in the abst=
ract
> > >>>> Lowest Performance scale, so accept a present Lowest Performance D=
WORD of
> > >>>> zero when distinct frequency anchors provide a usable nonzero phys=
ical
> > >>>> minimum. Retain the old rejection when that mapping is unavailable=
 and the
> > >>>> fallback conversion would expose a 0 kHz cpufreq endpoint.
> > >>>>
> > >>>> Minimum Performance also defines zero as a real no-limit value, bu=
t the
> > >>>> exported cppc_set_perf() interface historically used zero to omit =
a bound.
> > >>>> Add explicit validity flags so callers can request zero without ch=
anging
> > >>>> that legacy convention. Populate the flags when reading the contro=
ls and
> > >>>> mark the bounds supplied by amd-pstate explicitly.
> > >>>>
> > >>>> Performance Limited is listed as a required Buffer, but the interf=
ace does
> > >>>> not depend on it to control performance and the specification perm=
its a
> > >>>> platform with no limiting indication to always report zero. Preser=
ve
> > >>>> the compatibility with firmware that represents that case using a =
NULL
> > >>>> register descriptor instead of disabling CPPC entirely.
> > >>>>
> > >>>> Emit an error when a present _CPC package fails parsing or initial=
ization
> > >>>> so such firmware and resource failures no longer silently suppress=
 cpufreq.
> > >>>> Initialize malformed-package failures to -EINVAL and preserve spec=
ific
> > >>>> allocation, mapping, and unsupported-access errors in that diagnos=
tic.
> > >>>>
> > >>>> Fixes: 337aadff8e45 ("ACPI: Introduce CPU performance controls usi=
ng CPPC")
> > >>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
> > >>>> Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-chri=
stian.loehle%40arm.com
> > >>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > >>>> ---
> > >>>>  drivers/acpi/cppc_acpi.c     | 172 ++++++++++++++++++++++++++++++=
-----
> > >>>>  drivers/cpufreq/amd-pstate.c |  12 ++-
> > >>>>  include/acpi/cppc_acpi.h     |   2 +
> > >>>>  3 files changed, 159 insertions(+), 27 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > >>>> index 3b8cdf88e31d..6f3ffa4a1845 100644
> > >>>> --- a/drivers/acpi/cppc_acpi.c
> > >>>> +++ b/drivers/acpi/cppc_acpi.c
> > >>>> @@ -129,6 +129,21 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_=
desc_ptr);
> > >>>>                               !!(cpc)->cpc_entry.int_value :      =
    \
> > >>>>                               !IS_NULL_REG(&(cpc)->cpc_entry.reg))
> > >>>>
> > >>>> +static bool cpc_is_writable(const struct cpc_register_resource *c=
pc)
> > >>>> +{
> > >>>> +     return cpc->type =3D=3D ACPI_TYPE_BUFFER &&
> > >>>> +            !IS_NULL_REG(&cpc->cpc_entry.reg);
> > >>>> +}
> > >>>> +
> > >>>> +static bool cpc_entry_present(const struct cpc_register_resource =
*cpc)
> > >>>> +{
> > >>>> +     if (cpc->type =3D=3D ACPI_TYPE_INTEGER)
> > >>>> +             return true;
> > >>>> +
> > >>>> +     return cpc->type =3D=3D ACPI_TYPE_BUFFER &&
> > >>>> +            !IS_NULL_REG(&cpc->cpc_entry.reg);
> > >>>> +}
> > >>>> +
> > >>>>  /*
> > >>>>   * Each bit indicates the optionality of the register in per-cpu
> > >>>>   * cpc_regs[] with the corresponding index. 0 means mandatory and=
 1
> > >>>> @@ -142,6 +157,29 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_=
desc_ptr);
> > >>>>   */
> > >>>>  #define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_=
idx)))
> > >>>>
> > >>>> +static bool cpc_integer_entry_valid(unsigned int reg_idx, u64 val=
ue)
> > >>>> +{
> > >>>> +     switch (reg_idx) {
> > >>>> +     case HIGHEST_PERF:
> > >>>> +     case NOMINAL_PERF:
> > >>>> +     case LOW_NON_LINEAR_PERF:
> > >>>> +     case LOWEST_PERF:
> > >>>> +     case CTR_WRAP_TIME:
> > >>>> +     case REFERENCE_PERF:
> > >>>> +     case LOWEST_FREQ:
> > >>>> +     case NOMINAL_FREQ:
> > >>>> +             return value <=3D U32_MAX;
> > >>>
> > >>>
> > >>> Sashiko:
> > >>> "Does this incorrectly restrict the counter wraparound time to 32 b=
its?
> > >>> The ACPI specification allows firmware to provide a 64-bit QWord in=
teger
> > >>> for the Counter Wraparound Time. The cppc_perf_fb_ctrs structure al=
ready
> > >>> models this as a 64-bit value internally
> > >>> If firmware provides a valid 64-bit integer exceeding U32_MAX for t=
his
> > >>> register, cpc_integer_entry_valid() will return false and completel=
y abort
> > >>> CPPC initialization for the CPU. Can we remove this restriction for
> > >>> CTR_WRAP_TIME?"
> > >>
> > >>> This is true. ACPI spec 6.6 and 6.5 (Table 8.23) describe it as
> > >>> Integer (DWORD) or Buffer
> > >>> The 64-bit internal representation is only for the case of firmware
> > >>> providing it as Buffer.
> > >
> > > Sashiko is right, the table in the spec is wrong.  If it is Integer,
> > > it is 64-bit.
> > >
> > > The size of an Integer in ASL cannot be restricted.
> >
> > Duh, thanks!
> >
> > >
> > >>>
> > >>>> +     case AUTO_SEL_ENABLE:
> > >>>> +             return value <=3D 1;
> > >>>> +     case DESIRED_PERF:
> > >>>> +             /* Validated against Autonomous Selection after pars=
ing. */
> > >>>> +             return value =3D=3D 0;
> > >>>> +     default:
> > >>>> +             /* Tolerate the customary Integer 0 for an absent op=
tion. */
> > >>>> +             return value =3D=3D 0 && IS_OPTIONAL_CPC_REG(reg_idx=
);
> > >>>> +     }
> > >>>> +}
> > >>>> +
> > >>> Sashiko:
> > >>> "Does this incorrectly restrict the counter wraparound time to 32 b=
its?
> > >>> The ACPI specification allows firmware to provide a 64-bit QWord in=
teger
> > >>> for the Counter Wraparound Time. The cppc_perf_fb_ctrs structure al=
ready
> > >>> models this as a 64-bit value internally.
> > >>> If firmware provides a valid 64-bit integer exceeding U32_MAX for t=
his
> > >>> register, cpc_integer_entry_valid() will return false and completel=
y abort
> > >>> CPPC initialization for the CPU. Can we remove this restriction for
> > >>> CTR_WRAP_TIME?"
> > >>
> > >> It looks like you pasted the same comment twice.  Or did Sashiko hal=
lucinate?
> > >
> > > Well, its other comment is actually different from the first one.  Le=
t
> > > me paste it:
> >
> > Apparently I hallucinated :)
> >
> > >
> > > Will this strict rejection break CPPC initialization on compliant fir=
mware
> > > that provides non-zero integers for other optional capabilities?
> > > For capability registers not explicitly listed in the switch statemen=
t
> > > above, such as GUARANTEED_PERF or TIME_WINDOW, the ACPI 6.5 specifica=
tion
> > > explicitly allows platforms to provide fixed non-zero values encoded =
as
> > > Integer objects.
> > >
> > > When firmware provides a valid non-zero integer for these optional
> > > registers, this default case enforces that the value must be zero. Si=
nce
> > > acpi_cppc_processor_probe() fails and returns -EINVAL when this retur=
ns
> > > false, it will completely disable cpufreq and CPPC support for the CP=
U.
> > > Should we allow non-zero integer values for these other optional regi=
sters?
> > >
> > >>> GUARANTEED_PERF and TIME_WINDOW: both are Buffer-only Register desc=
riptors.
> > >>> Nonzero Integer encodings are invalid and Integer 0 is tolerated be=
cause
> > >>> the previous parser allowed it too. I don't know of any platform de=
scribing
> > >>> this myself.
> > >
> > > Strictly speaking Integer 0 is not allowed, see
> > >
> > > https://uefi.org/specs/ACPI/6.6/08_Processor_Configuration_and_Contro=
l.html#cpc-continuous-performance-control
> >
> > I'm happy to reject it too, I was just being careful here because I onl=
y have
> > a tiny subset of ACPI platforms to test this on with and it's for -fixe=
s
>
> Instead of rejecting it entirely, you may log an FW_BUG message when
> it is used, to avoid breaking legacy platforms that possibly used it.

Still waiting for an update here and reviews from folks.

If this is the only patch that needs to be updated, please just send
an update of it alone.
