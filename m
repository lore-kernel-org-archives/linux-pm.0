Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639846;
	b=gQg4Ty93f0eOxgtjxBklRkEuO+z2kBDzC6ezsEp5i7DHlA5SXBewCmbquX9TsUWlWIxm
	 GSGt/nrgXe8AAmJ6skZ8fmUX7ANsqUqnyq0NRxf7MYfWszb2GoLULhu1UWV8MRRpid6Ad
	 Gs4I6WvH5Sju1n6j0qS6fOTe2OXLp8jKPWVelG0Gxx+USCdNNIzx9g4/JGW+HwbO0fhee
	 KQJJ6AAd0VEC51pRRpVyf5Kvf0aylJ61J5SJQtvWmxgXqFQuPqDUMwRc9b7quM9JpbNIM
	 1AALM2M7p6Sv7sXrrTY1j6+rb4e+MBlFuMsGVF10rD5wYx1BP5Yw2djWLb5WSKEfoiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639846;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=J6Dot723Q5bLhqFgH8TTsJpVPW/PfBXIh5g2n9QcYps=;
	b=tMffLW6N7CkDkGyjAKqFzBeveof/S+lKtnoy+QWXOQ7LiBQKtRyXh2rIAFkNTOWq0iri
	 n/Vl4KCGpGM9dD2yhnlQGR25NAPZlpzCeBmk1hD/NET3+XeoB2uiyBJ0Xzgky4R1f7z1K
	 IEwV92FNJw1w48y+BRNvmizFr5mTWW6sgEj/B+Vg9K7NEeZKtwvZmdVPJ2QM+sXSCvOlF
	 qX9uMwefu1WBPWxaNc89d9H4F3ub2qzAx7H93bXGPNCzPZfuawFltGucXXtA+eElqQdjZ
	 TrPXflsZCaEMkgiFvPA7m3wvBRxO5IZev8LwGt5aoiKdtiyNpFIpa0mfi5phGv4eNfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=324cVDnO;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8EA606B0DF;
	Mon,  2 Nov 2026 17:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A8EA606B0DF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=324cVDnO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=J6Dot723Q5bLhqFgH8TTsJpVPW/PfBXIh5g2n9QcYps=; b=324cVDnOT+KyqnxWd8iuHe06X+
	CGuCIp9PsIy4Ebsm/8ISVpS6lxgHyuO+o5CjkMozZx+WwcsbW7PElbwnCIyeLxBUP+T+/zuUDgJWW
	bC04VBlbMk/OIjaLgbgNtKcWPhxOjk7gT45sL4hp6MuRYwnYrSWFVlvY6OjeDoZ7256GANAI3rPtg
	LQa1gVI7+Dl1PifFM2EVs2rKAVaboQBO/Jz2VVUvfVSH/4lOGndh/w+XfL1GWeIGeAjP8SqhVj+PA
	aMFpfllwNQvScAyR3pfZBtXkFjORzEZ3yMh3WlV7z6JOt5NMzn0xxI7LwNBY3kdPPtgJEs+FwjvTl
	ziTIYe4w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNvet-0000000HQGi-3VUu;
	Mon, 02 Nov 2026 17:17:23 +0000
Message-ID: <4d80567f-ecdc-4dcc-aff9-4645df4d3ea0@infradead.org>
Date: Mon, 2 Nov 2026 09:17:22 -0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PM: Add shutdown=legacy command line option
To: Mario Limonciello <superm1@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>
Cc: Denis Benato <benato.denis96@gmail.com>,
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, Bartu Alev <bartualev@gmail.com>
References: <20261102-superm1-s4-at-s5-v1-0-313e0012dd39@kernel.org>
 <20261102-superm1-s4-at-s5-v1-2-313e0012dd39@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261102-superm1-s4-at-s5-v1-2-313e0012dd39@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/26 5:54 AM, Mario Limonciello wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0b3c140babd94..16d584bdbb73d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6981,6 +6981,10 @@ Kernel parameters
>  	shapers=	[NET]
>  			Maximal number of shapers.
>  
> +	shutdown=legacy [KNL]
> +			Use the legacy device shutdown callbacks when powering off
> +			the system instead of the hibernation power-off callbacks.
> +
>  	show_lapic=	[APIC,X86] Advanced Programmable Interrupt Controller
>  			Limit apic dumping. The parameter defines the maximal
>  			number of local apics being dumped. Also it is possible

Alphabetical order, please. I.e., add shutdown= after show_lapic=.

-- 
~Randy

