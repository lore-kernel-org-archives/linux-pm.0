Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CC615A86D
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777856673; cv=none; b=I5wmDrQprYiWwPzBkH/nunyJgs1c+wlJkUxlJJlqqNidulyxpiF4mShQhvltP/eV89GyDCp/UVgLiNoQsjBk7gKWyefH8inwd6dsXe2x4c/q92dRma174Azo6QgukVpZdYFo0f9m6gIYkjZLkleYaXsL5lqlSycvC3ybVo0Awys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777856673; c=relaxed/simple;
	bh=VOImGagwUv6VjbT83gC82BU3DmJGdg7wni+ROUxXYTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c686jB029AYeJ9asrkHaiJObslSryjSaBjBGW7NJyjBw1wuhm34ittcaaRKKMi9RCFJ4ZO7x9xmGFHwJt1M4RLu45O+j1KVZNP/+elDY7eQUMXAoBe+z4c81vmXRC5UeZuNsg+U/+uy2ro+QrJvZaQ+apQDaUr95sXn1la3n/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=hfMrg2KN; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="hfMrg2KN"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso51133826d6.1
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 18:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1777856671; x=1778461471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/sDH7zw22iV9/mg6xQgSxNHz0ndZ1t21cOLtIAurYw=;
        b=hfMrg2KNOjlVt+0mTgpjuxi4QpH10fwvxVux3eVAbxj9g/6dFAPnwC57yOtTh5Czea
         Q3K5Zuek9RVe3VP7ELK6nw5H4cGydY4IzL8a4xGVHgNOQsi1A/QmQauKEpi6j9mlMuov
         xkuOSrmKUmVVJ4C25Ef6377eILWk7bVJtAgCIXN5RFg5T1Cw0uSTgDaizPZua9pQ91YE
         M/+w9f17MJghnws2haHnqV0l1nA+AvqaikkAzc5SD+kbyVffOhnjERceZu4oFVhJeA6/
         HWU7eWsWBe7DaIHqRlp5y2lXHd9P1X3iCmOLvgk4xTGvzZ0yqlTbkgLHGDq2JQxYmHbv
         /bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777856671; x=1778461471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/sDH7zw22iV9/mg6xQgSxNHz0ndZ1t21cOLtIAurYw=;
        b=UwRttQePg2+jCJKvpeZ8f4y2JlB8syqzsV0gf8DaN/BLLOvnQTbac+OCP8UzTcSqEq
         P+RUNcPFyaJXR2vpqHhLxmTmzhuiK8ymJ93v4cuyiInjWS2031Uj2yXz/4c6VFQYjzn6
         nW02lvzgwc4UurtdmV2LHyWety4lEUxKUpR/PH0vSeDIY8Qn2mm/8Dz0HhW4lT/a5hkz
         Eaa0cl1yK+JVaUsxtgIlE1UffER1jPhvWUH1TezaLF4YDswE2OwKTOVrbVWQJ9JPBDY0
         gL1im7ayiZiBADdrQpPCjoxnM9sCnJhY6jEQBbUB38fR11wwhXwU8uqgJ5AYxsU7Oprn
         wHAA==
X-Forwarded-Encrypted: i=1; AFNElJ+8s1C+YwXsrF64Q5TJ5mPmo5A0gXl+diTdHHSXVI5GEq+EBMFjTKJLDLQl47u3tuSAMzVrDb55Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyD7tp1YwfoZci5ax3581ewdHNG5N4XYTYeQ9zfTIRHejfDara5
	ALqaSNuAWb1SBJg+5Qboj62morA/sxa2OUWKIBI5fZYiedTpitzwwpqSzg059x0H5A==
