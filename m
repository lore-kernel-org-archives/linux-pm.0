Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388E4348C6E
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528480; cv=none; b=ul9Y6uuxIDdDEEW/fSOGEjkY5l841x87XcMRaZav2/3FVyjD0ekBE4Vo8pkU/O7SImcqdVnJILc7h/ifY+NSH2Ik0s3Hcyrg7OM0Q1Z+BMft2CGENXDfGDw055utQdIEZBGwDk1TIrj/bT0r389e+EGgNBBTek6FvdFMgJpp/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528480; c=relaxed/simple;
	bh=Vd2aaOv6oGFpPp+DD+qyW0/U3Nl95FJOumcz4tnIosQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kn6x7eHwNsKSZbFNsJFNi/RKM/vEfNEqE+Xhz2DL6GRmqnjdOb1jY9S1ytwwalZpuqWstC+358TCIj/UyrWRNSCCchjr6TzA0ZpHJvj3Jat5BNe9xtHVjPlGgEDzwsUPGj2sIJxhQBsIQbehfHwfQfraOkUVllgwqUDtbNXZ8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1wu5fJ-0002sx-7q; Wed, 12 Aug 2026 11:54:29 +0200
Message-ID: <cf29d49d-cdab-4bd9-857c-495076333e77@pengutronix.de>
Date: Wed, 12 Aug 2026 11:54:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: pmdomain: imx8m[p]-blk-ctrl: resume hangs when waking from
 suspended state
To: Advait Dhamorikar <advaitd@mechasystems.com>, linux-pm@vger.kernel.org,
 imx@lists.linux.dev
Cc: s.hauer@pengutronix.de, Frank.Li@nxp.com, linux-kernel@vger.kernel.org,
 ulfh@kernel.org, kernel@pengutronix.de, bhushan.shah@machinesoul.in,
 festevam@gmail.com, xu.yang_2@nxp.com
References: <CAAPs2HTo=4+AEw1+vcU6c9vt_O2BfF+gv3FFvx9G3KLLzCOsHw@mail.gmail.com>
 <CAAPs2HQcHpDGqhiBXSLOKmXWGevmWbGO3UtfV1pmoiF+wC6aLg@mail.gmail.com>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <CAAPs2HQcHpDGqhiBXSLOKmXWGevmWbGO3UtfV1pmoiF+wC6aLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi,

On 7/22/26 8:10 AM, Advait Dhamorikar wrote:
> Another observation I have is that if I disable the MIPI-CSI related
> nodes(MIPI-CSI, ISP, ISI), HDMI and VPU nodes from the DTS, or else
> unbind their respective drivers before suspending, the suspend
> wake sequence works just fine.
> 
> Could this indicate that the issue is related to the media clocks or the PHY
> during the suspend/resume sequence?

That might be useful info. Assuming there's a dependency that's not correctly
represented; You need to turn on power domain X (or its reset or its clock or w/e),
before power domain Y, otherwise power domain Y hangs, it would be a good next step
to find out which power domain X is the one that if you leave powered on during suspend
doesn't cause the hang.

I expect that if you take the imx8mp-blk-ctrl driver and stick an return -EBUSY into
imx8mp_blk_ctrl_power_off(), you should be able to suspend/resume cleanly (with all
DT nodes enabled and drivers normally bound).

Afterwards, you can bisect the power domains to hopefully find a particular power
domain that if skipped lets you suspend without hang. With that information,
maybe a better solution can be found.

(I am interested to hear if I am missing an easier way to do such a bisect!)

Cheers,
Ahmad


> 
> Best Regards,
> Advait
> 
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |

