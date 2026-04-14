Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15023EFD1A
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187976; cv=pass; b=rmJ4MPdNkcJsepFSUgyR+5RlkIo03nsIlZGuADTpTo8d97GfksCQWV62BKYNA5wZg0Psx8rqkqhIvcm4p+8aLDuR1QOMKa6HKZu48QimolM8xQkYia4aRYCnbJ2O3gIlbxpWt7+zYjYF9DoLCMa0MYyqsIt/S3lGOnE1C/JLLaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187976; c=relaxed/simple;
	bh=c8VROB7nPEHNUyRB5MclbcMkN39zlz8ADjK6buJJwrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoY+ch8S4IAz0Vi6td98u5eQ2ohQcqUsa9vrv5LI7L6MWWGr6iU+EXFzo1F7Zqbywv2vUiOW9ervoY31VJ5YN1OZRwTORYrX4aAXdg8gDOgN5+j2iY0F2/3aAbitfa936vqZ44wTXr6GStUcMqmLxgUR0CfyMZH8o4W3I2vqhHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX10aqTN; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX10aqTN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so47523765e9.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 10:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776187973; cv=none;
        d=google.com; s=arc-20240605;
        b=lua8B85E4otGkL4GHKDd7o4I0oQpfMptsEgSVPl1RVt79fybU77+YrijdhYPO9LhHT
         Gk7Qg7oheDepSzlgI+p0Vi3IRC75fiydYy42TmNPJZqel82mK6/L5xS9Ai3x/KGW9g0A
         mB36T57K1d+dcTnQOaM0aADspW0mTLmJlv6rRo4+lRpIl4ZXFam9w3OiQggZAOm5F6OE
         5Lv4yYINV83jM96zTxgw5J5CCyDbDn46q5Thi5U+5e6M4GrixxmSxjjFRZpcBTA0oIF4
         m3XoH7fW8+No6kjI9juDM0nN0/9Q/LDvnGZI6GdlNnhsYl7xi/6NK1t74dMtfh5XWf7O
         K8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c8VROB7nPEHNUyRB5MclbcMkN39zlz8ADjK6buJJwrg=;
        fh=w2HeudzTqyBe/cpL09QFp2WtggcHAkHFAIxYuGJiigk=;
        b=llSdrzXuEr8rGAuKM/FRsrXt7oACnGWCqGbm63wzveLjb5bK5pznuOLBahmU0AHtLx
         +L9Xm26DYS212pySpVOk6LtjW6v95MqgoiZnunt9zqTcxQPOZUcLyzmu4MiR8gMRoaqc
         /p0cSBhfUp8iolEHQkbNAMM0+bBUMjmBLCApb4EobSRO6TgA8kgpp7/sQVSNjgHxlck5
         GHlVhxlbRIkg7m9+FiRGBzMP1drh9MXtTkJ9PVFa9RdRVrfYrTNqROXudujAHFdwHy2P
         YENsVeFWmfMNyTabDOAwYXq/K7OGHXRlntiomKchYG7yuihq3WAe5e+ojY7Tumn97e90
         KbPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776187973; x=1776792773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8VROB7nPEHNUyRB5MclbcMkN39zlz8ADjK6buJJwrg=;
        b=ZX10aqTN6ueyUDSbjhQxBmYCk+6Qh4RbTFKz6qsoVLZ8XXsN0jMCDoVnjk71jKY2is
         GKgIWSzeaYIPOPqiw8qIfwjP7sVd9qedkfhH5Mva6wk5h7nNaNywd1n3HqEsv34tqhoH
         I8hwJhRvdVYtqNpl/gR1ddpVQqOCtsgP0183AFph3MBF4afg+LoFr3ZpSX5DLKimtoyF
         mCEtFU+t8IDjK7In/U7uTxNDiIndapshHTqfCe/dn+zyWu4veJEXYT0Yu2MQK90BeV3b
         IDhR902SJ6cgHedCu4VOcexxfkw0KCXyYs0CfxieXZxftaZiOjUomdtveXRhB9JgTMT0
         DiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776187973; x=1776792773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8VROB7nPEHNUyRB5MclbcMkN39zlz8ADjK6buJJwrg=;
        b=Fzs3yDWdZ64GdgRteDnvhx+PAeJfvFs704/jmuZe0i0bJQJvL2fQW15NwmYgc/EQ5v
         QCRbsfG8JydNWjkI6rCvEhVLBMTxjl1FGV42JviyPOabTSqrj2nBu8O9k/zS0s7h5XuI
         ss3GoQuJswKkhNB1H8dCJ902NfBWCvsNmfboV5p/3ptS31PLgZ+Gjf9t6nZMjotK76vd
         0nZ6fkmMc4nxneALDgItELlKfIxhd0tQi7MSLJt3TJOzKa+Pvfh5l1vV/MAacGS5mbek
         lrd1aVm/wrUPPvUk77GRThkPAMSWKw66CGxwUQMxuI6XDk8q2rS5nIT5eDncRQzVgC09
         c4rg==
