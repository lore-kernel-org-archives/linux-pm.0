Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936141E6B4
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206649; cv=none; b=pJdGWhLA09nKCvksJpWbFyvesMMoDNoaJQ//m4g/sEbUVReE8qNzYROVGfkuav12hjJnl2J8gUx7Mse4Ug9ZEoTcyuGnOhB/BgnpmCYnJjUUTWFw4qI7g89/KXicfngoaNJf96/ncQ8/Lcef2iA0DJ+ci2iQtxS/6QuC2gTMhYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206649; c=relaxed/simple;
	bh=vpFVGEaPT5EgInfvVmNe7MWW+UAnBV9E/VRkTOLLdUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tj/6+HDkqkIAkqtn0e4MM+RtJ34PTjbzpUZvx0baqUPU2d0Zyvq2mPQBT+EoFTVdZ/C+Y8rotf/8ywzH2dIOHry4K+1zF4P61qIs3vchFd5hIpVET7kgcfgTbjNLrjMhvv5nnmm/Al/So0LNCsT9Jvpr4tT8pzmOpRFSIAEIJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSu//AVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSu//AVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6EC1F00A3E
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784206647;
	bh=zhs6cmvdN5jaEJlQMykqoo6mTfiF2Y+EwUeMPtKTX4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eSu//AVUznnU5RQG512y3l3lFP+FtjZVH0IfsJBXmf+vMQiSZf7bsFj/wp4+HCBLd
	 XOQJHeVnXr4NvRa7+7zazKhJjh0uhyQPc3UYGn6I/Dk3zQLKt/VyRYTQO0bMEkamS1
	 4HEq2jCW31gAHP4ogNugCvZd4l109TBhdL4KD8flpTt3WzcjVlg5tmj85hI3Itw4px
	 SZjHskZ8pp46L2Ly+6/BWuwglr9Kx3nysUT6u0ITHAkC54ncafvMtUxznNIzKMaE0C
	 oUURYpNppgKJw0oJg63LoknoXSju47JFZS0wzKAk1We/Av2+4zzCzla6PLB2RBDzUj
	 v7NHR2EYwMgpg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b159850b16so3020391e87.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 05:57:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr1mjAO8IAK5f5gXhCUvispDezgD12OERtDfSboz0kg5BKWNEsHPjTTmcPrwoQ0MY6X8dOKjjCD7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1jv5kwhPBRGKXYdIWWEqFUDhZC9zxiQsQTmf5MdnzYJ58L9pb
	0bgNQUSQl2QRkcX1lsZEaL4Wf6dDEal5isJyb+j0y1ZQ4EYsh/VxoTM/AHE3740DPyE0yb+38Wa
	F0VGmtHdp0V/zx1ciDykskRASk8sb1gs=
X-Received: by 2002:a05:6512:641c:b0:5ae:afc5:4811 with SMTP id
 2adb3069b0e04-5b15827ccdfmr2739242e87.22.1784206646200; Thu, 16 Jul 2026
 05:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4746278.LvFx2qVVIh@rafael.j.wysocki> <3426078.44csPzL39Z@rafael.j.wysocki>
 <bd254106-0d09-420c-8a56-a63d637db683@huawei.com>
In-Reply-To: <bd254106-0d09-420c-8a56-a63d637db683@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 16 Jul 2026 14:57:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jhDV+zYLZz=3CXg6_GFUuhq_3rQ_zU-K1hXTRBfpL+HQ@mail.gmail.com>
X-Gm-Features: AUfX_mziQtwCnsvdb_lvaLtryPqiMnlmLAC45C5Shx2n9BLNy3dCSEawJl0TQYA
Message-ID: <CAJZ5v0jhDV+zYLZz=3CXg6_GFUuhq_3rQ_zU-K1hXTRBfpL+HQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/17] ACPI: processor: idle: Rearrange acpi_processor_evaluate_lpi()
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 1:52=E2=80=AFPM lihuisong (C) <lihuisong@huawei.com=
> wrote:
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
> How about move parsing lpi_pkg_elem[6] code to here?

If it fails, the other things don't need to be done at all, so it's
better to do it upfront IMV.
