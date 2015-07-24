From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 0/8] Add support for additional bq27xxx devices
Date: Fri, 24 Jul 2015 10:57:49 -0500
Message-ID: <55B2607D.9010602@ti.com>
References: <1437601920-13045-1-git-send-email-afd@ti.com> <20150723162748.GJ29125@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37751 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbbGXP6T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 11:58:19 -0400
In-Reply-To: <20150723162748.GJ29125@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/23/2015 11:27 AM, Pali Roh=C3=A1r wrote:
> On Wednesday 22 July 2015 16:51:52 Andrew F. Davis wrote:
>> This series adds support for several additional bq27xxx devices and=20
>> makes a few related fixes.
>>
>=20
> Thanks for some cleanup of bq27xxx battery driver! Did you tested you=
r
> patches? On which devices (with which bq chips)?
>=20

I have verified basic functionality on the bq27421, bq27425, bq27441,
bq27520, bq27530, and the bq27531.

Thanks,
Andrew
