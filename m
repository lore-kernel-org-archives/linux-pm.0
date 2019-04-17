Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64D5C282DA
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 02:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F5321872
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 02:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555554916;
	bh=203PGqkiMAQefNYkpwCiFuUgdtjTUnJG+JSFfO7pzYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s/XTf96/zdYpT1CPN3lnZk3Udhi9Kcvj4WVt+Sb9YmBEbv49n0UwGgZRT1haK2OUB
	 /Yj12sdMG7McoP3GrzVCvsdejwqZJd5zIYaDwlNaKTHmW1I8usmh8Tt2mk/vlkynwS
	 mRI4jFzXVNOqemOUR2D07eucsHmP24ztiwrommhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbfDRCfQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Apr 2019 22:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732737AbfDRCfP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Apr 2019 22:35:15 -0400
Received: from earth.universe (dyndsl-037-138-087-229.ewe-ip-backbone.de [37.138.87.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6DC02184B;
        Thu, 18 Apr 2019 02:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555554914;
        bh=203PGqkiMAQefNYkpwCiFuUgdtjTUnJG+JSFfO7pzYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afaU2Ad1ysF5PzB9RukZioTfy+mcL1d3wehevOXdGX/hzyzJvSkm+Cqidp5DpJaHP
         Vrwh2TiifjyBwtUQUushT8KwKKiltQ/hcDNxxziEqPeT1LlntbS4IUOKPnzubulMzt
         NlBKPqOhWyuPJZFmcvF8qAo2lM8ZYWXAxk7++sSo=
Received: by earth.universe (Postfix, from userid 1000)
        id 897573C08DB; Wed, 17 Apr 2019 23:33:39 +0200 (CEST)
Date:   Wed, 17 Apr 2019 23:33:39 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/2] fix leaked of_node references in drivers/power
Message-ID: <20190417213339.dcfie6ufix4udnb4@earth.universe>
References: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzrgbwwcfimkcmbu"
Content-Disposition: inline
In-Reply-To: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190417213339.3RnhmuyRopaCuYOWAMGSXXa3KjpgUqqjITyqLdGv6EA@z>


--vzrgbwwcfimkcmbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 17, 2019 at 10:43:01AM +0800, Wen Yang wrote:
> The call to of_get_cpu_node/of_find_compatible_node/of_parse_phandle...
> returns a node pointer with refcount incremented thus it must be
> explicitly decremented after the last usage.
>=20
> We developed a coccinelle SmPL to detect drivers/power code and
> found some issues.
> This patch series fixes those issues.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> Wen Yang (2):
>   power: supply: fix leaked of_node refs in ab8500_bm_of_probe
>   power: supply: fix leaked of_node refs in
>     power_supply_get_battery_info
>=20
>  drivers/power/supply/ab8500_bmdata.c     |  1 +
>  drivers/power/supply/power_supply_core.c | 24 ++++++++++++++++--------
>  2 files changed, 17 insertions(+), 8 deletions(-)

Thanks, queued.

-- Sebastian

--vzrgbwwcfimkcmbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly3m7MACgkQ2O7X88g7
+poPjg/+L8blp16+dARwSFccWIVeweTaBD1RP61hvO58sYDQ/ia+dy+TTzFFhQy8
rmNO/NvpHrJT+bdD5er2Qt1vJ8GE87H+v6l6jMB+p92P5/YAAj32MFDPJZvsQsZU
SDrEkcIO/mRLSu0r2Dr7odIq9hQya06a/P2Mx26QSOw+wv5vyzbI+CFjkDjA8YQt
rYKQ0YA62yKF8R8PlncnIWRjQDlzYlE0NGGP/FpDyMzrxQTYKWeK14LfpJDTcJYn
Q+jVwrSBVhcYvIErXdn0HcEHPEHH3RJatmTkh+rzh8JULz6ZxQdhW0uQl6RQZQTK
0IMHcXc3XCl5J6XhBIwBBb7y/A5Wr1JsCfB4L0yCOvV+8nkiDiEZSYc1lS75NflG
Xkn/TZG5gIco9nAzrZ4eonwPeUFCFwJNwUSE6cCdcfJr5KK1pQAiNo7AaRzMcy6P
XN9wExf52y4EsqOvHBOl/CqzSW92WLXBLdPRt33428Z2O9ggcE2RUoH3GiCmzirH
SXKDrwMJV+z9lWBCjhCaIg+eOqlEg+mtDxflH30DNn1cHz1zMZ6WYdCBeRKzBE/Z
YHVeBPqxWLFjbQmxFcVtknpXFaqSD0oedqujtq13NHQx6NY5RmttIIAEJq+XkPgY
GCi8VTs/J59RZdttY0NyKRm+j4vdDOcodQoTT4TP88Xh4pyKHRw=
=k6Zl
-----END PGP SIGNATURE-----

--vzrgbwwcfimkcmbu--
