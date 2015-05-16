From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH - RESEND] IRQ: don't suspend nested_thread irqs over system suspend.
Date: Sat, 16 May 2015 02:31:52 +0200
Message-ID: <1784621.LW7069gAjl@vostro.rjw.lan>
References: <20150224132805.385a56a5@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42551 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S2992439AbbEPAGi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 20:06:38 -0400
In-Reply-To: <20150224132805.385a56a5@notabene.brown>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, linux-pm@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>, Peter Zijlstra <peterz@infradead.org>

On Tuesday, February 24, 2015 01:28:05 PM NeilBrown wrote:
> 
> --Sig_/GFnrHDc1Bs/XVRdbvRQTN5O
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> 
> 
> Nested IRQs can only fire when the parent irq fires.
> So when the parent is suspended, there is no need to suspend
> the child irq.
> 
> Suspending nested irqs can cause a problem is they are suspended or
> resumed in the wrong order.
> If an interrupt fires while the parent is active but the child is
> suspended, then the interrupt will not be acknowledged properly
> and so an interrupt storm can result.
> This is particularly likely if the parent is resumed before
> the child, and the interrupt was raised during suspend.
> 
> Ensuring correct ordering would be possible, but it is simpler
> to just never suspend nested interrupts.
> 
> Signed-off-by: NeilBrown <neil@brown.name>

We need to make some progress here.

Can you please resend it again for people to have a fresh look (and CC PeterZ
this time too)?

> 
> ---
> This is a resend of a patch sent at the end of January 2015.
> Rafael seemed happy with it, but I receive no other response so I'm resendi=
> ng.
> 
> Thanks,
> NeilBrown
> 
> 
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index 3ca532592704..40cbcfb7fc43 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -118,6 +118,8 @@ void suspend_device_irqs(void)
>  		unsigned long flags;
>  		bool sync;
> =20
> +		if (irq_settings_is_nested_thread(desc))
> +			continue;
>  		raw_spin_lock_irqsave(&desc->lock, flags);
>  		sync =3D suspend_device_irq(desc, irq);
>  		raw_spin_unlock_irqrestore(&desc->lock, flags);
> @@ -158,6 +160,8 @@ static void resume_irqs(bool want_early)
> =20
>  		if (!is_early && want_early)
>  			continue;
> +		if (irq_settings_is_nested_thread(desc))
> +			continue;
> =20
>  		raw_spin_lock_irqsave(&desc->lock, flags);
>  		resume_irq(desc, irq);
> 
> --Sig_/GFnrHDc1Bs/XVRdbvRQTN5O
> Content-Type: application/pgp-signature
> Content-Description: OpenPGP digital signature
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
> 
> iQIVAwUBVOvhtTnsnt1WYoG5AQKnXxAAjQnaCA2UPMaoXcwoP/Qx1MJpMSjW6Q6v
> b7NiJTm7ltcKoPBN4y2//p0Wk6BEKT+nCbfqFacj4+MxfjrC4qtjIpsL6lVxi2Iz
> sBdbhdkKdUsX6ueRKWv5ifK9qbDzBje7QUcGDrJ/9n80rvbVB5AnSH8bM0TADs2W
> bfg5xWAMLfBZq4yhMTgOkPx7D9LMk6/HmlR55ZEC7JvZo6yKwifyQi18k1wfDlLZ
> FobxyB6/MexRpjG9RXLpp4MJLV7BV0b6wQhZWWYSFhxVcuYxb9u7BHWumtO9fCMy
> fgIzSVsZHuPxTH+ct7fbj+Pat+Y38c5RYpq4ojWJP2FnrGjEnrPt+dpw6AnbkPme
> JudzHus6HhgUu5vLdT/Hu5i1qhVcQVe7OaweqhGs1BReGYX7AVPAsVzJAJ09Fwyb
> vNIbfuPoTWVI1cz9VV7VgbFHwZgq9/yhk9KhvRaypaMTeuWKbcf2SgiX315w2e21
> D3Gxa6FDKc+CmnDycrx0eALtfCDp86gR2yeOeiCPAGUp8ICJ5vvAJcnxYVPYzt64
> JBBILBwzRV/7LNzbkYWEFlq4CCm9HhmkN4/HDC7tMcxCqQoVFTK0eGn5nz9kFZ6x
> MaUyhhakwK+cAx1bVmTZ+gdBxnaa31p26c2OFdv2VRFnJlFC2X+vc9GFuz8KUZCD
> d43mKkWNdWQ=
> =vmFh
> -----END PGP SIGNATURE-----
> 
> --Sig_/GFnrHDc1Bs/XVRdbvRQTN5O--
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
