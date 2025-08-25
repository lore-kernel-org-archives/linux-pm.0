Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CD2DBF69
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119887; cv=none; b=lJ/EbasFBBtLSKednsO8iwaiUeNyoH3510/f9h4BIXsizcwkbocVJVwUUIPEf/WhhnF5ekd3sDunnsvcyjGUTBqam4xVi+Pdk26K/vfPcLGFFmJlb957u+gBA2jduE9MWI2tFyA5OvPdCCjySTbk3kc1YHDiRxLY9S8R9Mg70YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119887; c=relaxed/simple;
	bh=zdepxPLDYhP9sUy3eZsgH8Hj7cHsRuqB5ovHNUzTfns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6MMADZPDQUqDspsqv2/1PPZPq4inD6dvxBCidIkUoQHEHkfrrHsPLtUwCy7WsuzbfzDrmeWZGttGn3Kn1IRBxTtrny4SNInFSGQZkpNEZIUIpxs3b4n9we2kM35Um67LTwB+CoRMtkTjoxp75KCwQEKJuNY4Am8Vh/+2HnpmTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D8FBB61E64852;
	Mon, 25 Aug 2025 13:04:19 +0200 (CEST)
Message-ID: <9ba4a892-f67a-4e18-a9a4-4aee777261bd@molgen.mpg.de>
Date: Mon, 25 Aug 2025 13:04:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pkg%pcX values do not add up to 100
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Zha Qipeng <qipeng.zha@intel.com>, Len Brown <lenb@kernel.org>,
 linux-pm@vger.kernel.org
References: <774d9a96-0120-4009-8fd7-78387267b194@molgen.mpg.de>
 <20250825105509.GQ476609@black.igk.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250825105509.GQ476609@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Mika,


Am 25.08.25 um 12:55 schrieb Mika Westerberg:

> I'm not an expert here but if some of the CPUs are not in any of the power
> saving states then they should not be counted.

So there is some kind of Pkg pc*1*(?) state, and that is where the 
missing percents are spent in?


Kind regards,

Paul
