Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B824DFF9
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137900; cv=pass; b=aRflInP8Bke5clxCUtLMOqVVa8GSXVF3AmICRQJOlxzmUrqsJPLOfUHOVgzkXOoJ6sZCN6ZlaTjY6TtoLu3rgM4nIMHmaMCj27t9zj8kH9kq5vKZfYn0wdTutgG6+tDAbpPEsfyezkeYYe0uNJLggah6C2E5kdDiNWPeFEEWL0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137900; c=relaxed/simple;
	bh=QqX0Zrjug1bJp0t0oCshX16WdnE9Qnbbsw6UDy3OYg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdnVY1xwpLYcDehyNrRn0CWXzKYNtes6UvuFbhHR+Ar6SXsZtpZ8f3nVzalox6KjH7rw68ubWyQHokE64bzZXRR91P2sqcd4pr0Que4qL0/iWAfwF/pH7IDmpOsfTm20wNqwgjw46e0C/hhSRvOQvgVJngGJ5JCygtariJtN4AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kvVlv/AH; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvVlv/AH"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a88a79eb3bso65e87.0
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779137897; cv=none;
        d=google.com; s=arc-20240605;
        b=VA1cOhQiuYWe4eZS59Er2eYovITihfcATR/HYAZJ3W/S68AF07vnfaoPATAwimYyMo
         sjRPuUz2YGV9yeJ0GyPFMYc3dD+OGb/I+NeuOGEC1tYgFlLou2K34ypKjibh3SUFX1+2
         ogGe1x9bdTbZPoxvtd3zEDqKgk3HCvkaCob2toUkhDu4+ckhofPBSDE7r6DtCLLSAozP
         +qF82PFvvyq4dd8gPZCOe0JHCcC+ULEqmwXmCoEiBHqDJZjzPwum2H632keCve9kpl4p
         FK0Li1XjYcl734IqPbh8pFdD4h/cqfF1gqEAKbc5DFztQxKvfTX909e0vW97o6O6t7oi
         yahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DQw4Q7u9z6JH0ttDjJPGH3TaUM9vt5YijBwRcpdTRuQ=;
        fh=xYxOn+5BF84ewD9a/yWpd6v6q3TR82V5edIEy+RWh0U=;
        b=RRQcd59GSMqZpkFSIVeaf/jOzGz2JeOOQXfq5CXr9IP4MqgoK2VSPwZN1mCfiv5mVw
         VfkvVxRjhVw728zyMY6bgl2S/7/jvujnbk2ELtx7GQ45A0A8d7zF20JckxzfRILLR3XR
         dP3yhE4ogs0XxTP/BsnZORdkXuafQbo3/xUC4wIMWp8z6JPG/4wig+vikBCjqoL66AvK
         w/txeU3oxt9g9A0Q/Aav8F+psZI3y4srso5Itcu0sc/pAcuzhbJjP6migAu0waWCDCnC
         gbt0LkejirFqjQdXMjXJt60S7a9kzrEWdfgbNSisjF1+gOzDuJiAcO+5JjsG5SvN8qzM
         we0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779137897; x=1779742697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DQw4Q7u9z6JH0ttDjJPGH3TaUM9vt5YijBwRcpdTRuQ=;
        b=kvVlv/AHioea9SiztCm0F5MeejErpq7JyvL1wygvh0vnrMWSySaAoRjUPi+rpiPbb6
         yazgrbQOsLMu5QCmyr8ZfyLrxgN5qaQ2zFjWibxiVZOH02wWz/Hvtk1JZaNt9oh8C2fl
         1YEOfeHYYUrDJMWURyZhC1VXjh/8Gf/1+BiCRJONkACu3ClZ/+euNMr+VZWGYrLWtkVz
         a5JAN/lM6p40BOu1IEQ4DMWkCCxWVPw332yJPQgAhCFJaH1jSuxeCTLCP3G/O/sqKF8s
         BaniRJ1uuyVWQVHSUvMTleRxPg7w5K+QDcM5hwk8/MU6/xbzWjgmaXX8kSf/g6oogHQl
         a40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779137897; x=1779742697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQw4Q7u9z6JH0ttDjJPGH3TaUM9vt5YijBwRcpdTRuQ=;
        b=GSu1gCVaIVzEP5tk9KEqEG0MTjqH8yM7eViEDKpgnlRKiJPlTpIAQGa0B0xtIhzp1A
         6GMeiW4/Mc4YJpnEBqJ5jomGsGnblGs6JzNFcOfw6fwQogTeX5T3lxFToa5kw/klPEC/
         09g3v5En1XL3NFwL2ljiRoAvcWEjBj6uYREoyZ4Ed7c03AApsLFU1PafMUzkjiv9XS2B
         OLxPa7E3BCBAM6HZNXL6Mq0UngRsm9RrA9yKEuEoub6zuk9i2YMANYAsXwZEOjgHdIWR
         ufXoKNoGcKJbSj4DhFWOCLSTzfGDOl4uCfhDyxRiRxVJVMY0ESxXn7TOrBWjNarMQS/W
         DxUw==
