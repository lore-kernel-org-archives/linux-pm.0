From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/5] regulator: Extend the power-management APIs
Date: Tue, 10 Jan 2017 12:10:26 +0000
Message-ID: <20170110121026.zstf7a6cflzk366l@sirena.org.uk>
References: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
 <1480687036-5037-2-git-send-email-boris.brezillon@free-electrons.com>
 <20170109191758.7zzxeh45pvwiw3jo@sirena.org.uk>
 <20170110093355.700f8225@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xobpfqcimfvwfdnu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39202 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031537AbdAJMKt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 07:10:49 -0500
Content-Disposition: inline
In-Reply-To: <20170110093355.700f8225@bbrezillon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org


--xobpfqcimfvwfdnu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 10, 2017 at 09:33:55AM +0100, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > However it
> > *is* a bit more than just making sure that the device suspend ordering
> > is good (though that's definitely part of it), there will be things
> > kicked off by hardware signalling without software knowing about it.

> Do you have an example, so that I can understand the use case?

Think about how a CPU suspends and signals the PMIC to go into suspend
mode - things signalled by hardware state changes that the hardware does
autonomously.

> > Anything that doesn't affect a hardware supported runtime state probably
> > needs to be split off and handled separately as that's the much more
> > risky bit

> Just to be sure, you mean regulator devices that do not support the
> ->set_suspend_xx() hooks, right?

Yes.

> >, moving changing of suspend mode earlier isn't going to cause
> > too much grief, that patch should just be split out and can probably
> > just go straight in.

> Yes, I just thought it would be clearer to have everything implemented
> in the same function. Since calling ->set_suspend_xx() does not have
> any impact on the runtime state, it can be called whenever we want
> (assuming we can still communicate with the regulator device to
> configure this suspend state).
> But if you prefer to have it split out in 2 different function, with the
> 'set suspend mode' bits called from the regulator_suspend_begin(), I'm
> fine with that.

No, I'm mainly saying that these things should be done in two separate
patches rather than talking about how the end code looks.  To a large
extent it does't matter when we apply the hardware supported suspend
modes, they won't take effect while software is running anyway.

> > Requring these functions to be called from every single driver seems
> > like we're doing something wrong - if we're going to do this we should
> > find some way to loop over all regulators and apply any unapplied
> > changes.

> I agree. Actually, I forgot that we had PM ops at the device class
> level. Maybe we could just move these generic ->suspend()/->resume()
> implementation here.

Yeah, I need to check if those class level operations always get run.

> > Batching things up at the end of suspend would also mean that
> > we'd be able to minimise the chances that we get the ordering wrong.

> Unfortunately that's not possible, for the exact same reason calling
> regulator_suspend_prepare() from the platform ->prepare() hook did not
> work for me: at that point, all devices have been suspended, and this
> includes the i2c controller which we're using to communicate with the
> PMIC exposing those regulators.

Do those devices actually get meaningfully suspended on your system, and
even on systems where we do if we are going to use the dependency graphs
we should be able to arrange to do something with that to reorder both
them and the regulators to as near the end of the queue as we can get
tehm - that way we minimise the chances of being bitten by any
unexpressed depdencies (which I expect we have a lot of given how
resistant people are to writing proper DTs).

> 2/ Rely on the device model dependency graph, and enter the suspend
>    state when the regulator device is being suspended (this is the
>    solution I'm proposing in this patch).

That's future work though (which is happening but still), right now we
know the graph doesn't work properly.  It also leaves us more open to
unexpressed dependencies which are

--xobpfqcimfvwfdnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh0zzEACgkQJNaLcl1U
h9CpEwf+P9ymVzX861fY1nBmvdiuhaqPe1mXUU0r/JK0ok31Xe4NVj4l3LM1FyK+
FTSY2xGJsAbb5oszAs1ku3MNB13hblMYbFyYwHA68ZU/IeuBD22pZT6vJtel5/vY
5XDSdsY245Gt9pEYJeXJ1P6dzFWXXnV1Jc8tzP7woD09q9Z9b6LOHFiZuuLLaUGj
kEFbrSkZSdi+EpozyzHxc0gXE8ZDvK6cWxdFpFIG0fRBnzWdVJX/wccEb81ZMlHu
YuIGL+etUULs8mNs/JksTEGAV5ZdxzhHNw6cD9BSE/p/CWJ0mgu4jLYw4wu1lK73
TCTQkbF66//0hZOhGI5biZwBiS3CfQ==
=tCiW
-----END PGP SIGNATURE-----

--xobpfqcimfvwfdnu--
