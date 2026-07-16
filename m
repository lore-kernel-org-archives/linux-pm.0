Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D140EB8A
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198192; cv=none; b=R8k+h8pp6T9CdHmfu905G3wRhHEtCnGE6so0nYvtSW0O9rnq2AYuuf7/f5gP7KEx3fbGVmp51TrdK3ynz0dpq1My7IBKqM11j+v+U8VEkZWfxrZ6wdywmwo39tKKOKbh5JbWS0yWiNzpbNTEtmeGYEYTzFHXB3Qwx6v2Y0/WX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198192; c=relaxed/simple;
	bh=otX9kLFMkgBAnYGokQjdErq++gTim2Xw9qvwVUXiTag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1su/c/b9VUCBDfLNKYekN1GU8Qs/aqNE8k9SCrL1Hjfcxyec7bpwQsYBGnZ1w9rhJizIfCYukeIAdzCceJxPIcBNQg3SLPTszph6BNUEdgIpeKgr8s7EHmQbGkjh0gsDPDwBIeB+qitxaT3SbJh5FcQQOhLqz+R6kPhkXv7CBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMhhtyup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMhhtyup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49901F00A3A
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 10:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784198190;
	bh=XzyEq+E4YfoCLZE+c0oAFnYnbEuyVsQCzsaD0RX0hyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kMhhtyupS8D20Uh9KhmKYEntUWOcX791UZLsfQdkcp8eELvsjN32O9vv40I/3j8+W
	 xHk/JUahagO6Ws/CRDgeFIbMrZ4a5755DITQd5ZvJvEjLqw2B4HHCDKUrRQeeSDLBX
	 wXzkCwNAoBNqf+nY8GUvPoJ/isdsxCMzB6siXqyTk3/hClx1vbt0QdFh0FEeUbCuQ+
	 b2oEJj/Y/0HTJbhsmHoqCh3Tv6BxgA8/q/7UMPuSVmADzX1YEcuF7DH2PvLYK+I+Ct
	 a1OmI3XJycLJIp79xuPQ0L/IyJL7vSTHbzXq9dEqXFabJYwSIpkpJORnA0Hb6wWhIc
	 P/b3d7T9+gD3Q==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aec6360133so5090923e87.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 03:36:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpKu5NzWLcQcTpG6XyKUciCOjQEFJktvGjcS7YWu3p11aaWDSrrO2CNfENUdruzllJtBdLkJ+3Ing==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT59Gw5muGesaRciXKkmR+5pU33goKMNBQplEnr26lx3t84OCK
	jd5OfGvXAUafcdkpOPv0iXAXtmqhH1E7kK8ohWWcDOE2rjt18fkmpAFY2Lk8B8+cRVd3yvAL/nu
	fQR6zTeuH4CT0aADs8qUbHCwSWp1udxo=
X-Received: by 2002:a05:6512:b9b:b0:5b0:1ace:3bca with SMTP id
 2adb3069b0e04-5b1582d3a3fmr2599470e87.65.1784198189182; Thu, 16 Jul 2026
 03:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4746278.LvFx2qVVIh@rafael.j.wysocki> <3426078.44csPzL39Z@rafael.j.wysocki>
 <9ba08e86-d7ab-485d-b996-9f70d709071e@huawei.com>
