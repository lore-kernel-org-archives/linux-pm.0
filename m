From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 0/3] X-Power AXP288 PMIC Fuel Gauge Driver
Date: Thu, 5 Mar 2015 07:57:03 +0000
Message-ID: <20150305075703.GC29183@x1>
References: <cover.1423082056.git.todd.e.brandt@linux.intel.com>
 <20150305003013.GA1033@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:44789 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350AbbCEH5I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2015 02:57:08 -0500
Received: by wesk11 with SMTP id k11so51166107wes.11
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2015 23:57:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150305003013.GA1033@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Todd Brandt <todd.e.brandt@linux.intel.com>

On Thu, 05 Mar 2015, Sebastian Reichel wrote:

> Hi,
>=20
> On Wed, Feb 04, 2015 at 04:24:35PM -0800, Todd Brandt wrote:
> > New power_supply driver at driver/power which interfaces with the
> > axp20x mfd driver as a cell. Provides battery info, monitors for
> > changes, and generates alerts on temperature and capacity issues
> >=20
> > Sebestian, please review the patch set and consider it for 3.20 rc1=
=2E
> > I've applied it over git.infradead.org/battery-2.6.git/master and
> > verified that it works. Thanks.
>=20
> Lee, are you ok with patches 1+2 going through power supply
> subsystem?

Yeah, go for it.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
