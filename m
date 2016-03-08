From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2] thermal: consistently use int for trip temp
Date: Tue, 8 Mar 2016 13:09:02 -0800
Message-ID: <20160308210900.GB8145@localhost.localdomain>
References: <1456997626-28298-1-git-send-email-wni@nvidia.com>
 <56DD3A84.4080304@nvidia.com>
 <56DE45F7.6060307@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35151 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbcCHVJH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 16:09:07 -0500
Content-Disposition: inline
In-Reply-To: <56DE45F7.6060307@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Mar 08, 2016 at 11:24:39AM +0800, Wei Ni wrote:
>=20
>=20
> On 2016=E5=B9=B403=E6=9C=8807=E6=97=A5 16:23, Wei Ni wrote:
> > There had a build error in previous patch.
> > Fixed it in this version.
> > Please review it.
>=20
> Add CC: linux-pm@vger.kernel.org
>=20
> >=20
> > Thanks.
> > Wei.
> >=20
> > On 2016=E5=B9=B403=E6=9C=8803=E6=97=A5 17:33, Wei Ni wrote:
> >> The commit 17e8351a7739 consistently use int for temperature,
> >> however it missed a few in trip temperature and thermal_core.
> >>
> >> In current codes, the trip->temperature used "unsigned long"
> >> and zone->temperature used"int", if the temperature is negative
> >> value, it will get wrong result when compare temperature with
> >> trip temperature.
> >>
> >> This patch can fix it.
> >>
> >> Signed-off-by: Wei Ni <wni@nvidia.com>

Rui are you collecting this one?

Acked-by: Eduardo Valentin <edubezval@gmail.com>

