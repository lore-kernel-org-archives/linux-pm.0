Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015260;
	b=NRpFuYa9Ice0dU997DQ+sXucClupyv4nYXLijCgCuzAUKBoQqC4HGJCxcofqU++Wg3g/
	 zWEh+o13Gc67roaNuSKlyVgf6x3XV4XeBP+4RFqF5jUHH1TcjnC6VkstrOJMsWDZxTt51
	 qVf6/0GCDr+Jqli7/1HYm+1tDL8hjyHPT1iB4usImjI1EaFAgJOqZ7umPwfTGfQqtttSo
	 clULqWxH83J6g51PbMkvpQOsKWrb/CTeBrZSB9N1wR8JUmNWcnSYkQAV3ftCCk4SHAZrh
	 JSlW9H9ATPIIPe7DwHOSHb0++CzVlVnRRwuiPS/yFIFicRXW9Pfnt+BavqNaF3o+Nag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=2f1/3qPELFtVfaXBFluo86ffYBKVD1HppO+tx/i4yJA=;
	b=C93SNAx3j7QjPqEQzWYRz5rfCHKzpvRK9dbivudoYUBKqa3CrM+jD5D88fMpUFO/rUVQ
	 QuExhdwLT+0A14qIADGFI8DpD81+MQepkOcqR+2f9K444WphLVX/X/+zWi8en0A284HI2
	 gXxaxTq6fcgXHpd+kRxj10GrWxr+r2SvQVT+2aFbwf7osEDfjIiMtu8G76Uyip6OVzEu5
	 GhPPRYNHVRhsDKxlQdm/HeMHGxol+kdLo1pUmSLYfoBNizza/M+oSokY796kcf+kJbxQl
	 JiC125u/SSFAy0rIt9h3LsK+8KsZTUMI7cV2lcDX9zfplgeUKBeZIXHA+Qd76OBn4cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=RcYjlh9r;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB4E60A2602
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 15:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB4E60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=RcYjlh9r
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5361e313e63so12184921cf.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 07:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795015259; x=1795620059; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2f1/3qPELFtVfaXBFluo86ffYBKVD1HppO+tx/i4yJA=;
        b=RcYjlh9r4IRGrafd+j2HLcUekeO369jG4cJ8dDVzoBY8gvpxzJeyqK3ozNZlwuaNe+
         dX9eTN+iN1SLvDXv6ZqfqHOE77V1vdoVQpS9x5MRrqE0S7mvRfL6sw/ErTChduS84etH
         nS7jQ1GGdAXlIAaPdld5HxgPrnOoIx1uTeL6PFILkkDVhQvjQ1L/cdSpt//oQ3Sg56BU
         7DACo0lblGCgiebYjG3dsltULlbJRKP6YYtH3AIXL4Ytr8g/kCuFnCukKTYSpuqs6WLs
         H7LrxeAzRj7uQcJe5AdxVin1iIq0eKGTVLMXmX4R0D0sv+hVEZxbt0IeTxFEciavpACF
         rBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015259; x=1795620059;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2f1/3qPELFtVfaXBFluo86ffYBKVD1HppO+tx/i4yJA=;
        b=QseUQTKyrPClNPAvXVjoHNhsq1RSkiJbs1GygJ0aJ8VSdDs3mHbb0zAYk2jrLv/Yf8
         zSDV3dvAaHbmcgsZ1aPGUxkO+ArdoydKjenhbjDuy+gLskDy1gBPoUluCkdc4LW1ioRg
         NmR6jd5AYhPMz6dWGqFtoPS3ElaqCueYIDSDggcbchsnAhn6rWddWNaWZc/ZgdnYe3t5
         7D4OX41CDKZTvLiM+CxejeUiWfqnqWALZa3UUXn4Y5KCp0kCvr1TFfDZ0uYiMbxQLKBB
         Zzgd+/XEg/ZL/jgpFCT8kENQO0pWHlNnxCj44dU7xESTqg2JU7AuMJp6vSAp+VQEKWn4
         J68w==