X-Forwarded-Encrypted: i=1; AFNElJ/xm0lEPVHFfutDn301W+hUoh7bxhoD/NFJTPMqOnctRshmJwugIQDnSg8+594LTtjSjstRZMJ0+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxdDQG7VvaYyZZSPleiaa8l64IAf5GSN/Efw6v32nvuF6DtGxF
	Rj1a/iBwInr19xos2PzcuVYolMnwJrws0DaQ8EDGmibVmmXIo2lr6lkFbaqLUGi3pw4s+duNVrE
	LWtOTnSVBKKHa7nu+OevKeAZDe+DIevg=
X-Gm-Gg: AeBDiesxY/aWDwvKG5oVn+goK/YIGWeS8q+8c/nGvuJkObtexK9FXnP4/SYaiNNliLy
	dtedKa04hic7X9K9M4K0HmpJ/FjdV/BYnisEeBqmMBfga+vFfV85tXW4MjJZArfBONvmGIYSmkX
	GThuw4hHA3sOnYO82GjOLBKeMYxhKc9vCUxhMkbN4bLqROO/0DHDanil+nSO4q0yxcrOK1DVYQs
	Tp0RBPh2n5HTK9CFnrlRceHBhFncAHUx4+57s695whAR0rhfm1F+u4GY3V1Zgf/i2j/xQFMENBM
	Kk77Z6SJ3ibYSebdqDDRQAPl3ZT3erdT8zeURwE=
X-Received: by 2002:a05:6000:1ac5:b0:43b:3d02:7806 with SMTP id
 ffacd0b85a97d-43d642c852cmr27633427f8f.28.1776187972920; Tue, 14 Apr 2026
 10:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
 <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com>
 <CAMgjq7AzySv801qDxfc8mEkEsFDv4P=_qw0rNOTe0n+qy7Fz6A@mail.gmail.com>
 <CAKEwX=P4syV38jAVCWq198r2OHXXc=xA-fx1dk6+qYef6yzxWQ@mail.gmail.com> <CAKEwX=NrUhUrAFx+8BYJEfaVKpCm-H9JhBzYSrqOQb-NW7QRug@mail.gmail.com>
In-Reply-To: <CAKEwX=NrUhUrAFx+8BYJEfaVKpCm-H9JhBzYSrqOQb-NW7QRug@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 14 Apr 2026 10:32:40 -0700
X-Gm-Features: AQROBzCXAeCqcScOKrvPHFEfL-AEpSgsJNqZGDJveRabXpX0aHvntrnXQgowKrw
Message-ID: <CAKEwX=O4VJzHGqJFnXOyUhamr5-hckrd+C=V8+f-Lz_HNtaJ_A@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 10:23=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> * I still think there's a good chance we can *significantly* close the
> gap overall between a design with virtual swap and a design without.
> It's a bit premature to commit to a vswap-optional route (which to be
> completely honest I'm still not confident is possible to satisfy all
> of our requirements).

And to further note - these benchmark measure, in effect, purely swap
overhead. In a production environment with a lot of non-swap work, as
long as the gap is close enough I think we would be fine, even for a
hostile case like a fast swapfile-backend (I assume SSD swap's
bottleneck will be the IO mostly).

I will stare at your responses to see if there is other benchmark I
can play with, but it would be very helpful if you can share your full
suite :)
