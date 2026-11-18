Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017377;
	b=xzEp+PEOKlDbqxnGa0GQnXxJ4buuVECeVCGRtS1XKi/FXoRGn3dcbeNrcwYlGHx0djgV
	 qdI8SJXctvDAhWpvaJwDGtMqXIvoDOFwN2xQNbqsGTDb4a3AkFr3B8cYsiEEL15As3MNc
	 2ykwfNok60LrHG9YWTDdhKrikTJDDfXLBQ2qRVwymKJE2856J+gchmqCu62VRYdR3+8es
	 3AZKfVoxiCT6dvZ+squmdRR33JFQa7ASRVHCmq9BKHWo8cw/TjXEdz1MHGYExFDNl4Vkr
	 6yGHspn4ztVnbSBhVZZJ/Jf8PDWYo/dl7iXvmngeZxFXh5dZ717Ji57jN13mHKSgnlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=3bQBfuPo4+GA4H58G8tofWZlnWMcm4hxNRzjXZBoZg0=;
	b=INmaajSyFNQVSl3OtAsxmcReKXNbF4ql4oYlOzDmsTRuMIYkMqz6i5ZZH9Xpjjlh3i3F
	 klBSjevHvQdhf3BQr+M0ENCEQtyoEGuOm4qO62ejr7CzkZCtmrA9N3giNU2akVjjw1EFs
	 s8Qd7qlU0gK3XdzHUtDiOY0Piqb2DVJhbZhkVc3rzVMvSYQCvoWvuaMRSCwMgyunX8RuK
	 rC2tSc+pq9B0NX4guigURgoeMm4PvMXMUvp5LdEdFLeQImPlUjKqJc3j7lf1ZW0eDqJBM
	 M5hA8pQCMPOyIOOwKo9QGuK1/P56azQt+3LGnQiTQD3NKu5PUFkZtSaFy2etluiujuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=gFIxxdDt;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCE606A31C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 15:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8BCE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=gFIxxdDt
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ebf4cd218so4361906d6.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 07:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795017376; x=1795622176; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3bQBfuPo4+GA4H58G8tofWZlnWMcm4hxNRzjXZBoZg0=;
        b=gFIxxdDtcqDrBFkqgwEzkN+bVHfcVbrm/mKFYHBw/aX+aK3i6yXT3iOHNNcy/dVpjR
         beX1ypC799ntnSOEXoyuWI9KAiYigmUzM2ktWAUGq14UH6bdfs19Po3EeuhNmuPBICwQ
         4fygV7vNlH+8kA4gHVrwCXXCMRXtK3og0Bhew+zJDF8jtO9O5fvmBFacfYtyQB0ZICfH
         uto7MDRpcWiyf9+vJZQn3ZyabRKAjiAEnbjmVD+LqH03jEVrnsuMJqNm4PPeRi2PD0kM
         0m9hgfLivrz1Z3dH1OiBWSOIUeexNiv0u7ws6tg5Gw4PB2Xal1+xCiI4FGHOyO/4c+dY
         QURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017376; x=1795622176;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3bQBfuPo4+GA4H58G8tofWZlnWMcm4hxNRzjXZBoZg0=;
        b=yU4zjiYujvwN8henRRNfoi0zZFKjeDWo/eWNyzWZhx2W/nY3Ki8U9E9mn4b25FIRCS
         uB/RPF3Vn9t64nBekzc4WO7qwGXFuQL2YPy3JkgN3OM+wj+hBvRsxuUwm1cfCHsmVYsz
         bdTF7pH8qWFfsThFQegGaqV62CoLuPk7JR8IQWmfBbk/T2vteAJFgVHhpEUSj5Jn7++Y
         stwBTiW8oiUwByVwMHouLdzcyqQK9wxZjquWdwPuR3T+91LSJRF7IRMfYebIIcab9aB/
         +KQe7CCz5fKTDM4NrRJmXX3IZhiS+F+0Nd7NuxHnwiqSIvCnWyV1+Ey0Pe4jMyh+iLRR
         MDWg==
