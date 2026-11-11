Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437139;
	b=OdIjaF7kZbN9fnhEXu0SYXgyuk0Oi0dfhs5ASLdAkWFOdr015lQaP/2HQQd9cyBFi/vM
	 /In/I8re09IZ9HdanqH+h0SKdEypK4ZUxTR0leegxTMKELRzsSpQUxVwJ8yNkPV/nap3f
	 sRxtbuOK0NXx3r3zsatI0F+N5Gb5Mus4p/pWD7A7jNP2FTrGL+bsfKYugZiBBVFeWbfOE
	 25F6rq0GSYzThnOKd4ZVCaN5AesuUWpCZxDyPW5/gIYS9DW2JKKiv0ullvgtRDOPQIUhK
	 pLXQE5/aAauZ4UY9tW+yy5dTnGmmIUxZz+Qh2aAII/HfJ65lm1LIWEUNeZqo3n7VEmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437139;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=bTNRrDyJIaQzdjvKuykbPAaKt2GSUHxJV8jWSJimVFY=;
	b=JSO40vI7ZoGTkB9f6osIsQQ1tsh/o0Z+uDKU4bDDK63O7hC/1FlTyArJqXf+FEC9z1H1
	 S73duWlHFX5MY3kiv1bStz1xTIeTRP5lUmfTeHkKxMpQuUKlmdTrjnxHz1fUxVKKEEjp4
	 A8aUkGjMKtuOuRWhi4eXtDe1I+w+dtWflUNk4ZdaFaF9VhwyGiCajEPF1mQ6J9ef4muDF
	 TN76Mj/qUkp33Sa3Ccw8ayCsE85wtbn3rCpZR3ZUM/KnpbFpFTtjt7owIhmfnF2+JeSzu
	 fPPcFqU1s6muRuA0Jy1PHGzuZxLOAffPNJyPthG3Lxr1cS1C1ajxIhwCGYPGHliwFZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R3pZgORl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC334606AECE;
	Wed, 11 Nov 2026 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R3pZgORl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ECC1F00A05;
	Wed, 11 Nov 2026 22:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437139;
	bh=bTNRrDyJIaQzdjvKuykbPAaKt2GSUHxJV8jWSJimVFY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=R3pZgORlFaXTx2QdOC7R+40DS85tapWRsKWDW73ehK8H+6O6ri1GVPiLnHSADM6R6
	 NVlPZ8gjnruhlVfWHxVWdbYl+BXT10VMOxRXyi+XroCHWY8NB+iGVLgVcIy2ydHymi
	 LUpKGPP33QL1h2gPPSzp4BqqXxF8ENv5qfkWZFyGiRyBNPtdWxNX8g0nMEcIVWxT8R
	 mtwkozKxUH6SXatGn/vNbQNQaNc4XVxyTrAFz1anW7y5Bdi6hjKID8W87041VErtua
	 gZFQxISflM36ayVV95nYbtz/c9pZAoSQt7i6aRl/taaNzEgauBYGzHY9OE/welk1P8
	 ZlQjbBz996ZhQ==
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 23:45:23 +0100
Message-Id: <DMSQVECFDJK0.2G5WLV9WPQN3M@kernel.org>
Subject: Re: [PATCH v5 1/3] rust: add runtime PM support
Cc: <ojeda@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <daniel.almeida@collabora.com>,
 <boris.brezillon@collabora.com>, <work@onurozkan.dev>,
 <samitolvanen@google.com>, <acourbot@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
To: "Beata Michalska" <beata.michalska@arm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261026120523.526942-1-beata.michalska@arm.com>
 <20261026120523.526942-2-beata.michalska@arm.com>
 <DMNFI31C8X12.3L2J0GKKNJN81@kernel.org> <avTT5VuspuFKbnBv@arm.com>
In-Reply-To: <avTT5VuspuFKbnBv@arm.com>

