From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Fri, 20 May 2011 13:39:37 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1695163656-75410929-1305895178=:8018"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110520113758.GA3141@arm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1695163656-75410929-1305895178=:8018
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Fri, 20 May 2011, Dave Martin wrote:

[ ... ]
>> +/*
>> + * Save the current CPU state before suspend / poweroff.
>> + */
>> +ENTRY(swsusp_arch_suspend)
>> +	ldr	r0, =__swsusp_arch_ctx
>> +	mrs	r1, cpsr
>> +	str	r1, [r0], #4		/* CPSR */
>> +ARM(	msr	cpsr_c, #SYSTEM_MODE					)
>> +THUMB(	mov	r2, #SYSTEM_MODE					)
>> +THUMB(	msr	cpsr_c, r2						)
>
> For Thumb-2 kernels, you can use the cps instruction to change the CPU
> mode:
> 	cps	#SYSTEM_MODE
>
> For ARM though, this instruction is only supported for ARMv6 and above,
> so it's best to keep the msr form for compatibility for that case.

Ah, ok, no problem will make that change, looks good.

Do all ARMs have cpsr / spsr as used here ? Or is that code restricted to 
ARMv5+ ? I don't have the CPU evolution history there, only got involved 
with ARM when armv6 already was out.

I've simply done there what the "setmode" macro from <asm/assembler.h> 
is doing, have chosen not to include that file because it overrides "push" 
on a global scale for no good reason and that sort of thing makes me 
cringe.


>
>> +	stm	r0!, {r4-r12,lr}	/* nonvolatile regs */
>
> Since r12 is allowed to be corrupted across a function call, we
> probably don't need to save it.

ah ok thx for clarification. Earlier iterations of the patch just saved 
r0-r14 there, "just to have it all", doing it right is best as always.

>
[ ... ]
>> +	bl	__save_processor_state
>
> <aside>
>
> Structurally, we seem to have:
>
> swsusp_arch_suspend {
> 	/* save some processor state */
> 	__save_processor_state();
>
> 	swsusp_save();
> }
>
> Is __save_processor_state() intended to encapsulate all the CPU-model-
> specific state saving?  Excuse my ignorance of previous conversations...
>
> </aside>

You're right.

I've attached the codechanges which implement __save/__restore... for 
TI OMAP3 and Samsung S5P64xx, to illustrate, again (that's the stuff 
referred to in the earlier mail I mentioned in first post; beware of code 
churn in there, those diffs don't readily apply to 'just any' kernel).

These hooks are essentially the same as the machine-specific cpu_suspend() 
except that we substitute "r0" (the save context after the generic part) 
as target for where-to-save-the-state, and we make the funcs return 
instead of switching to OFF mode.

That's what I meant with "backdoorish". A better way would be to change 
the cpu_suspend interface so that it returns instead of directly switching 
to off mode / powering down.

Russell has lately been making changes in this area; the current kernels 
are a bit different here since the caller already supplies the 
state-save-buffer, while the older ones used to choose in some 
mach-specific way where to store that state.

(one of the reasons why these mach-dependent enablers aren't part of this 
patch suggestion ...)


>
>> +	pop	{lr}
>> +	b	swsusp_save
>> +ENDPROC(swsusp_arch_suspend)
>
> I'm not too familiar with the suspend/resume stuff, so I may be asking
> a dumb question here, but:
>
> Where do we save/restore r8_FIQ..r13_FIQ, r13_IRQ, r13_UND and r13_ABT?
> (I'm assuming there's no reason to save/restore r14 or SPSR for any
> exception mode, since we presumably aren't going to suspend/resume
> from inside an exception handler (?))
>
> The exception stack pointers might conceivably be reinitialised to
> sane values on resume, without necessarily needing to save/restore
> them, providing my assumption in the previous paragraph is correct.
>
> r8_FIQ..r12_FIQ can store arbitrary state used by the FIQ handler,
> if FIQ is in use.  Can we expect any driver using FIQ to save/restore
> this state itself, rather than doing it globally?  This may be
> reasonable.

We don't need to save/restore those, because at the time the snapshot is 
taken interrupts are off and we cannot be in any trap handler either. On 
resume, the kernel that has been loaded has initialized them properly 
already.

If there's really any driver out there which uses FIQ in such an exclusive 
manner that it expects FIQ register bank contents to remain the same 
across multiple FIQ events then it's rather that driver's responsibility 
to perform the save/restore via suspend/resume callbacks.

See also Russell's mails about that, for previous attempts a year and half 
a year ago to get "something for ARM hibernation" in:

https://lists.linux-foundation.org/pipermail/linux-pm/2010-July/027571.html
https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029665.html

The kernel doesn't do IRQ/FIQ/ABT/UND save / restore for suspend-to-ram 
either. CPU hotplug support (re)initializes those. I believe we're fine.


>
> Cheers
> ---Dave
>
>

Thanks,
FrankH.
--1695163656-75410929-1305895178=:8018
Content-Type: TEXT/x-diff; name=s5p-hibernate-hook.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.00.1105201339370.8018@localhost6.localdomain6>
Content-Description: 
Content-Disposition: attachment; filename=s5p-hibernate-hook.patch

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtczVwL3NsZWVwLlMgYi9hcmNo
L2FybS9wbGF0LXM1cC9zbGVlcC5TDQppbmRleCAyY2RhZTRhLi5kZDk1MTZi
IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vcGxhdC1zNXAvc2xlZXAuUw0KKysr
IGIvYXJjaC9hcm0vcGxhdC1zNXAvc2xlZXAuUw0KQEAgLTQ0LDE0ICs0NCwz
MiBAQA0KICovDQogCS50ZXh0DQogDQorI2lmZGVmIENPTkZJR19ISUJFUk5B
VElPTg0KK0VOVFJZKF9fc2F2ZV9wcm9jZXNzb3Jfc3RhdGUpDQorCW1vdgly
MSwgIzANCisJYgkuTHMzY19jcHVfc2F2ZV9pbnRlcm5hbA0KK0VORFBST0Mo
X19zYXZlX3Byb2Nlc3Nvcl9zdGF0ZSkNCisNCitFTlRSWShfX3Jlc3RvcmVf
cHJvY2Vzc29yX3N0YXRlKQ0KKwlzdG1mZAlzcCEsIHsgcjMgLSByMTIsIGxy
IH0NCisJbGRyCXIyLCA9LkxzM2NfY3B1X3Jlc3VtZV9pbnRlcm5hbA0KKwlt
b3YJcjEsICMxDQorCXN0cglzcCwgW3IwLCAjNDBdCQlAIGZpeHVwIHNwIGlu
IHJlc3RvcmUgY29udGV4dA0KKwltb3YJcGMsIHIyDQorRU5EUFJPQyhfX3Jl
c3RvcmVfcHJvY2Vzc29yX3N0YXRlKQ0KKyNlbmRpZg0KKw0KIAkvKiBzM2Nf
Y3B1X3NhdmUNCiAJICoNCiAJICogZW50cnk6DQogCSAqCXIwID0gc2F2ZSBh
ZGRyZXNzICh2aXJ0dWFsIGFkZHIgb2YgczNjX3NsZWVwX3NhdmVfcGh5cykN
Ci0JKi8NCisJICoJcjEgKF9pbnRlcm5hbF8gb25seSkgPSBDUFUgc2xlZXAg
dHJhbXBvbGluZSAoaWYgYW55KQ0KKwkgKi8NCiANCiBFTlRSWShzM2NfY3B1
X3NhdmUpDQogDQorCWxkcglyMSwgPXBtX2NwdV9zbGVlcAlAIHNldCB0cmFt
cG9saW5lDQorLkxzM2NfY3B1X3NhdmVfaW50ZXJuYWw6DQogCXN0bWZkCXNw
ISwgeyByMyAtIHIxMiwgbHIgfQ0KIA0KIAltcmMJcDE1LCAwLCByNCwgYzEz
LCBjMCwgMAlAIEZDU0UvUElEDQpAQCAtNjcsMTEgKzg1LDE1IEBAIEVOVFJZ
KHMzY19jcHVfc2F2ZSkNCiANCiAJc3RtaWEJcjAsIHsgcjMgLSByMTMgfQ0K
IA0KKwltb3YJcjQsIHIxDQogCUBAIHdyaXRlIG91ciBzdGF0ZSBiYWNrIHRv
IFJBTQ0KIAlibAlzM2NfcG1fY2JfZmx1c2hjYWNoZQ0KIA0KKwltb3ZzCXIw
LCByNA0KKyNpZmRlZiBDT05GSUdfSElCRVJOQVRJT04NCisJbGRtZXFmZAlz
cCEsIHsgcjMgLSByMTIsIHBjIH0JQCBpZiB0aGVyZSB3YXMgbm8gdHJhbXBv
bGluZSwgcmV0dXJuDQorI2VuZGlmDQogCUBAIGp1bXAgdG8gZmluYWwgY29k
ZSB0byBzZW5kIHN5c3RlbSB0byBzbGVlcA0KLQlsZHIJcjAsID1wbV9jcHVf
c2xlZXANCiAJQEBsZHIJcGMsIFsgcjAgXQ0KIAlsZHIJcjAsIFsgcjAgXQ0K
IAltb3YJcGMsIHIwDQpAQCAtODYsNiArMTA4LDcgQEAgcmVzdW1lX3dpdGhf
bW11Og0KIAlzdHIJcjEyLCBbcjRdDQogDQogCWxkbWZkCXNwISwgeyByMyAt
IHIxMiwgcGMgfQ0KK0VORFBST0MoczNjX2NwdV9zYXZlKQ0KIA0KIAkubHRv
cmcNCiANCkBAIC0xMzEsNiArMTU0LDcgQEAgRU5UUlkoczNjX2NwdV9yZXN1
bWUpDQogCW1jcglwMTUsIDAsIHIxLCBjNywgYzUsIDAJCUBAIGludmFsaWRh
dGUgSSBDYWNoZQ0KIA0KIAlsZHIJcjAsIHMzY19zbGVlcF9zYXZlX3BoeXMJ
QCBhZGRyZXNzIG9mIHJlc3RvcmUgYmxvY2sNCisuTHMzY19jcHVfcmVzdW1l
X2ludGVybmFsOg0KIAlsZG1pYQlyMCwgeyByMyAtIHIxMyB9DQogDQogCW1j
cglwMTUsIDAsIHI0LCBjMTMsIGMwLCAwCUAgRkNTRS9QSUQNCkBAIC0xNTIs
NiArMTc2LDExIEBAIEVOVFJZKHMzY19jcHVfcmVzdW1lKQ0KIAltY3IJcDE1
LCAwLCByMTIsIGMxMCwgYzIsIDAJQCB3cml0ZSBQUlJSDQogCW1jcglwMTUs
IDAsIHIzLCBjMTAsIGMyLCAxCUAgd3JpdGUgTk1SUg0KIA0KKyNpZmRlZiBD
T05GSUdfSElCRVJOQVRJT04NCisJY21wCXIxLCAjMA0KKwlibmUJMGYJCQlA
IG9ubHkgZG8gTU1VIHBoeXMgaW5pdA0KKwkJCQkJQCBub3QgY2FsbGVkIGJ5
IF9fcmVzdG9yZV9wcm9jZXNzb3Jfc3RhdGUNCisjZW5kaWYNCiAJLyogY2Fs
Y3VsYXRlIGZpcnN0IHNlY3Rpb24gYWRkcmVzcyBpbnRvIHI4ICovDQogCW1v
dglyNCwgcjYNCiAJbGRyCXI1LCA9MHgzZmZmDQpAQCAtMTc1LDYgKzIwNCw3
IEBAIEVOVFJZKHMzY19jcHVfcmVzdW1lKQ0KIAlzdHIJcjEwLCBbcjRdDQog
DQogCWxkcglyMiwgPXJlc3VtZV93aXRoX21tdQ0KKzA6DQogCW1jcglwMTUs
IDAsIHI5LCBjMSwgYzAsIDAJCUAgdHVybiBvbiBNTVUsIGV0Yw0KIA0KICAg
ICAgICAgbm9wDQpAQCAtMTgzLDYgKzIxMyw5IEBAIEVOVFJZKHMzY19jcHVf
cmVzdW1lKQ0KICAgICAgICAgbm9wDQogICAgICAgICBub3AJCQkJCUAgc2Vj
b25kLXRvLWxhc3QgYmVmb3JlIG1tdQ0KIA0KKyNpZmRlZiBDT05GSUdfSElC
RVJOQVRJT04NCisJbGRtbmVmZAlzcCEsIHsgcjMgLSByMTIsIHBjIH0NCisj
ZW5kaWYNCiAJbW92CXBjLCByMgkJCQlAIGdvIGJhY2sgdG8gdmlydHVhbCBh
ZGRyZXNzDQogDQogCS5sdG9yZw0K

--1695163656-75410929-1305895178=:8018
Content-Type: TEXT/x-diff; name=omap3-hibernate-hook.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.00.1105201339371.8018@localhost6.localdomain6>
Content-Description: 
Content-Disposition: attachment; filename=omap3-hibernate-hook.patch

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvc2xlZXAzNHh4LlMg
Yi9hcmNoL2FybS9tYWNoLW9tYXAyL3NsZWVwMzR4eC5TDQppbmRleCBlYTRl
NDk4Li4xOWVjZDhlIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9zbGVlcDM0eHguUw0KKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9zbGVl
cDM0eHguUw0KQEAgLTM1OCw2ICszNTgsNyBAQCBsb2dpY19sMV9yZXN0b3Jl
Og0KIAlsZHIJcjQsIHNjcmF0Y2hwYWRfYmFzZQ0KIAlsZHIJcjMsIFtyNCwj
MHhCQ10NCiAJYWRkcwlyMywgcjMsICMxNg0KKy5MbG9naWNfbDFfcmVzdG9y
ZV9pbnRlcm5hbDoNCiAJbGRtaWEJcjMhLCB7cjQtcjZ9DQogCW1vdglzcCwg
cjQNCiAJbXNyCXNwc3JfY3hzZiwgcjUNCkBAIC00MzMsNiArNDM0LDEwIEBA
IHR0YnJfZXJyb3I6DQogCSovDQogCWIJdHRicl9lcnJvcg0KIHVzZXR0YnIw
Og0KKyNpZmRlZiBDT05GSUdfSElCRVJOQVRJT04NCisJY21wCXIxLCAjMQ0K
KwlsZG1lcWZkCXNwISwgeyByMCAtIHIxMiwgcGMgfQlAIGVhcmx5IHJldHVy
biBmcm9tIF9fcmVzdG9yZV9wcm9jZXNzb3Jfc3RhdGUNCisjZW5kaWYNCiAJ
bXJjCXAxNSwgMCwgcjIsIGMyLCBjMCwgMA0KIAlsZHIJcjUsIHR0YnJiaXRf
bWFzaw0KIAlhbmQJcjIsIHI1DQpAQCAtNDcxLDYgKzQ3NiwyNSBAQCB1c2V0
dGJyMDoNCiAJbWNyCXAxNSwgMCwgcjQsIGMxLCBjMCwgMA0KIA0KIAlsZG1m
ZAlzcCEsIHtyMC1yMTIsIHBjfQkJQCByZXN0b3JlIHJlZ3MgYW5kIHJldHVy
bg0KKw0KKyNpZmRlZiBDT05GSUdfSElCRVJOQVRJT04NCitFTlRSWShfX3Nh
dmVfcHJvY2Vzc29yX3N0YXRlKQ0KKwlzdG1mZAlzcCEsIHtyMC1yMTIsIGxy
fQ0KKwltb3YJcjEsICMweDQNCisJbW92CXI4LCByMA0KKwliCWwxX2xvZ2lj
X2xvc3QNCitFTkRQUk9DKF9fc2F2ZV9wcm9jZXNzb3Jfc3RhdGUpDQorDQor
RU5UUlkoX19yZXN0b3JlX3Byb2Nlc3Nvcl9zdGF0ZSkNCisJc3RtZmQJc3Ah
LCB7IHIwIC0gcjEyLCBsciB9DQorCXN0cglzcCwgW3IwXQkJQCBmaXh1cCBz
YXZlZCBzdGFjayBwb2ludGVyDQorCXN0cglsciwgW3IwLCAjOF0JCUAgZml4
dXAgc2F2ZWQgbGluayByZWdpc3Rlcg0KKwltb3YJcjMsIHIwDQorCW1vdgly
MSwgIzENCisJYgkuTGxvZ2ljX2wxX3Jlc3RvcmVfaW50ZXJuYWwNCitFTkRQ
Uk9DKF9fcmVzdG9yZV9wcm9jZXNzb3Jfc3RhdGUpDQorI2VuZGlmDQorDQog
c2F2ZV9jb250ZXh0X3dmaToNCiAJLypiCXNhdmVfY29udGV4dF93ZmkqLwlA
IGVuYWJsZSB0byBkZWJ1ZyBzYXZlIGNvZGUNCiAJbW92CXI4LCByMCAvKiBT
dG9yZSBTRFJBTSBhZGRyZXNzIGluIHI4ICovDQpAQCAtNTQ1LDYgKzU2OSwx
MCBAQCBsMV9sb2dpY19sb3N0Og0KIAltcmMJcDE1LCAwLCByNCwgYzEsIGMw
LCAwDQogCS8qIHNhdmUgY29udHJvbCByZWdpc3RlciAqLw0KIAlzdG1pYQly
OCEsIHtyNH0NCisjaWZkZWYgQ09ORklHX0hJQkVSTkFUSU9ODQorCWNtcAly
MSwgIzQNCisJbGRtZXFmZAlzcCEsIHtyMC1yMTIsIHBjfQlAIGVhcmx5IHJl
dHVybiBmcm9tIF9fc2F2ZV9wcm9jZXNzb3Jfc3RhdGUNCisjZW5kaWYNCiBj
bGVhbl9jYWNoZXM6DQogCS8qIENsZWFuIERhdGEgb3IgdW5pZmllZCBjYWNo
ZSB0byBQT1UqLw0KIAkvKiBIb3cgdG8gaW52YWxpZGF0ZSBvbmx5IEwxIGNh
Y2hlPz8/PyAtICNGSVhfTUUjICovDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
cGxhdC1vbWFwL0tjb25maWcgYi9hcmNoL2FybS9wbGF0LW9tYXAvS2NvbmZp
Zw0KaW5kZXggZGY1Y2U1Ni4uYjQ3MTNiYSAxMDA2NDQNCi0tLSBhL2FyY2gv
YXJtL3BsYXQtb21hcC9LY29uZmlnDQorKysgYi9hcmNoL2FybS9wbGF0LW9t
YXAvS2NvbmZpZw0KQEAgLTIzLDYgKzIzLDcgQEAgY29uZmlnIEFSQ0hfT01B
UDMNCiAJc2VsZWN0IENQVV9WNw0KIAlzZWxlY3QgQ09NTU9OX0NMS0RFVg0K
IAlzZWxlY3QgT01BUF9JT01NVQ0KKwlzZWxlY3QgQVJDSF9ISUJFUk5BVElP
Tl9QT1NTSUJMRQ0KIA0KIGNvbmZpZyBBUkNIX09NQVA0DQogCWJvb2wgIlRJ
IE9NQVA0Ig0K

--1695163656-75410929-1305895178=:8018
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--1695163656-75410929-1305895178=:8018--
