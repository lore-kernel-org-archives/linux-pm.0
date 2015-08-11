From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] bq2415x_charger: Allow to load and use driver even if
 notify device is not registered yet
Date: Tue, 11 Aug 2015 13:23:43 +0200
Message-ID: <20150811112343.GA1461@pali>
References: <1437860816-14141-1-git-send-email-pali.rohar@gmail.com>
 <20150805132652.GB26280@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34144 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933945AbbHKLXt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 07:23:49 -0400
Content-Disposition: inline
In-Reply-To: <20150805132652.GB26280@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 05 August 2015 15:26:52 Pali Roh=C3=A1r wrote:
> On Saturday 25 July 2015 23:46:56 Pali Roh=C3=A1r wrote:
> > -	if (psy !=3D bq->notify_psy)
> > -		return NOTIFY_OK;
> > +	/* Ignore event if it was not send by notify_node/notify_device *=
/
> > +	if (bq->notify_node) {
> > +		if (psy->dev.parent &&
> > +		    psy->dev.parent->of_node !=3D bq->notify_node)
> > +			return NOTIFY_OK;
>=20
> There is missing branch for case when psy->dev.parent is NULL. Logica=
l
> error... I will send new version of patch.
>=20
> Correct logic should be: ignore psy dev which sent event if it is not
> notify dev specified in board/DT config of bq2415x psy dev.
>=20

=46ixed in v2.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