On Wed Nov 11, 2026 at 9:45 PM CET, Beata Michalska wrote:
> On Thu, Nov 05, 2026 at 05:47:28PM +0100, Danilo Krummrich wrote:
>> On Mon Oct 26, 2026 at 1:05 PM CET, Beata Michalska wrote:
>> > +#[vtable]
>> > +pub trait PMOps: Sized {
>> > +    /// The bus adapter that installs the generated PM ops.
>> > +    type Adapter: driver::DriverLayout + 'static;
>> > +
>> > +    /// Type of the bound bus device passed to runtime PM callbacks.
>> > +    type DeviceType: AsBusDevice<device::Bound>;
>> > +
>> > +    /// Type of the payload moved through runtime PM transitions.
>> > +    type RuntimePayloadType: Send + 'static;
>>=20
>> I got back to this type after writing the below, because at first I thou=
ght this
>> is purely the data type that is cycled through suspend() and resume().
>>=20
>> However, reading further this is currently the Registration's private da=
ta. This
>> won't work. The Registration's private data must not require 'static as =
we need
>> device resources in this data.
>>=20
>> So, there should be at least two separate types:
>>=20
>>   (1) The private data of pm::Registration.
>>=20
>>   (2) An object that is created and returned by suspend() and passed by =
value to
>>       resume(), so it can store e.g. reverse guard types (see below).
>>=20
>> This should also get us rid of the PMPayload magic.
>>=20
> The `'static' lifetime is definitely a shortsighted idea on my side.
> Splitting the data does seem reasonable, though I'm not sure how that wou=
ld allow
> us to get rid of moving around the `PMPayload`, as this is what I assume =
you
> are referring to by 'magic'. The pm framework still needs to keep the cal=
lback
> data between the transitions. Also I am not convinced the pm should disti=
nguish
> between suspend and resume data - my thinking was it should be handled by=
 the
> driver. We just need 'an' object to move back and forth.

For data that does outlive all the suspend/resume cycles (i.e. data that li=
ves
as long as the pm::Registration), it should go into pm::Ops::RegistrationDa=
ta.

For Tyr this would e.g. be:

	let runtime_payload =3D TyrPmRegistrationData {
	    clks: Clocks {
	        core: core_clk,
	        stacks: stacks_clk,
	        coregroup: coregroup_clk,
	    },
	    _regulators: Regulators {
	        _mali: mali_regulator,
	        _sram: sram_regulator,
	    },
	};

pm::Ops::SuspendData and pm::Ops::ResumeData (if needed) should only live
throughout suspend and resume, so they can carry e.g. reverse guard types s=
uch
as pci::DeviceDisableGuard, which should only live during a a suspend (it c=
an't
live in resume data for obvious reasons, so a single type is not sufficient=
).

If we have both, pm::Ops::SuspendData and pm::Ops::ResumeData, nothing prev=
ents
drivers to make those types share fields or even be identical, so you can s=
till
cycle things around. Although I don't really see what would be the use case=
 of
that.

I assume that my below function signature caused some confusion, because I
messed it up. What I actually meant is:

	fn runtime_resume<'a>(
	    dev: &Self::DeviceType,
	    reg_data: Self::RegistrationData<'>,
	    suspended: Self::SuspendData<'a>,
	) -> Result<(), (Self::SuspendData<'a>, Error)>;

>> > +
>> > +    /// Runtime resume callback.
>>=20
>> It would be good to expand this doc-comment explaining the semantics of
>> RuntimePayloadType.
>>=20
>> > +    fn runtime_resume<'a>(
>> > +        _dev: &'a Self::DeviceType,
>> > +        _payload: Self::RuntimePayloadType,
>> > +    ) -> PMCallbackResult<Self::RuntimePayloadType> {
>> > +        build_error!(VTABLE_DEFAULT_ERROR)
>> > +    }
>> > +
>> > +    /// Runtime suspend callback.
>> > +    fn runtime_suspend<'a>(
>> > +        _dev: &'a Self::DeviceType,
>> > +        _payload: Self::RuntimePayloadType,
>> > +    ) -> PMCallbackResult<Self::RuntimePayloadType> {
>> > +        build_error!(VTABLE_DEFAULT_ERROR)
>> > +    }
>>=20
>> I think for Tyr it so far is sufficient to have a single RuntimePayloadT=
ype that
>> keeps cycling through the callbacks, but there will be use-cases where t=
he types
>> differ.
>>=20
>> For instance, for a PCI driver you will have DeviceDisableGuard stored i=
n
>> suspend() and then you'll want to drop it in resume() so the device gets=
 enabled
>> again.
>>=20
>> We should also avoid requiring 'static, as reverse guards will borrow th=
e
>> regular guard, e.g. pci::DeviceDisableGuard will borrow from
>> pci::DeviceEnableGuard.
>>=20
>> For runtime_resume() I think of something like:
>>=20
>> 	fn runtime_resume<'a>(
>> 	    dev: &Self::DeviceType,
>> 	    suspended: Self::SuspendData<'a>,
>> 	) -> Result<(), (Self::SuspendData<'a>, Error)>;
>>=20
