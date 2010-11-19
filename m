From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: 2.6.37-rc2-git4: Reported regressions 2.6.35 ->
	2.6.36
Date: Fri, 19 Nov 2010 17:58:59 -0500
Message-ID: <AANLkTim9aXi1_EJyh2f-+X4HnNWJ3uk2z=P6m1hQso5a__38241.9943846346$1290207911$gmane$org@mail.gmail.com>
References: <tTUH_XeInOH.A.dMF.c3b5MB@chimera> <4CE5C919.7090504@teksavvy.com>
	<AANLkTi=8G7pNA7QTxaXDWKrWrCERPfmKU+nLJWCA=JUH@mail.gmail.com>
	<4CE7006E.4040102@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4CE7006E.4040102@teksavvy.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 19, 2010 at 5:55 PM, Mark Lord <kernel@teksavvy.com> wrote:
> On 10-11-19 11:39 AM, Alex Deucher wrote:
>>
>> On Thu, Nov 18, 2010 at 7:47 PM, Mark Lord<kernel@teksavvy.com> =A0wrote:
>>
>>> My non-Intel graphics notebook (has ATI X1400 graphics) also has a resu=
me
>>> regression with 2.6.36. =A0But it does work fine with 2.6.35 (and earli=
er,
>>> back many years). =A0As a result, I'm stuck with 2.6.35 for the time be=
ing,
>>> and lack the time for a concerted debug effort on 2.6.36+ right now.
>>>
>>
>> Can you bisect? =A0Does this patch help?
>>
>> diff --git a/drivers/gpu/drm/radeon/atom.c b/drivers/gpu/drm/radeon/atom=
.c
>> index 8e421f6..05efb5b 100644
>> --- a/drivers/gpu/drm/radeon/atom.c
>> +++ b/drivers/gpu/drm/radeon/atom.c
>> @@ -112,6 +112,7 @@ static uint32_t atom_iio_execute(struct
>> atom_context *ctx, int base,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base +=3D 3;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case ATOM_IIO_WRITE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void)ctx->card->ioreg_rea=
d(ctx->card, CU16(base +
>> 1));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctx->card->ioreg_write(c=
tx->card, CU16(base + 1),
>> temp);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base +=3D 3;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> It now comes back at resume time.

So that patch helped?

>
> But suffers long delays (also sometimes with 2.6.35) doing this:
>
> [drm:atom_op_jump] *ERROR* atombios stuck in loop for more than 5secs
> aborting
> [drm:atom_execute_table_locked] *ERROR* atombios stuck executing E576 (len
> 105, WS 12, PS 8) @ 0xE5C4
> [drm:atom_op_jump] *ERROR* atombios stuck in loop for more than 5secs
> aborting
> [drm:atom_execute_table_locked] *ERROR* atombios stuck executing ECD2 (len
> 86, WS 4, PS 0) @ 0xED05
> [drm:atom_op_jump] *ERROR* atombios stuck in loop for more than 5secs
> aborting
> [drm:atom_execute_table_locked] *ERROR* atombios stuck executing E576 (len
> 105, WS 12, PS 8) @ 0xE5C4
> PM: resume of devices complete after 15718.253 msecs
>

It's be nice if you could bisect to track down when those started.

> So I did this (local hack only, obviously NOT for mainline) to work around
> that issue:
>
> --- linux-2.6.36/drivers/gpu/drm/radeon/atom.c =A02010-10-20
> 16:30:22.000000000 -0400
> +++ linux/drivers/gpu/drm/radeon/atom.c 2010-11-19 17:14:21.141807003 -05=
00
> @@ -1150,6 +1151,7 @@
>
> =A0 =A0 =A0 =A0if (!base)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0 =A0 if (base =3D=3D 0xe576 || base =3D=3D 0xecd2) return 0; =A0=
/* prevent freezes
> on Dell i9400 w/X1400 */
>
> =A0 =A0 =A0 =A0len =3D CU16(base + ATOM_CT_SIZE_PTR);
> =A0 =A0 =A0 =A0ws =3D CU8(base + ATOM_CT_WS_PTR);
>
