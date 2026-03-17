Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2687B3C5DBA
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765504; cv=none; b=hwcZ1FOMwkNqA5rWFR7bk9IC7OSts+Fse+xSYDEd9xxX2Ybk3pNibxis6ELDvqpoy2XKJ4dTQPin262XmK8tmDyr0iSdQvSMjit1yKovaB/0ddMzwPiudfSFS9xWRKT/VAGXSVzKM8dg/ZZCJQ7eD4ZpJdCeSCaCg3qtc5mr2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765504; c=relaxed/simple;
	bh=GalLhym8PhTqJ7xrDfNn2Bb94b2pFwdHTu8Jw2xTqls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdtcwnSzf1ylQ/BMMkrYC4KUdeIhf483Tuzba+LIAwvELNNWdQaxNyy/88PdvkqFhN7UFaBG/8aZ81XLOf3Ssw4Biniq0T/7n5JSIuGmEGciHPd/4lWeP52nk/sYXWrw8NfM8PtDSlQzDtzyAO/y0t/IJ2HD5S+cw3nOjvHoQ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=JyvYIRvW; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="JyvYIRvW"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5094ba0af1aso65994891cf.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1773765502; x=1774370302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lU4j7u7qB7NKyiYAh11jHRQXrqQaqS0wNGhTelRvvIw=;
        b=JyvYIRvW6Jgbxi3KTVjbR4+c78+oaFooM6EpfUhyPGiDkFkRno/5rtn/A3cgbx96ft
         KbgKXrYfhanWLkESpixyqSvf7R8rCwYwjBMsWON4EOtR0wNXn/w+POyJoi+Ulq1MBHgw
         aaRxXQA7CrbCRFrqedO9DNd6UoCZENt2lqbggn5Mj71ReOqLq+IvZB6QmTEGMFypbq/O
         47297MaZ4HFvQ5xT4WEghjyXmNLvBlk0/Pu60mETQD+yFLBHANhn+x3HWSrUAw+Le0hy
         Iztv4Ck39X38Ma5m+1BCJBGR4aCZzzH3A/0BliKYn1ZVqSeQqdTEwn0noh9oBPA4r1QU
         jqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773765502; x=1774370302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU4j7u7qB7NKyiYAh11jHRQXrqQaqS0wNGhTelRvvIw=;
        b=MZv/kQ70pl4CX9/lLv8ds+GQ9WyWXNg8hrMHuV8NzZ8iOndjPls87PRVjmHN6lF1zp
         8TV67YbqMA8vwjSV/nnlmjdQEaZr7voH6kIjITZicCl5H+/v1WSiDvkBjImxawfQV5y1
         kpoAskkKGBgmjrRfbA7THrzakLH0WR/nOQ6P6N6MFB4A8xC8WPKoTirxBFbcTkZ5TwGL
         i6ua2L93tQ7Lw8ev9Z+20s3YEMziEwFtrDkI1i6c4uhFC2VpE5Gh/5k+4WeR/IggBQpu
         4AQqYvPC78DF69z5AIhYk9dskGqofdAZ1GMAgONT8nGkn7ze5o923zaWLyDsIpIOJ72h
         iOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIDsKZrFJzKrOluT5dbrkqfy/XZqrywSbm1XZ+Drlh84GdFX/qO86z/hjK84EM4kcpGMwopNigDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDYjQZvm3nKd64XBL978fsUIQHiCYut/qe+Am4wpSqUt3yb/r
	LORTKEOSzld6xHo6TaDPZAAkYNH9d33sDzEhH7vfhPpXm9cG9+J6m2by0dAuuuiWTA==
X-Gm-Gg: ATEYQzxJ5nquWqqZooU0F4S/ZHd28ysv0TNyHtGFU+utcZloZFhQj6169acNVRUsKJZ
	uz5xAo8xUT1e/p9gIb2jbdS8t/OVJHQMZhbvjlbf/a4weGWT6EGtBaCTdJ+CRQAlUgaAMsF+ZT0
	kxaXs4G/XY7Ltz/pW/HFDdIGesROX05Bjyzd8sBnN1d1ermQk6f4qKHWM9a50XN3V3ehZq5ICOy
	U8y0tzUCbzLD6lUzwqbymvHhO4qcIyEoZHGqLAbDkMLdV1psU1raEvLpycflXcCBVjXZsHroOAG
	K+6uYwgWVR0LJ2Pi8Sb0HHgoGkcxPbXWFUsgygpOT3ASGa6HC/oLPVVKTmHeCxRuAHbpGzpvdUM
	PkT6ocpxCYmgrnwXiSqwxAfxm0If6WouOOL+nurmtH85j4XmG4sUw3achcjCmo+SrCcMtXblL+/
	LlIGTVKDy2GzSi8s1+4RU8+63s
X-Received: by 2002:a05:622a:189f:b0:509:1748:6df2 with SMTP id d75a77b69052e-50957db57f9mr237397571cf.30.1773765502006;
        Tue, 17 Mar 2026 09:38:22 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::687c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b13598c7esm2062941cf.18.2026.03.17.09.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 09:38:21 -0700 (PDT)
Date: Tue, 17 Mar 2026 12:38:18 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: shitao <shitao@kylinos.cn>, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATH v2] usb: usblp: add the reset_resume function interface
Message-ID: <ccf9e0ab-3a45-44d6-8a51-955689fa69ec@rowland.harvard.edu>
References: <20260317125614.3215254-1-shitao@kylinos.cn>
 <c4f66c3b-7cb4-4bcc-868a-d3aef2d9e521@rowland.harvard.edu>
 <03344b43-b3aa-4800-b4dc-0b5a2b2fd5b4@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03344b43-b3aa-4800-b4dc-0b5a2b2fd5b4@suse.com>

On Tue, Mar 17, 2026 at 03:35:26PM +0100, Oliver Neukum wrote:
> 
> 
> On 17.03.26 15:06, Alan Stern wrote:
> > On Tue, Mar 17, 2026 at 08:56:14PM +0800, shitao wrote:
> 
> > > 9. Result: kernel panic in pm_op() with use-after-free
> > > 
> > > The bug manifests as:
> > > Unable to handle kernel paging request at virtual address 006b6b6b6b6b6b93
> > > pc : pm_op+0x50/0x80
> > > Call trace:
> > > pm_op+0x50/0x80
> > > dpm_resume+0xdc/0x200
> > > hibernation_snapshot+0x234/0x3d8
> > 
> > First, are you certain that setting the reset_resume callback equal to
> > the resume callback is the right thing to do?  Don't printers hold some
> > state information that will need to be restored after a reset?
> 
> Correct. This will not work.
> 
> However, if we take the trace seriously, it means that resume() was called
> after disconnect(). That must never happen. Yet, if that happens the issue
> is in the PM core, not USB.

In fact, it would be good to have a kernel log showing more exactly 
where the invalid request happened, what was on the call stack, and what 
device was involved.  The log extract in the patch submission doesn't 
even include any details to prove that the error was associated with 
usblp.

In general, the PM core will invoke callbacks in the USB core for device 
resume (such as usb_dev_thaw()).  usb_resume_interface() is then 
responsible for calling the driver's resume handler -- or not calling it 
if the interface's needs_binding flag is set, which is what should have 
happened here since that flag is set by usb_forced_unbind_intf().

Alan Stern
