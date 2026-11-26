Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727873;
	b=XqFPDGbpIgKTr2h6d1rquv+7UHPuTcNe90eF7j47bOEsxd+jUob11tkKqCGnf6ZXzNqe
	 /Iw0NakOjOU1BypFl1Y1G3eWLNYyzODiXJGSb4+UEWSPMIeOUyy+U7EtvSOhQE3iv7DCi
	 GoQHmn6h3HKrZCB9AkkUc4iKzA4ISF3+DzDrE2/zt0SSyllie9ZN3kJSHaFguRNNtFVwi
	 tx/M+SE6oFfgFyvNPgwVcoxG8R1mNryrOyCpaiiwaqWjj0r8MDzJA4dt3xXke5m3Hks0C
	 4CHyneCrQs/wy0PQP7ESuW0SdebUVoWHD1U7uvZMbZqdVPysyw8YP7Yu3VlEpMrsjOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727873;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=gN2XDNegO1EaVvcRRYCrugnJruYcbJVxCnaIB303O6E=;
	b=LSLBRj7ctUgoPizRMgqWslNaoUpqCfUHgVT4bjchnoUKOo8w3kzNqMkJG4vrbdxHloHi
	 1dgv+/k5ShekdJ4ZOR1QYh9xsu2tm4ivIBpCpKrfsa1UkqsdFdkxc7uI6lW8NQNwDk7Ur
	 EWHuG8y6FMhf9bHRhE/S/MBlTBRAf1IgUt1+TVAnF8K/HiNDH3uaiC5bIgXkVRkgdCvjB
	 +43FN7QQmpGs0z/8+Isv+TcVUeq8bQrwgznmBo17F1LUXzFZ7dKP6JMt7KdUXIgVTSwUy
	 CEaWL+KoVHsXzQCxn++s+FSLQ1xqYw6wb9MO5YmgFF6DnIKzYm8juvgfV+jY/WIjjgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nmuX7w8f;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70361606A31C;
	Thu, 26 Nov 2026 21:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70361606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nmuX7w8f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795727873; x=1827263873;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XB88xni1EX2fIeNGWIw6yOZSQAn5vLw9/RUjEeoJ3/g=;
  b=nmuX7w8fa/65PkYsSY76Hg+H3Dz+fUxmqp+4hdA5Gy1QjXDd+F6l57aa
   j/W7UL00OXPBCQxDnRJ5wtC8ZLTpl59FUOEH8xxTv0fVsndbWSlFPA0jW
   BVZfMKKoblvmeM/7UI8us43CIaqQKvGAJSUwKAYv1QITRSX1ySN5sGdbY
   ICfl5NzUNLqAcTzcHgnK6ASDvSocdYOQitS8lqO9ALAq+q6PmiX0DgC/S
   j2wOCtlUjJLW0pUFwJinUBpl5U5tH4effgMwsMllZ+8tDpiCwLmr7Tsty
   bvOneCvc1CDslfG/laKruAHO+Gxa5hA64Cs7F+522yDooZY1ztoDhb0Zx
   A==;
X-CSE-ConnectionGUID: ZQORvdtPQD2ZgogS3CMCLQ==
X-CSE-MsgGUID: cWc47RfKRjGsQRuQHRrkYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4659271"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4659271"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 13:17:52 -0800
X-CSE-ConnectionGUID: Bpx7luiwSiGuvM+axbZzoA==
X-CSE-MsgGUID: IR1zQp5VQcm8H6+jxG635A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12282093"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 13:17:52 -0800
Received: from [10.245.245.29] (abityuts-desk1.ger.corp.intel.com [10.245.245.29])
	by linux.intel.com (Postfix) with ESMTP id 9505420B8CD1;
	Thu, 26 Nov 2026 13:17:48 -0800 (PST)
Message-ID: <3659d5f94d83b71df4040f8516000e9be9a9c1b5.camel@linux.intel.com>
Subject: Re: [PATCH v1 3/3] intel_idle: Allow ACPI _CST to be preferred to
 ACPI _LPI
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Zhang Rui
 <rui.zhang@intel.com>,  Len Brown <lenb@kernel.org>
Date: Thu, 26 Nov 2026 23:17:46 +0200
In-Reply-To: <2080993.usQuhbGJ8B@rafael.j.wysocki>
References: <3986546.kQq0lBPeGt@rafael.j.wysocki>
	 <2080993.usQuhbGJ8B@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

All patches look good to me, there is only doc nitpicks below.

Reviewed-by: Artem Bityutskiy <artem.bityutskiy@intel.com>

So my nitpick is to make it crystal clear this option is not about
never trying _LPI, it is about trying _CST first (reversing the
default).

On Wed, 2026-11-25 at 15:20 +0100, Rafael J. Wysocki wrote:
> +``prefer_cst`` - When using ACPI, prefer idle states coming from ``_CST`=
` to
> +idle states coming from ``_LPI`` (which is preferred by default).

``prefer_cst`` - When using ACPI, try ``_CST`` first and fall back to
``_LPI`` only if ``_CST`` does not provide usable idle states (by
default, ``_LPI`` is tried first and ``_CST`` is the fallback).

> +
>  The value of the ``states_off`` module parameter (0 by default) represen=
ts a
>  list of idle states to be disabled by default in the form of a bitmask.
> =20
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index fc0aea26db50..3c07469586f7 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1779,6 +1779,10 @@ static bool no_native __read_mostly; /* No effect =
if no_acpi is set. */
>  module_param_named(no_native, no_native, bool, 0444);
>  MODULE_PARM_DESC(no_native, "Ignore cpu specific (native) idle states in=
 lieu of ACPI idle states");
> =20
> +static bool prefer_cst __read_mostly; /* No effect if no_acpi is set. */
> +module_param(prefer_cst, bool, 0444);
> +MODULE_PARM_DESC(prefer_cst, "Prefer ACPI _CST idle states to ACPI _LPI =
idle states");

May be even something like this

MODULE_PARM_DESC(prefer_cst, "Try ACPI _CST before ACPI _LPI (default:=C2=
=A0"
                             "_LPI first)");

But this is very minor, your call.

Artem.
