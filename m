From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: 2.6.37-rc2-git4: Reported regressions 2.6.35 ->
	2.6.36
Date: Fri, 19 Nov 2010 18:17:54 -0500
Message-ID: <AANLkTi==0+pNswCwfgo5v5tKA+Qkq7UfRdH4ftEqx7rf__11632.5130839416$1290208729$gmane$org@mail.gmail.com>
References: <tTUH_XeInOH.A.dMF.c3b5MB@chimera> <4CE5C919.7090504@teksavvy.com>
	<AANLkTi=8G7pNA7QTxaXDWKrWrCERPfmKU+nLJWCA=JUH@mail.gmail.com>
	<4CE7006E.4040102@teksavvy.com>
	<AANLkTim9aXi1_EJyh2f-+X4HnNWJ3uk2z=P6m1hQso5a@mail.gmail.com>
	<4CE70543.2000206@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4CE70543.2000206@teksavvy.com>
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

On Fri, Nov 19, 2010 at 6:16 PM, Mark Lord <kernel@teksavvy.com> wrote:
> On 10-11-19 05:58 PM, Alex Deucher wrote:
>>
>> On Fri, Nov 19, 2010 at 5:55 PM, Mark Lord<kernel@teksavvy.com> =A0wrote:
>>
>>> It now comes back at resume time.
>>
>> So that patch helped?
>
> I think so. =A0It didn't used to resume from suspend with 2.6.36, and now=
 it
> does.
>
>>> But suffers long delays (also sometimes with 2.6.35) doing this:
>>>
>>> [drm:atom_op_jump] *ERROR* atombios stuck in loop for more than 5secs
>>> aborting
>>> [drm:atom_execute_table_locked] *ERROR* atombios stuck executing E576
>>> (len
>>> 105, WS 12, PS 8) @ 0xE5C4
>>> [drm:atom_op_jump] *ERROR* atombios stuck in loop for more than 5secs
>>> aborting
>>> [drm:atom_execute_table_locked] *ERROR* atombios stuck executing ECD2
>>> (len
>>> 86, WS 4, PS 0) @ 0xED05
>>> [drm:atom_op_jump] *ERROR* atombios stuck in loop for more than 5secs
>>> aborting
>>> [drm:atom_execute_table_locked] *ERROR* atombios stuck executing E576
>>> (len
>>> 105, WS 12, PS 8) @ 0xE5C4
>>> PM: resume of devices complete after 15718.253 msecs
>>>
>>
>> It's be nice if you could bisect to track down when those started.
>
> It'd be even nicer if they hadn't started. =A0:)
>
> What kernel release first had that atom/ops table in it? =A0I'll try that.
>

2.6.31 or 32 was when radeon kms got merged IIRC.

Alex
