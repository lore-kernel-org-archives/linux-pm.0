From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 2/2] Thermal: don't check resource with
 devm_ioremap_resource
Date: Thu, 16 May 2013 05:46:19 -0300
Message-ID: <20130516084618.GB2342@localhost>
References: <1368670581-4846-1-git-send-email-rui.zhang@intel.com>
 <1368670581-4846-2-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58079 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788Ab3EPIqY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2013 04:46:24 -0400
Content-Disposition: inline
In-Reply-To: <1368670581-4846-2-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, Vincenzo Frascino <vincenzo.frascino@st.com>

On Thu, May 16, 2013 at 10:16:21AM +0800, Zhang Rui wrote:
> devm_ioremap_resource does sanity checks on the given resource.
> No need to duplicate this in the driver.
>=20
> CC: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> CC: Vincenzo Frascino <vincenzo.frascino@st.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Thanks,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
