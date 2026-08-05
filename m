Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD7476694
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938014; cv=none; b=UuiYKRboRE+2nstzvVktKHcuMle5AuJX6uF6VJdArUfMts7r6apCBTKMEFBtJq7L36o80U8RCq7yH1eqiz28s4qILpDoNEUghhlMhxaAKTFivBVivdK2NI0JDejybThSEXNcDp1HG7tDG8zYaAc9PXiMeN1feX685GY0YP/6FZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938014; c=relaxed/simple;
	bh=0uN32aL02N8IHX342QsiVYT8zP7gnajakKpV4FQn6K0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YsofGzPCSaAhyS30Hr5cIJln7kBNSkrUqMSxM1X0Cq1EkfldvamnhyvlmGOlBex1BEP/a7xMOeMZ91Q4HJPb+UI6mdLVCaf1i/Hg/yBAWDKUS9buUBYIUwjCGmZ49pB/lYJnl0TmtmgpLPykOIgAoJ9ALpFFB93hSCAP9lEWMmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgLKUDR/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgLKUDR/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785938012; x=1817474012;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0uN32aL02N8IHX342QsiVYT8zP7gnajakKpV4FQn6K0=;
  b=IgLKUDR/VNRifuG2tmpeUAJAeGCkWzS1SLBc9lmDdY8xrID2ezVJ3yv2
   DhAVsN+C+Duwt+ZFk7P+v+qGfvNfcaK9mFkESo0Xi45KM23pKbzp7ECRa
   JrLiDIgNA05xibiv2Q0s/ui5aNivmyWV8Z8LtqXbPpEphuPIje+xoEJR6
   O+9rTArYBVdFRX6TPHswKsbDIQ5cdDUna7irrE3grGiIQ5e7DnWVwLMuL
   J7PAYyA1jmTR//beAJZGKqWzmm0Ym1QPYsZ2VYEhHzJpGWtolxnNMkCix
   YPx95+UMpT/SBRf27/bkSlmoeCcG3iGcYYPyXtDei1tD83IECVP5T1yMt
   w==;
X-CSE-ConnectionGUID: yH6G0la7Q0eTqXrqD5835Q==
X-CSE-MsgGUID: NhgzgSj+TBurBNFNPTqiag==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="103914425"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="103914425"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 06:53:31 -0700
X-CSE-ConnectionGUID: fU99kfmtTtO6n+CMEl4l/w==
X-CSE-MsgGUID: vfGnwn2hRcaqNs2g5DKtNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265311940"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 06:53:29 -0700
Received: from [10.245.244.28] (abityuts-desk1.ger.corp.intel.com [10.245.244.28])
	by linux.intel.com (Postfix) with ESMTP id BB1D920BF398;
	Wed,  5 Aug 2026 06:53:27 -0700 (PDT)
Message-ID: <194df922f197e738bf19e86be4e4ecd25c141f74.camel@linux.intel.com>
Subject: Re: Bug Report: intel_idle: no model entry for Wildcat Lake, falls
 back to ACPI _CST
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Karan Shukla <karzshukla@gmail.com>, linux-pm@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org
Date: Wed, 05 Aug 2026 16:53:26 +0300
In-Reply-To: <CABoscT+MDv1=LRnogCanDfF33KLmMs3ah5n4A8OA=F8E7nprCQ@mail.gmail.com>
References: 
	<CABoscT+MDv1=LRnogCanDfF33KLmMs3ah5n4A8OA=F8E7nprCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Wed, 2026-08-05 at 09:31 -0400, Karan Shukla wrote:
> Hi,
>=20
> In this case I was able to determine that intel_idle has no entry for Wil=
dcat Lake, though Panther Lake was added earlier this year.

Just historical context:

I submitted Panther Lake patches.

I did not measure Wildcat Lake (WCL), only Panther Lake (PTL). Yes,
we=C2=A0internally discussed to just use Pather Lake (PTL) values, but we
figured there may be differences in firmware, and I was not
comfortable=C2=A0using PTL values for WCL without measuring them.


Artem.
