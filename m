Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA17397949
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336873; cv=none; b=ToLg59LBuELB22bBzHPCUQ4ILrFLnFkYeLluop1NiU/qMNrDDkYo/qn/vS95RG2Pk8Tfw3DXYu3l80oXfxQdH5AEHkSzNpqKx9XWZM6MpSzfuHYbiHiFm/tTF9Zf4xFKj+g72MfHE9ztTidHGs4e4KFa9QW8doCWnuRx0FsYML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336873; c=relaxed/simple;
	bh=eEfGUNYm069B8YRJw7nG+CpVl1p+N0InV7LL9ThjIe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OezI3XUpKBQzDHnHc6f87iAIJwjaPVL5AbCu/viGkDeM65qVb928/qbvfYYzosFkEzxpmXyYRIMrqXGQFDp9jhK++DJFe7WwtQ8bP4JtlMRkX7me92iLHzqVvrs8xaAlynJm7uCNEL8T8brW5ApFJFbH70RU9ngBijJGtrdT+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=O3BmsLQw; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="O3BmsLQw"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c1372f84dso5970601cf.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1785336867; x=1785941667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=diG76WQps7jL2eyBJvu35E+/CEytgTNbNERpdeDHsjg=;
        b=O3BmsLQw3McVjTiDGfKastaWa5ZTDhWha9yR+c9sNTwfCVWSxFPZQh59Bwxkp+HpXf
         hJ8lT8mUOuv6Qn0cxeIv8zPndGtRZiXfqnKjepB8wLbn8Z0dtX+PJajGlVWO8HsEHQ18
         focSSNttHZLcFRhehL4jqDC4a/HpRGM9qQSInQa+gKoRQH4hhhbpQkG3D4BXnFeOlb0S
         8WehKu9o7DYabQ7Wt3arignFNdJ7FdVEO3kfLTxt3+iNiGrNysxJAbtCAAHYYRHImaFu
         6yD+SoIZ6g4I592C1JX5T35MTcmEPrdeIx+UK5g2hmOZERGp5tC81OEGFg2lhTmJ4sDN
         et0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336867; x=1785941667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=diG76WQps7jL2eyBJvu35E+/CEytgTNbNERpdeDHsjg=;
        b=dtxyDuj4GqXT+ll332Imz9W0wyes4NARsrzGeG7mBh3QThTuUsk9XxdsNPW9GA+kEX
         8CSeLoK9mtwcmt4Qc4OaGT8NXBTcfUE0UaQ4dTDCYti51un33gTro+Lvdal+eDjUyD1m
         YJ1Ub0lcA+/B8Y4pFdO+OpmLY8dK9ZYObQLdztoyA+/fG7bMVSjJIDQaynKI2+rA3Tu1
         N3qeFvmr0Rd4nyShPV7eysEt8a6ZUypULEwNiZIFte/zezMsI0f6nHqNqtYqJOdqcJ0U
         IUqbpT6akMnqN9HJQVr9g7kKqzIROLRW9EpDOmoppJdVOPjaqihbBqGNImiiIQdbai9O
         bFoQ==
X-Forwarded-Encrypted: i=1; AHgh+RrS83Lo+kQ3jmPHkjpFvOYnT7DZHd2zTR/xk4u9BoEqld3dXUTIP9m/4d+BzYwGRlKHp/YM7MPjIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVUFFWb4pkRT7pFjq+A0P+2FTUK3m+4c19t63xIcUVifgZr4Qv
	fmJLfOLdIDm3fHE0tpDbCxeTBeCtUPX1XvXoIWhbklXjl2yJwdAjZv74Bd2K6OhnNw==
X-Gm-Gg: AR+sD122dIrHdjwuSwRLy1Cx5jyPKZ5Ci7Y96a483ZwV1NSfS4T1DxLa2cJf9xOZOhc
	jsL5Sx0Vq+06uXcRxS3sPUsJxYs/lSPpIZvZxv/uPjtsDEhSFZlcZxZtRaRSlseKBYpd64oL9TD
	255cgZtxYzyyLcndaTWk0R4VqQd7pQzMwXa5bNsR+ojS5/i3ZvMJlMDg7VsG9w3jZcMFgYqEYGH
	SBWNW1a1wvvro5UhdwrR/AAZ90ZwtlXPIYUXCKfPSdKAyFlnJ57rA6S3lRfjWAd6X9cA4wipbIQ
	DXm2PtIktNxoTXu6qg7VgQe7uM4UtjjAgsFX41XTMqNZj+W/X2qA0exJu5qwiQq7OJUMX38dmEO
	jagj25++F78aJAQhDyaHiSvoTZi/N54dZyw6NMOP7NQDUr5Q58EzoFhK5Y5Ls5UDa9WIH4rdtv5
	0LB2kXpyzRWx9zsAsHEuLV2bauTCIAYG6p3dRDT0criFfv88AuH/6AG3/EQuCWk+W6W3wa9v32x
	p6pFfAPWt3XAZHmkS4zU3gIhjS4ncJk
X-Received: by 2002:a05:622a:608f:b0:519:89b6:78b4 with SMTP id d75a77b69052e-529d7103196mr64381481cf.40.1785336867388;
        Wed, 29 Jul 2026 07:54:27 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:a008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2dd45ffsm19696401cf.22.2026.07.29.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:54:26 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:54:24 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Haowen Tu <tuhaowen@uniontech.com>, hansg@kernel.org,
	gregkh@linuxfoundation.org, kernel@uniontech.com,
	laurent.pinchart@ideasonboard.com, lenb@kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	mchehab@kernel.org, pavel@kernel.org, rafael@kernel.org
Subject: Re: [PATCH v4 4/4] media: uvcvideo: defer streaming restart after
 hibernation snapshot
Message-ID: <af0d5a2b-373a-4a0f-9e0f-8502217a6a1a@rowland.harvard.edu>
References: <cbac4803-cf65-4b8b-a662-073189df478b@kernel.org>
 <20260729075655.1187692-1-tuhaowen@uniontech.com>
 <0e22e9d4-da39-4d3f-9492-5c74295be312@rowland.harvard.edu>
 <5d36c6a8-bbc9-4d5f-8670-2993bdeb857f@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d36c6a8-bbc9-4d5f-8670-2993bdeb857f@suse.com>

On Wed, Jul 29, 2026 at 04:43:44PM +0200, Oliver Neukum wrote:
> On 29.07.26 16:08, Alan Stern wrote:
> 
> > You're missing an important fact: If something goes wrong during the
> > hibernation transition (for example, if the kernel's memory image can't
> > be stored to disk) then there will be no RESTORE phase.  Following the
> > THAW phase, the system will return to normal operation.
> 
> Right, but that does not need to mean that the driver has to be operational
> at the THAW phase. It has to be operational before userland is unfrozen
> again at the latest. The difficulty how the driver learns that the system
> will not power down remains to be solved.
> > For this reason, during THAW drivers must not assume that the system is
> > about to power down.
> 
> True. For this reason the patch introduces a notifier queue.
> 
> Now, that you make me think about that it seems to be inelegant, as this throws
> away the proper order of the device tree. It seems to me that we should
> bite the bullet and go for the big solution:
> 
> Split the THAW phase in two, like a THAW_WRITEOUT and an optional
> THAW_BAILOUT that is called only when the system does not power down.

I could think up some better names for it.  Also, it doesn't fit into 
the existing scheme of callbacks, whereby each "suspend"-type callback 
has a corresponding "resume"-type callback.  The new one you're 
proposing would be something different -- a "stay-alive" callback, 
neither suspend nor resume.

Alan Stern
