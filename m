Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521F28BA95
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771221978; cv=none; b=iwrSJsPulVJH1VXkiQkCZa7Oaycg6wVdFoSX8PJkLu2UQ1Bef+Kc68e5TEg+Y6Tc5dnPbkJ24CS/CCNVFCd7bHqC+y9U4kvkMK45m4UMTugQdN40rudMiHznku4DYBBHoDb1eYHtOAnw1KdJuM1+FZClCrQIGJkAaY18fSEul0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771221978; c=relaxed/simple;
	bh=4YmefSX0GwRR0tYsar7+DiwN/P8tBU7V/nz8QCE6CBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUjmpqF0cokuK4a4GzEPZklwPCjgg+kwfA6l7k68KwqFKW8fWjDGT1OmG8nWXcyShJKDV5DIYyQEHXr6HOEp0kEIVksS4XSbnnKzs6K+shkjQ/EvuqsG6DewAbEPa8tu9PbiMqfNlx8huHvwkTGXjLVe3tvbXwN8gxR8NL3fIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOyCHyyi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOyCHyyi"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a9296b3926so18633075ad.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 22:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771221976; x=1771826776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+1+2hICCHy9jpCc/dQXjjfX/dwmXFH+Uwwb20tfSQEQ=;
        b=WOyCHyyiuBQim8CjPJTuOULXbDHyKLR+v4PmezkoeeYzB4nYzJU4XthXIEnuVnV6YR
         2HMDk4fn5/GNiXoQDVdY+dsJR32T0tCd4nnRTUTZGapaj1Wbe6+5ujZkgnb96KtPead1
         5uSZuU5rJJ6PQIYqgIRwMSYGpflsE10LcIg/Wn8vvvgGFE8SsoMJiDI4aBibZYUup1Ju
         JEnBz82Bt9QYEZF+tE8csICogr6Mfe8zhFWDLiezBKdDVl/MHE6PPgs94KWs+lELuKrQ
         8mneu6JOqBiuu2rgevfBinzsCgKIFajpIRpYm3lQKGrPX91FAf3IKJW7fLKf1DXtAATH
         XJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771221976; x=1771826776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1+2hICCHy9jpCc/dQXjjfX/dwmXFH+Uwwb20tfSQEQ=;
        b=CGdc9OmE7lOphPOay52qjDjGryKClSgJaExh922DWxP94pieeSJxZBNhohNXvvFxd0
         FTDBVFze/0iYTdO1ahg4E4ffkoJDK0V6Kt8R7bcKtV/x+lgyzxkGplbVYeuxsG4HajyC
         lFbcsUzh5ntJeXvzoSvRHF4YPgFYP2zkcNAF2R/yIB+qE/lms6kDMn/RChoSGo8Zttnp
         EdatechWySiDKSAi6OOsmhJD75TpMBJXtRr6q9QiPOaBv5yuOkOyJzw1xw5Dd/oZb5wD
         VsVeFrf8WiqHcE2DcECFvifileTgrLWs6KMykAQXjeaE1PtAXq2PAZl0u4hOYiowalE9
         pOgg==
X-Forwarded-Encrypted: i=1; AJvYcCVf7bYsbMXAdSM3UFPitnJ6DGTonBXGLOiff5oD6q9qZh8phTaCl0PAEgLDIkF1Bem1WsKSYqHxvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcG3LGvL9Uptl6z1YhpTzesozS3F9B/YOHxzxcIiAlnckM/qwz
	UovOfnvgDoM7IEoZETAc3BnTTxiODIJto3339Ht/lNshHXZXtH23edzU
X-Gm-Gg: AZuq6aLhVstk+Nv4ckPAgLeSk7zF1g5hmP7cNaSdwOCuujvz+iI/Kyw5OsXisxLYNI9
	vqD3atoYSjv8l97cHTcqmScDK6Q7yDAB15IMoeOhPl7QCWLG8JD/0sCtZ+bfGe3NwKIj31g6rX1
	1F4tcmi2anyuX45ew1LKbk3txG5LCBQUxNhx545+N51b3vIzvzA5BAF+RPcnELkiwvVOZYBZng9
	nKGiDOnIQa7BbcYnazLsxTcR8OUJqNIPAaO6/y80LIcNUyoTn6YxluSHXsJ2PkWYl0mC3ABmAK5
	ua5bbjvgOTSUPwZkG8uRNmOoZhWC50VioyQ5ZbNdQcqo5LdXiR5rFGv873XxZfiSKYlIi7zL6Nq
	s2cRJsh84n4RNc6EjMIW+RkUmOlhWAygqgU/s53qqz5zDxoNUKBxzxMSZJSBlBLkqISF3Ol7yDk
	GvUrqd8WaJDyV1eDB33JTpzeMHBs8/dIkHJkbRWMUsI0bG9XU92M+N5Nc9fnvGUcSBcRjMXw==
X-Received: by 2002:a17:903:247:b0:2a9:634d:de98 with SMTP id d9443c01a7336-2ab5055e59dmr101213855ad.23.1771221976325;
        Sun, 15 Feb 2026 22:06:16 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aadd47csm57750265ad.65.2026.02.15.22.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 22:06:15 -0800 (PST)
Date: Mon, 16 Feb 2026 14:06:09 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Barry Song <21cnbao@gmail.com>
Cc: kasong@tencent.com, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Carsten Grohmann <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
	Carsten Grohmann <carstengrohmann@gmx.de>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm, swap: speed up hibernation allocation and
 writeout
Message-ID: <aZKzUoZLp_3lK1s2@KASONG-MC4>
References: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com>
 <20260216-hibernate-perf-v3-1-74e025091145@tencent.com>
 <CAGsJ_4zTCnL-bYN+nMXJEDPqHtF3hgiyHwyCoTc+nb-t6wouRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zTCnL-bYN+nMXJEDPqHtF3hgiyHwyCoTc+nb-t6wouRg@mail.gmail.com>

On Mon, Feb 16, 2026 at 04:43:40AM +0800, Barry Song wrote:
> > @@ -1937,11 +1938,21 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
> >         if (get_swap_device_info(si)) {
> >                 if (si->flags & SWP_WRITEOK) {
> >                         /*
> > -                        * Grab the local lock to be compliant
> > -                        * with swap table allocation.
> > +                        * Try the local cluster first if it matches the device. If
> > +                        * not, try grab a new cluster and override local cluster.
> >                          */
> >                         local_lock(&percpu_swap_cluster.lock);
> > -                       offset = cluster_alloc_swap_entry(si, NULL);
> > +                       pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
> > +                       pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
> > +                       if (pcp_si == si && pcp_offset) {
> > +                               ci = swap_cluster_lock(si, pcp_offset);
> > +                               if (cluster_is_usable(ci, 0))
> > +                                       offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
> > +                               else
> > +                                       swap_cluster_unlock(ci);
> > +                       }
> > +                       if (!offset)
> 
> I assume you mean SWAP_ENTRY_INVALID? Would that be more readable?

Yes, it's very common in swapfile.c to check !offset since
SWAP_ENTRY_INVALID is zero. But I agree checking SWAP_ENTRY_INVALID
is more readable and maintainable, I'll change to SWAP_ENTRY_INVALID,
also use this macro more in further codes.

Thanks!
