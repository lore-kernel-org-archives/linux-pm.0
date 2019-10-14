Return-Path: <SRS0=aKUx=YH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8573CC4CECE
	for <linux-pm@archiver.kernel.org>; Mon, 14 Oct 2019 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58845217D9
	for <linux-pm@archiver.kernel.org>; Mon, 14 Oct 2019 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571088408;
	bh=97b+Ocsgom3Agcv96ynPkQWIElTx9Ch7SgrVF4OtMeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HaLTEfw5xpXI0dPLux11Ctlrv9Fx50+o/bhs++hTM0syhgdhHeIhil36o01IM9HQF
	 A/lY9elU5vTUwXbSieuIwsJ1YdULFY2qowy7H5QrHrwSAxyYzWXev2UBw5gkYs7KrT
	 4DtuekcCN1MP0eEYuZ/4x3FgaqAjUWnfPoNL3L5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbfJNV0r (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 14 Oct 2019 17:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731991AbfJNV0r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Oct 2019 17:26:47 -0400
Received: from earth.universe (eth-west-pareq2-46-193-2-41.wb.wifirst.net [46.193.2.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7538217D9;
        Mon, 14 Oct 2019 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571088406;
        bh=97b+Ocsgom3Agcv96ynPkQWIElTx9Ch7SgrVF4OtMeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3d+/FtNQFGm71sVZJKpIC2VU4vLJaBQuvaVNYumwPycihEkn8vGgztbTEQOJ4xGt
         RXcS6ZjEDsN/2p3fopcyUTLlT0ElWlGje5MUAcNKFTcYXfEuFys390jbzitAWFreMM
         7NHZi+fsPimAeF9MYR84P6WSTs0CDMKW/5oV/jQM=
Received: by earth.universe (Postfix, from userid 1000)
        id E06B23C0CA8; Mon, 14 Oct 2019 08:58:42 +0200 (CEST)
Date:   Mon, 14 Oct 2019 08:58:42 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
        madhuparnabhowmik03@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH 4/4] Driver: Power: Supply:
 abx500_chargalg: Fixed a few coding style errors
Message-ID: <20191014065842.p6kbrl3saeerpoqq@earth.universe>
References: <20190929181906.GA21828@madhuparna-HP-Notebook>
 <20190930082303.GC2036553@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vrcgjslnq7boh62v"
Content-Disposition: inline
In-Reply-To: <20190930082303.GC2036553@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vrcgjslnq7boh62v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 30, 2019 at 10:23:03AM +0200, Greg KH wrote:
> On Sun, Sep 29, 2019 at 11:49:10PM +0530, Madhuparna Bhowmik wrote:
> > This patch fixes a few coding style errors and warnings
> > detected by checkpatch.pl:
> >=20
> > WARNING: please, no space before tabs
> > ERROR: code indent should use tabs where possible
> > WARNING: please, no spaces at the start of a line
> > WARNING: Unnecessary parentheses
> > WARNING: Block comments use a trailing */ on a separate line
> > WARNING: Prefer 'long' over 'long int' as the int is unnecessary
>=20
> I know for the subsystems I maintain, I would require this to be broken
> up into "one logical change per patch" so be aware that this might also
> need to be done here too.

Same applies for the power-supply subsystem. Thanks,

-- Sebastian

--vrcgjslnq7boh62v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2kHJoACgkQ2O7X88g7
+pplvRAAptW5X7yRvo35QlYXnBrm9vX1rJaBzSpGAJUrtz5Az3ljCw1d3oLCD4US
IiY/i6BM95z6nclfIcRdNt85Z3sRguUJGfR82e/7cQmWLxG2ij/FJF/Q+sqJt+Ci
USuLwdRZ9J0MCXWmOiwjywGe71HP93h5XWjmRze+udQBexfOEeOGEJe3JXQF9cGo
qUuG4M9MQVZyuqHwnrFHzu8g76ChzOf/3i3Qd6PVxe/ZBzLCAG7jAC4Vo2oT3ZEq
DcIX49Hfl1gHalkRaKQwt6Omf5eoiJ+81s/enF0QshlY7v1TwYMHbSCIcHEGfQFS
G/X3dE4CN8YzhkxAWMMF798mP5JLuEMDCPqd5Y7LzFhPk+yJC2R3Qg6e3o/zWX+Y
T32EkApD3NVXwGia359shD7WYor+NarmhKtPXwT89t3XgXCIEwfpJAlvRIzLGz6x
utnrtYCLuGEVmj/SrmX6DmbJNx9M8wVs1CQvhNpIy2E0MsX9rKQbhNMY3ZhfzsYa
yZp+MM3lpGarork1IXqa3tw4Wl7bNw7Je+9xVfhg1quN2CTRvJRb6Y6QN+vsQ7YT
JjcB15PspBgksbpBX06FBVREN6VovXZIFzuEs7sRzJMfyRrzDPwh4PptqhGC9H+q
9jIDHSVIQA0sAXHFFr8JGGuShop3XORaNX8SqQPtmsIEXj34Ous=
=L6kU
-----END PGP SIGNATURE-----

--vrcgjslnq7boh62v--
