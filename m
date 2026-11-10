Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337371;
	b=md1G9fSsFiTp+jCaeY/c13yLy/8mx7zQuqUNut8w+szHYLDDn2GWzTsvAdflblQWTWtE
	 2/NjjFfAFB9AA0IT4qbl7gwpmT6VwAmNvTFTShCkN8zzrFS2mRC5E8boJjgHYbHg5tDVi
	 UuHr8qxQNAcc62LWdISm+oVCyIhpm/I9hCCmF0IpuxskjLwxqJxOOA9nEjEUVVe5yvy2z
	 G6GrW5MurNFkG7Nt4UKemMt9iUpTSTCN/NVRboqnzLOceZ3YMbBW7FW4YWvmtn4JT/KVB
	 GRACJfO0TM+VcNM5bUCl/yE3QgNlPqOsX7RRRJAVWGYXFTfbs3Q3628Ml7u/evLRjNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337371;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xoc0r9cIuuLQ+SRXLemVDvG4xZ8PX+lZLE8aI8ExJwQ=;
	b=zCkYyUlMCjo/I2DgnNJMSCt2XoCxJXqJMpyBS8APofMiZHUkyg7yOq0xilee7+Qal6r3
	 p3+WZoxxBhOwa0QcTsqCqcgrHIntfJRVzDUeICoN9JieQa2SbgCLiyXHaPe3ttxhbGx3L
	 6Lc1z4CG9w+LC32y0QJ34Lp/Xy/HCEtmHGLM61nTxJavRPUDWPy8bBQa5ya+se9299gmd
	 IA7b72R6JUZ+5yFCEflrzzJBNLizaujhQuKwV6v12IyI3RH7F6p2GGn+wKVz5t+RKALvp
	 AcTlg13I9+CDPHXkDXIWs5C1oA4xLBXZQnt63O53/o4A0hpg+lILsk6XrETXTV55S0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acJp32zh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA6A606A320;
	Tue, 10 Nov 2026 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acJp32zh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9FD1F0089F;
	Tue, 10 Nov 2026 19:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337371;
	bh=xoc0r9cIuuLQ+SRXLemVDvG4xZ8PX+lZLE8aI8ExJwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=acJp32zh1qd/bwVyojJEZCsoGEtZPPjFvqOVloeQwhivSjdGTbgbvNAJtGIhAc9Y+
	 hqrKqfDcuHnrApuNTwByCttBPFLY0iXSAQqwwLRmHut6bgLK50KcfglC3Ue1i42rOQ
	 TUBKEvcl5PfgdFhxxzHd0P17hxEzuE57P/4pGo8s05GZPPMfcC2Y6eo0z6kCnNHOIf
	 X9IicCZEN3piDOr/jIRBUOFZIsgpkv05P1I1XrFmeg3qQKrL8x5HMxbD2zLJUvVSrZ
	 L6RIjT4TXpNbZaJW1mCJVGPXfEEn5uYo3AXRuyaa3H9hnNSbRxlw5w4W6FpW0K1emr
	 PVsrkzHn+itBQ==
Date: Tue, 10 Nov 2026 20:02:42 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Johan
 Hovold <johan@kernel.org>, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, Dominik
 Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 2/3] PM: add sysfs attributes for additional
 suspend/resume metrics
Message-ID: <20261110200242.70e533e9@systembl0wer>
In-Reply-To: <2026111004-landmine-residue-a660@gregkh>
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
	<20261110-pm-runtime-summary-v1-2-12ebf283db78@kernel.org>
	<2026111023-padlock-deluge-4173@gregkh>
	<20261110195020.7d07ae63@systembl0wer>
	<2026111027-purifier-revolver-37c3@gregkh>
	<2026111004-landmine-residue-a660@gregkh>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 13:58:34 -0500
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Nov 10, 2026 at 01:54:05PM -0500, Greg Kroah-Hartman wrote:
> > On Tue, Nov 10, 2026 at 07:50:20PM +0100, Joshua Crofts wrote:  
> > > On Tue, 10 Nov 2026 12:29:11 -0500
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > 
> > > ...
> > >   
> > > > > +static ssize_t runtime_resume_count_show(struct device *dev,
> > > > > +					 struct device_attribute *attr,
> > > > > +					 char *buf)
> > > > > +{
> > > > > +	u64 count;
> > > > > +
> > > > > +	spin_lock_irq(&dev->power.lock);
> > > > > +	count = dev->power.resume_count;
> > > > > +	spin_unlock_irq(&dev->power.lock);    
> > > > 
> > > > Why is a lock needed at all?  The value isn't going to "smear", it will
> > > > change right after the lock anyway.  
> > > 
> > > On 64-bit systems an aligned u64 read is atomic, but on 32-bit systems it
> > > gets split into two 32-bit loads. Without locking, the read can tear
> > > between the upper and lower halves.  
> > 
> > Are you sure?  ANd if so, is that so bad?  The value is "best effort" as
> > it can, and will, change right after reading it.  

Fair enough, I agree this is "best effort", so no problem on my end with
dropping the locks. 

> And even more relevant, what specific 32bit system are you using that
> this new api is going to be relying on?

I'm not using any 32-bit system, this issue was flagged by a local Sashiko
run and at the time it made sense to me.

-- 
Kind regards,
Joshua Crofts