X-Forwarded-Encrypted: i=1; AFNElJ/SPxr0V9Fltce2Nl3XSBdcEXCvasTp+TFaU1Ke15J2APTyxPOYtfcj88BFzBF2iTytFy9HWkbPBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHGl//OXgjnocHntNrHbDqB/Y4jI/xMibS8MooAKtwSrBR3nv8
	M0HlluIge6X503+c/BNJtkEvVCekykkcHkOZ+rjptN52j9+33VIi60OMf0m9tphiU5lAWnc7eLc
	0/SbovT2JEyhDmPxlc2vzEzUcI2zhRCyOEyvhvWwm
X-Gm-Gg: Acq92OH6Cao5a7ywL5gEVEfQ8f9UWBEYgckEJCfviqUVlA/WkRw1jEbxj26a+G+6JVS
	GmvY3L3/9MhswiAHaQe9yCp1YHDk+cmGCUfVR8SXo45Qc3fp+pmlLqkNCRtjRRDNjYiD4+w6v52
	0MJMW9a+6x/sbV/1MV0JCN7ZRsvjDd3CZaF23CydjDOoV/fzukt4UiIWVQ4BKIRQqxYaUhirwMz
	8HenbCuLKFqEoiz58ANMMdBqrFKZHQGAocJ+nukPdh12vukCroSf6rsG/TBgBTvZVe2sBTgHlk8
	3ZHyfWEWRo0j5X3N71/HXJhbghc/4IgIAT3R0MeBPcSM18FN5pv912ZJRKc=
X-Received: by 2002:a05:6512:1411:b0:5a8:f956:2165 with SMTP id
 2adb3069b0e04-5aa19760399mr303483e87.3.1779137896870; Mon, 18 May 2026
 13:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
 <20260518111546.3baebae99dc3f2a4fd65e605@linux-foundation.org>
 <DIM2YAI5ORUU.2YLTV7PWKE516@google.com> <20260518134811.b2b78352779d7519e8123597@linux-foundation.org>
In-Reply-To: <20260518134811.b2b78352779d7519e8123597@linux-foundation.org>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 18 May 2026 13:58:04 -0700
X-Gm-Features: AVHnY4LeFdfqzho9peVK4kr5pn7PGlIoXj7eLUcc0p7X1r3-MMiC-29QI5sc158
Message-ID: <CA+i-1C1THr6fH=wdTKEngbCSD_DMS5tGroN64BEf3L56DH2XWA@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm: misc cleanups from __GFP_UNMAPPED series
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 May 2026 at 13:48, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 18 May 2026 20:20:50 +0000 Brendan Jackman <jackmanb@google.com> wrote:
>
> > On Mon May 18, 2026 at 6:15 PM UTC, Andrew Morton wrote:
> > > On Wed, 13 May 2026 12:35:12 +0000 Brendan Jackman <jackmanb@google.com> wrote:
> > >
> > >> In v2 of the __GFP_UNMAPPED series [0], we realised that some of the patches
> > >> could potentially be merged as independent cleanups.
> > >>
> > >> These are all independent of one another, if you think some are useful
> > >> cleanups and others are pointless churn, it should be fine to just pick
> > >> whatever subset you prefer.
> > >>
> > >> No functional change intended.
> > >
> > > Thanks, Brendan.  I added this to mm.git's mm-new branch for testing,
> > > along with a note that [4/4] may be getting an update arising from
> > > Vlastimil's feedback.
> >
> > Cool thanks, (also I got the "added to mm-new branch notification" and
> > realised why I missed it last time, broken mail filter).
> >
> > The 4/4 update is already up, in reply to the thread.
>
> Is that "mm/page_alloc: tidy up pindex helpers"?
>
> For some reason I didn't receive that email, directly or via any
> mailing list.  I do have the similar "mm/page_alloc: remove ifdefs from
> pindex helpers" from May 13.

Ooh, that's unfortunate... I used git-send-email directl to send that,
which is not how I work most of the time, so I suspect something went
wrong with that particular setup. Will keep an eye on that.

> Oh well, please check tomorrow's mm.git and send along whatever is
> needed?

Ack, thanks again.