X-Forwarded-Encrypted: i=1; AL+hErE7jzhD60mq6cYJdWNU0GxveUL+0pkSo01J5YE28+BmqnXuy51jPbAhiqGgUOJv6RLTX2SnRAQ0yA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9LzXxNcs7L0iiprQh0XSbEMMlyIHsGMBWzisupz9+WI+AuhJEc
	RESoYdLsu2simndK374tTWlsX/1/qwur1SVyOQ3D410ROoAEaVrcY0N1EfVe4tgAafg=
X-Gm-Gg: AYBFou3TNILNDfu2DqEZJc/ghjo2slpt6OMa8ukLCEHUTaAUL6Wfhs5q5bxJw7IIySo
	nHQKktjsct5wy9qjApjpf3C4ak1bzaRv6mYuT1VjVpwl5MFqvh8dxKxI+4dcr3S/8dcSD2hyKrK
	lfxhdJHEXAc8rRSGHePd5jkNUdXA4rLku28K4S5vzEGH9VdzScf6ekAw31cfPWNnXlRIJhg63Kg
	Wb5eizh2vnYZ9xlHJDZg4u1R3ktNEKs1xoW0yaA/Loq7SlAU4AdMc3HRFYMtws4jCXqTXhsZGEY
	PEd5SmW6t/hmHCFtseeggi4vsxB0on/i+m2Ux9ME0bisp0tQEKHRaa73w6WQThCUO2/vNVMUFFf
	mQgoV9V93jtSzrnPyUwBPmx+PfiA42m9+zDaUF1eYY0RLRw1WF+qX35X7MExqO0mAncbMCMLhD9
	k+WPJsw/40mPkFsikyPZUirVGpoTzeeWkU2JystiAFH8H0v3xGcX0tBrP49qMiU/rvvUAm47Q1g
	l0wI8T3BiXnd3t8SnGwsWEwEY6fHV/VNJlFM46ddQbBKRAa2hcoqV0JmqnS0k0vlnbO59j9bzR9
	KJF8OyV/7edenBLPLTIvyG8JwHiM33PUNO4BYHCDpWtEhPcuaSVuBPhxVB+YVfStP/ZbRwmN056
	euUhFsnQ=
X-Received: by 2002:a05:622a:a0a:b0:55c:66f0:5bf0 with SMTP id d75a77b69052e-55d5a656766mr42047121cf.39.1795015258621;
        Wed, 18 Nov 2026 07:20:58 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921167f4725sm19632976d6.44.2026.11.18.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:20:58 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/22] mm: publish and clear node memory states via
 helpers
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, 
 damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
 david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
 skhan@linuxfoundation.org, rdunlap@infradead.org, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <av1ZBTpLpJC6DJqA@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-3-gourry@gourry.net> <av1ZBTpLpJC6DJqA@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:20:56 -0500
Message-Id: <179501525661.1206716.17622543796948053737.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 15:53 +0800, Richard Cheng wrote:
> >  	/*
> > -	 * Check whether we are adding normal memory to the node for the first
> > -	 * time.
> > +	 * Publish this node's memory states, including any newly-normal zone.
> > +	 * Hotplug never adds highmem.
> >  	 */
> > -	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
> > -		node_set_state(nid, N_NORMAL_MEMORY);
> > +	node_set_memory_state(nid, false, zone_idx(zone) <= ZONE_NORMAL);
> > 
> 
> Um, so I am not sure how much cache pressure this will add, I assume it's small ?
> 
> Just want to point out that the old code only wrote these bits for a node's first
> memory. THis now does up to 3 set_bit() calls on node_states[] for every onlined block.
> The result is the same, but node_states[] is __read_mostly. A test-before-set in the helper
> would keep the old behavior, or if you would like to keep it, please address in commit message.
>

Hotplug isn't on a particular hot path, but I can test N_MEMORY before
setting any new state and just early-out.  That would keep the behavior.

-- 
~Gregory

