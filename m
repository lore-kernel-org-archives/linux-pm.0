From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] PM: invoke suspend notifications after
	console switch
Date: Thu, 24 Jan 2008 09:35:12 +0100
Message-ID: <1201163713.3454.39.camel@johannes.berg>
References: <1197853799.4885.7.camel@johannes.berg>
	<1199970876.3861.66.camel@johannes.berg> <20080111182042.GC4016@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7772651003453113100=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080111182042.GC4016@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============7772651003453113100==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-erL/svVGXbtqdEGdeImx"


--=-erL/svVGXbtqdEGdeImx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Its pretty intrusive I'd say.

I can sort of subscribe to that, but the whole suspend stuff is pretty
intrusive overall.

>  And it is wrong;

Obviously, I disagree.

>  we'd prefer userspace
> to know what we are doing; if they are told we are suspending,
> userspace may be able to do something more clever than long console
> switch.

Are you even talking about this patch? We don't currently give anyone a
choice: We *always* do a "long console switch" anyway! If userspace were
to decide that it can do much better and X can support suspend, then now
we take the decision off it and switch to a suspend console while
userspace is thinking there's no need.

What this patch enables is basically allowing us to remove the suspend
console switch. How? Currently, suspend notifications with a whole bunch
of ramifications all over the place are invoked before the console
switch. By moving the console switch up, we essentially make the
sequence identical to (a) removing the in-kernel console switch and (b)
replacing it with userspace doing a console switch right before asking
us to suspend.

johannes

--=-erL/svVGXbtqdEGdeImx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR5hNv6Vg1VMiehFYAQI1dg//XUg4qT+oen1YcgNs6JesGAuZtiZgjrrn
p+dwsK9l2FSQmtqBKibqbm7kSfCVGlCOi7TxVl8a33mBeE2hT+mUAL/9tjCECL2p
yPJ95o2y7f6VLX8e02Io2dW5KPxbcVaFKWOAwon03R+DoFl2jjXC3zUaSMNrQ5DA
no1IdnL4/7egjFDwH6vvFfkKocCZbGPccun4C3E7hXai1WbCy3GQ2KlIaB7xEOjB
GDbQi8yHdCfL4Tz6+kP5Xg/ZZo8gGCn9yN+IIA2107V56E9434cWj/Zj7lroIw7W
4aEXb2mnoEKHxfBsXNZO6kdkDk8pNGipZ5MxJUG5KBoBJ59dvQ/zF9yCtlEr86AN
ONtRSM/sq4Asuj+G2RYX9AsnTYJD8MgrsaSJS8H52A+OKqeyaxWI5mne5N2oh1vf
JN9cdSTsA3jeLz/yMiQojsqLLO44rQlHcUukGtDBeIH84H40/rbtt15ZhH167si8
M2zB90UAdcw/UHZrDXaKQZpHmnJ2FYVehZzggXn1eCfoBRGEwUX5FbAcQrlMJNGo
6icZHpxcfVAPXbYo6ntS0uQGGIh3kOwj8iX3A51gm9Odklfh6g7q75GOxDeDBmpV
pf7WskounYrmczLjDOXID3oKm1tsmurHcjbHRYuawiMlsSZ/W4MyN97ZBm33NePK
ZYwoanjurcw=
=YB8D
-----END PGP SIGNATURE-----

--=-erL/svVGXbtqdEGdeImx--


--===============7772651003453113100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7772651003453113100==--