In-Reply-To: <9ba08e86-d7ab-485d-b996-9f70d709071e@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 16 Jul 2026 12:36:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jYQOChsXFyr=nJh94d6uzn9mwz0wpFmEWywSkS3wdYTA@mail.gmail.com>
X-Gm-Features: AUfX_mxcdNNbVlJBUZR8UYc0CvzXcKziYFHQjR8qmUjLIiIu0x1Q02mmFTqZZiE
Message-ID: <CAJZ5v0jYQOChsXFyr=nJh94d6uzn9mwz0wpFmEWywSkS3wdYTA@mail.gmail.com>
Subject: Re: [PATCH v1 04/17] ACPI: processor: idle: Rearrange acpi_processor_evaluate_lpi()
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 11:46=E2=80=AFAM lihuisong (C) <lihuisong@huawei.co=
m> wrote:
>
>
> On 7/9/2026 8:33 PM, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Rearrange acpi_processor_evaluate_lpi() to make it somewhat easier to
> > follow and diagnose (if need be).  In particular:
> >
> >   * Rename some local variables and reorder their definitions.
> >
> >   * Change the type of local variables used for storing firmware-provid=
ed
> >     values to unsigned int (they cannot be negative).
> >
> >   * Eliminate local variable "loop" that is redundant.
> >
> >   * Avoid explicit pointer arithmetic.
> >
> >   * Print the correct number of _LPI state packages in the final debug
> >     message.
> >
> > No intentional functional impact beyond debug output.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/acpi/processor_idle.c | 64 +++++++++++++++++++---------------=
-
> >   1 file changed, 34 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idl=
e.c
> > index e8682f779249..cd506e9e5a84 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -872,12 +872,12 @@ static int obj_get_integer(union acpi_object *obj=
, u32 *value)
> >   static int acpi_processor_evaluate_lpi(acpi_handle handle,
> >                                      struct acpi_lpi_states_array *info=
)
> >   {
> > -     acpi_status status;
> > -     int ret =3D 0;
> > -     int pkg_count, state_idx =3D 1, loop;
> >       struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> > -     union acpi_object *lpi_data;
> > +     union acpi_object *lpi_data, *lpi_pkg;
> > +     unsigned int lpi_pkg_count, state_idx;
> >       struct acpi_lpi_state *lpi_state;
> > +     acpi_status status;
> > +     int ret =3D 0;
> >
> >       status =3D acpi_evaluate_object(handle, "_LPI", NULL, &buffer);
> >       if (ACPI_FAILURE(status)) {
> > @@ -895,41 +895,46 @@ static int acpi_processor_evaluate_lpi(acpi_handl=
e handle,
> >               goto end;
> >       }
> >
> > -     pkg_count =3D lpi_data->package.elements[2].integer.value;
> > +     lpi_pkg_count =3D lpi_data->package.elements[2].integer.value;
> >
> >       /* Validate number of power states. */
> > -     if (pkg_count < 1 || pkg_count !=3D lpi_data->package.count - 3) =
{
> > +     if (!lpi_pkg_count || lpi_pkg_count !=3D lpi_data->package.count =
- 3) {
> >               acpi_handle_debug(handle, "Invalid _LPI state count\n");
> >               ret =3D -ENODATA;
> >               goto end;
> >       }
> >
> > -     lpi_state =3D kzalloc_objs(*lpi_state, pkg_count);
> > +     lpi_state =3D kzalloc_objs(*lpi_state, lpi_pkg_count);
> >       if (!lpi_state) {
> >               ret =3D -ENOMEM;
> >               goto end;
> >       }
> >
> > -     info->size =3D pkg_count;
> > +     info->size =3D lpi_pkg_count;
> >       info->entries =3D lpi_state;
> >
> > -     /* LPI States start at index 3 */
> > -     for (loop =3D 3; state_idx <=3D pkg_count; loop++, state_idx++, l=
pi_state++) {
> > -             union acpi_object *element, *pkg_elem, *obj;
> > +     /* _LPI State packages start at index 3. */
> > +     lpi_pkg =3D &lpi_data->package.elements[3];
> >
> > -             element =3D &lpi_data->package.elements[loop];
> > -             if (element->type !=3D ACPI_TYPE_PACKAGE || element->pack=
age.count < 7)
> > +     for (state_idx =3D 1; state_idx <=3D lpi_pkg_count;
> > +          state_idx++, lpi_state++, lpi_pkg++) {
> > +             union acpi_object *lpi_pkg_elem, *obj;
> > +
> > +             lpi_state->index =3D state_idx;
> > +
> > +             if (lpi_pkg->type !=3D ACPI_TYPE_PACKAGE || lpi_pkg->pack=
age.count < 7)
> >                       continue;
>
> The first place to verify the count of LPI package.
>
> >
> > -             pkg_elem =3D element->package.elements;
> > +             lpi_pkg_elem =3D lpi_pkg->package.elements;
> >
> > -             obj =3D pkg_elem + 6;
> > +             /* Get the entry method first and skip the state if that =
fails. */
> > +             obj =3D &lpi_pkg_elem[6];
> >               if (obj->type =3D=3D ACPI_TYPE_BUFFER) {
> >                       struct acpi_power_register *reg;
> >
> >                       if (obj->buffer.length < sizeof(*reg)) {
> >                               acpi_handle_debug(handle,
> > -                                     "Invalid register data for _LPI s=
tate %d\n",
> > +                                     "Invalid register data for _LPI s=
tate %u\n",
> >                                       state_idx);
> >                               continue;
> >                       }
> > @@ -937,7 +942,7 @@ static int acpi_processor_evaluate_lpi(acpi_handle =
handle,
> >                       reg =3D (struct acpi_power_register *)obj->buffer=
.pointer;
> >                       if (reg->space_id !=3D ACPI_ADR_SPACE_FIXED_HARDW=
ARE) {
> >                               acpi_handle_debug(handle,
> > -                                     "Unsupported entry method for _LP=
I state %d\n",
> > +                                     "Unsupported entry method for _LP=
I state %u\n",
> >                                       state_idx);
> >                               continue;
> >                       }
> > @@ -949,36 +954,35 @@ static int acpi_processor_evaluate_lpi(acpi_handl=
e handle,
> >                       lpi_state->address =3D obj->integer.value;
> >               } else {
> >                       acpi_handle_debug(handle,
> > -                                       "Invalid entry method for _LPI =
state %d\n",
> > +                                       "Invalid entry method for _LPI =
state %u\n",
> >                                         state_idx);
> >                       continue;
> >               }
> >
> > -             lpi_state->index =3D state_idx;
> > -             if (obj_get_integer(pkg_elem + 0, &lpi_state->min_residen=
cy)) {
> > +             if (obj_get_integer(&lpi_pkg_elem[0], &lpi_state->min_res=
idency)) {
> >                       acpi_handle_debug(handle,
> > -                                       "Assuming 10 us min. residency =
for _LPI state %d\n",
> > +                                       "Assuming 10 us min. residency =
for _LPI state %u\n",
> >                                         state_idx);
> >                       lpi_state->min_residency =3D 10;
> >               }
> >
> > -             if (obj_get_integer(pkg_elem + 1, &lpi_state->wake_latenc=
y)) {
> > +             if (obj_get_integer(&lpi_pkg_elem[1], &lpi_state->wake_la=
tency)) {
> >                       acpi_handle_debug(handle,
> > -                                       "Assuming 10 us wake latency fo=
r _LPI state %d\n",
> > +                                       "Assuming 10 us wake latency fo=
r _LPI state %u\n",
> >                                         state_idx);
> >                       lpi_state->wake_latency =3D 10;
> >               }
> >
> > -             if (obj_get_integer(pkg_elem + 2, &lpi_state->flags))
> > +             if (obj_get_integer(&lpi_pkg_elem[2], &lpi_state->flags))
> >                       lpi_state->flags =3D 0;
> >
> > -             if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags)=
)
> > +             if (obj_get_integer(&lpi_pkg_elem[3], &lpi_state->arch_fl=
ags))
> >                       lpi_state->arch_flags =3D 0;
> >
> > -             if (obj_get_integer(pkg_elem + 4, &lpi_state->res_cnt_fre=
q))
> > +             if (obj_get_integer(&lpi_pkg_elem[4], &lpi_state->res_cnt=
_freq))
> >                       lpi_state->res_cnt_freq =3D 1;
> >
> > -             if (obj_get_integer(pkg_elem + 5, &lpi_state->enable_pare=
nt_state))
> > +             if (obj_get_integer(&lpi_pkg_elem[5], &lpi_state->enable_=
parent_state))
> >                       lpi_state->enable_parent_state =3D 0;
> >
> >               /* Skip elements [7-8] i.e. Residency/Usage counters. */
> > @@ -987,16 +991,16 @@ static int acpi_processor_evaluate_lpi(acpi_handl=
e handle,
> >                * Avoid out-of-bounds access if the size of the package =
is less
> >                * than expected.
> >                */
> > -             if (element->package.count < 10)
> > +             if (lpi_pkg->package.count < 10)
> >                       continue;
> >
> second place.
>
> I think the package count should be compared with 10 and placed at the
> begin of the loop.
> Even the optional element in LPI package also should be define NULL
> register or NULL string based on Spec 6.6.
> And they still occupy at least one position. For example, "State Name"
> must be "" if platform doesn't support it.
> So this packet count is at least 10.

In theory.

But it can be used even if there are fewer elements in it than 10.

The current code does so and I don't see a compelling reason for
changing that behavior.

> > -             obj =3D pkg_elem + 9;
> > +             obj =3D &lpi_pkg_elem[9];
> >               if (obj->type =3D=3D ACPI_TYPE_STRING)
> >                       strscpy(lpi_state->desc, obj->string.pointer,
> >                               ACPI_CX_DESC_LEN);
> >       }
> >
> > -     acpi_handle_debug(handle, "Found %d power states\n", state_idx);
> > +     acpi_handle_debug(handle, "Found %u power states\n", lpi_pkg_coun=
t);
> >   end:
> >       kfree(buffer.pointer);
> >       return ret;

Thanks!
