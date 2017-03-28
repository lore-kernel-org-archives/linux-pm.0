From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v19 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Wed, 29 Mar 2017 10:04:52 +1100
Message-ID: <8737dx6m0b.fsf@notabene.neil.brown.name>
References: <cover.1487578977.git.baolin.wang@linaro.org> <87zih3m73h.fsf@notabene.neil.brown.name> <CAMz4ku+98HAgVnMoCg0YaPpcY1NvdKdbK6AuDyzgNOrcbpaz9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43217 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752735AbdC1XFK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Mar 2017 19:05:10 -0400
In-Reply-To: <CAMz4ku+98HAgVnMoCg0YaPpcY1NvdKdbK6AuDyzgNOrcbpaz9A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>

--=-=-=
Content-Type: text/plain

On Tue, Mar 07 2017, Baolin Wang wrote:

> On 3 March 2017 at 10:23, NeilBrown <neilb@suse.com> wrote:
>
>>
>> I understand your reluctance to change drivers that you cannot test.
>> An alternative it do change all the
>>   atomic_notifier_call_chain(.*notifier,
>> calls that don't pass a pointer to vbus_draw to pass NULL, and to
>> declare the passing of NULL to be deprecated (so hopefully people won't
>> use it in new code).
>> Then any notification callback that expects a current can just ignore
>> calls where the pointer is NULL.
>
> I am afraid if it is enough to send out vbus draw information from USB
> phy driver, for example you will miss super speed (900mA), which need
> get the speed information from gadget driver.

When the gadget driver determines that 900mA is available, it calls
usb_phy_set_power() which calls the ->set_power() method on the usb_phy.
The usb_phy the uses the notifier to inform all interested parties
that 900mA is available.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlja7BQACgkQOeye3VZi
gbme6A//Ruqhqy3i01mHlovGUKt6vS//Cw2N2zIOFth0niZp9j0maP1cm3TH2ujk
RGBxKzZrHG2Ve441Kq1X4zTFjKitbcgiEvO891m+RdHA0QPTWTa9avQyoFil4sKO
FeSFhYRedrzwfPNrdG3FFJUb0lW0L2oTnCe17OV9S1WOOb8ZSv9YPu45qxSsqin/
SY22/t1CQqB6xnxtiWnog7UiXDJU/JkYy5ZAsgfuhZXxvO6KXF3z7bsaHePvy0PJ
AlD3fkvPa+Sx0Zyi1gxvLPFZTt62F2DSGfqpshdXKwbhdAQuErNeFHAmokmFGkC8
TDk6THGjn+pgDIyNtNK7raZmf8RhSOgJJ7jJMoEED11u/E4MCac6q+DHbMgYVjPN
ez+F+Sb5oQ2yNeta2BvnOWxqHrIFbMBmF7Iubkq8q8ByRWdhhO79SjcD8EGr+cYF
C4frU45pxPd8ByYX+xvbg3170DJciPefzMyA/txPudDx9+m6ehkx5DD5WjTyMrMA
yOZAnV3FGKCJlxa6gUtloKF/zZmwksJap13QBzzI585kQ2uCKZfp/g/Jcxot1jWb
Yx3+IfiWwrW24LvfPIzsShepZwFrJSW10guYhhPhBFnuywzkBEneKDzMyQggCybw
LM2/PV+cAzwOj7UMNkFIrdvihb4gohOC0YMxw0qOaWGxjCUluk4=
=REEV
-----END PGP SIGNATURE-----
--=-=-=--