X-Gm-Gg: AeBDietiuQkI8qA445PgcnylQwICn4B4JtKWFB8L6tIQoQrVao/1sOrFr1/TKrkFxvf
	ESGs2L06qWShZxh7Wp/XdiF7JdXehkmcBEmmt4JvWMKH//8gl/e8Oc0EWLrb1waVXZ/85GKJbzd
	F2fJb4o0WUYb5KKI5GUPE8XYfA64s1Bn4C58rmnRy8VF4k9ueRks2zVeVxLrdYTZblRYOeJd/9r
	MmOXQeM2MqrnLeYw6bWMPDtftvvi3zhI56nicpRSEcJgUII1Pj5wJee+ehvD21XRRwafXeKxZC8
	Hj/V9mQAvfTA4ck8Il1xcB0Kmc2cOsTj3qI+J2/ePazSLyMRK/sDmpW6STbJV24SSEQUjjGWRIq
	rNsfKja3IZNFjjcgYXx98fqgXeEDp9a0qIPK3hFENdxwfEhb/Cyf2jY4p3Ad9u3W11ezMDP7P/o
	RGpifypc/pq4d8HuoWYq1+MCD20rcIAb1yQXNqQRTTVoITaQ==
X-Received: by 2002:a05:6214:f25:b0:89c:867b:a9bb with SMTP id 6a1803df08f44-8b4000806b4mr210752936d6.18.1777856670918;
        Sun, 03 May 2026 18:04:30 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::a0bd])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d35787esm101254086d6.44.2026.05.03.18.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 18:04:30 -0700 (PDT)
Date: Sun, 3 May 2026 21:04:27 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Haowen Tu <tuhaowen@uniontech.com>
Cc: oneukum@suse.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	laurent.pinchart@ideasonboard.com, hansg@kernel.org,
	mchehab@kernel.org, pavel@kernel.org, lenb@kernel.org,
	kernel@uniontech.com
Subject: Re: [RFC] USB/PM: should USB interface drivers distinguish
 hibernation THAW from RESTORE?
Message-ID: <aac4e77f-bca4-41e8-a0d2-608d66a25c14@rowland.harvard.edu>
References: <37c9bf07-7b21-403c-b4fe-d54ff6f811db@rowland.harvard.edu>
 <20260430021433.2083281-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430021433.2083281-1-tuhaowen@uniontech.com>

On Thu, Apr 30, 2026 at 10:14:33AM +0800, Haowen Tu wrote:
> So the real issue I wanted to ask about is closer to this:
> 
>   during hibernation image writeout, should PM resume all previously
>   frozen devices, or is there any room for a more minimal resume of only
>   the devices required for writeout and their dependencies?
> 
> If writeout succeeds, the system will power off afterward, which made me
> wonder whether every previously frozen device must be resumed at that
> stage in the same way it would be for ordinary recovery. If not,
> avoiding unnecessary resume work in that phase might also reduce the
> time spent before final poweroff, although I do not have measurements
> for that. On the other hand, if writeout fails, the system needs to
> continue running, so the remaining devices would still have to be
> recovered correctly. I agree that this failure path makes the problem
> much more subtle than I described in the RFC.
> 
> I also agree with Oliver's point that this cannot be expressed as
> "storage devices only". In practice, any such approach would need to
> account for dependencies and for other classes of devices that may still
> matter during the writeout phase.
> 
> So at this point I am no longer trying to argue for a USB-specific
> interface change. Instead, I am trying to understand whether this is a
> valid PM/hibernate design question at all, namely whether the writeout
> phase should conceptually be treated as:
> 
>   1. a full THAW of the suspended system, as it is today, or
>   2. potentially a narrower resume of only the devices needed for
>      writeout, followed by broader recovery only if writeout fails.
> 
> I do not have a concrete implementation in mind yet, and I am not sure
> whether such an approach would even fit well with the current PM core
> model. I first wanted to check whether this is considered a valid
> problem to discuss.
> 
> If the answer is that the current full-THAW behavior is simply the
> intended model, that is also useful for me. In that case, I should not
> treat the UVC behavior as evidence of a missing USB-side mechanism.

As I understand it, the system works the way it currently does because 
there was no good way to tell which devices needed to be powered up for 
storing the memory image.  It's not just the storage device itself, but 
all the other things it depends on, some of which might not be its 
ancestors in the device tree.

By far, the simplest and most reliable solution was to just power 
everything up.

Alan Stern