X-Forwarded-Encrypted: i=1; AL+hErGonl2wVzOrIRc8ndGcSiL/8mK4VM1t2HePTPe+UZzueibrvTyIx0TZcuCW4ZyVl+wDQd72elIoxQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ft8DDkysWdzos1nCHqrq3/qnS8hfQFfB5t5Gb4AKPvttTeL3E
	RDbARXDB5dAl/17+An8Y9+gDQFbwMywT2ZzlDyr7tUODDOBpREBy82qzmccoWd9mE6Q=
X-Gm-Gg: AZFdTZfg1pG0g7YXPdxhQPtpNIFzWv7e03WGfZ1GYvcnJnYaE/Cr7kCCREoKe6NayKv
	Ccemilr3X/7v+6sw/20qedGt+SkLyOLrIqGJUtc0xHhro5utKfuftd5xb2aOrYivSCe2upF9HTK
	CnczhpHuo81EtA8gHC6KzmM6czN58wrAK3URdqYj/7w7Mlzv9r3J2uriUcI9t7APqD6+F6u8tWD
	2qILnpKvrqv/lrWFfHNv30nGn+EsHQ0tdFYRSCWg9sbDItrJcaCVFZv42qUHjr1Er4qOG5oups2
	xgBF1hrNpIoHxPoQ/fsK2Xa04LGdct8f9vWpdFRwgZON65L8ww0xbsd2P4+nHkZI+2/1dXmQHAd
	dIQynYMxT3IL/V6zPrrpfdGZYaY97zu4Xfy/UmhiFopF+hbFgXdFRECBYZECe4ZzEGLOGkeLo1X
	kSUeIDI9Beqk19UoI1dXCNn0j9uMmbYIzs42x3P4iluTGAotCrNFfL6ilh5iisukjdsFyJhBQDh
	kDJxhcgc2Id3NyRevvo3YfJ6nU/0guRXs25PQP361lk6cDPt8kgskcZICB6ntXCzw2cdIKAXLoK
	lDtbOx7822mv76A550lXGQJNyDf+h2qgCQGmSQESaUWBZ4y7oCSdzW20KPF8/FB8pSYY28VNtnk
	FFG6cAaOYx8G2/sIJgWnAfV0VneTA
X-Received: by 2002:a05:6214:8013:b0:921:1890:b77f with SMTP id 6a1803df08f44-9211890b87emr29798426d6.47.1795017375668;
        Wed, 18 Nov 2026 07:56:15 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d28215sm24719106d6.16.2026.11.18.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:56:15 -0800 (PST)
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
Subject: Re: [PATCH 05/22] mm/mempolicy: keep interleave and tmpfs mount
 policies on common memory
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
In-Reply-To: <av3EGWuHX2JDdlrx@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-6-gourry@gourry.net> <av3EGWuHX2JDdlrx@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:56:13 -0500
Message-Id: <179501737390.1206716.11014097946405277594.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 23:30 +0800, Richard Cheng wrote:
> On Sat, Nov 14, 2026 at 02:09:42AM +0800, Gregory Price (Meta) wrote:
> > -	for_each_online_node(nid) {
> > -		if (!node_state(nid, N_MEMORY))
> > -			continue;
> > -
> > +	for_each_node_state(nid, N_MEMORY_COMMON) {
> 
> Maybe I overlooked or somehow, but when do we have the assumption
> that common memory is definitely onlined ?
> 

For this particular case it's not particularly relevant.

This code only runs at init time, so it's either got memory or it
doesn't.  If the memory is present but offline, it still wants weights.

There isn't really a bug here, but the existing code could also just
check N_MEMORY and end up with the same result.  If the memory is
hotplugged later, it still gets weights accordingly.

-- 
~Gregory

