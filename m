Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337116;
	b=UtcWYYXzQ6czW4WzLiMO3p/JEEhJwW4uGVVzKb4lJseBUhW+Hd0mtb0v8X4aal4ECkMS
	 GhpS4Wt4uspUsR33lG87TAuV5d9+bF7XMywetrlGULWwlfOzdXZA0kBaYdfXtRWfeNs/7
	 J3GYAJwfptEsceWl5RHDMiWOkrFh7r8curk9PGxZYt32ue3teXntVcHzZbSo/gJNOhQRh
	 DVMlNg0KeJM4yN+cQjugE9wUizeOoDla/9G+chBQUiyG9j4w7Jomv1P2hnB+0cgdYlSDX
	 xD+FNoMT+vS/Qe6H1ZWTxVt8gczvpClUj6jFWiMQZV7gFQB8FZWAxPdWN7i5MroKWZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337116;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yXBR4nSuR7ncsnkQ7nHWqyhXuViQEk7eAKifs6Evowg=;
	b=tuFwCwMpnJHh9Wot0UCM+Hw3ovjUyqCfo143bJrjnk+iISOCDsDcHvYitudusgduvOhp
	 goDtycN1FHVbwMziCAcYP4LuFa2BPoIkZEpeMWhU/PEO2iRtaWmihf4UXFmYGfa5rrv8Q
	 x/BmOfxcos6SgAdlYHtAhvi1574s7MAnPtCmPdJxExAePzIjC5EngX7/19EB5ZDUF1UDd
	 mGDIOUmteclUIfj05v/XNGr5c8aagsPAI8yAAO3Jvljx2zA2aUg8m/j9KnkgKHSwhcL3s
	 TGl/nk/GpfRZf+Z1RUAOlJQrWBq3VrgFPYENJSV9o1Vy3+MOW/e/L6GsGhsEYEkutdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hHCviO5e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693E8606A31C;
	Tue, 10 Nov 2026 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hHCviO5e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49FD1F0089F;
	Tue, 10 Nov 2026 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794337116;
	bh=yXBR4nSuR7ncsnkQ7nHWqyhXuViQEk7eAKifs6Evowg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hHCviO5eLEwPg9unugj5/9gIPwWd30F7cpV7KEuKgLd7XZwsGzp4B445sRGuhWPPa
	 hB5k6JQMlUhXBV9zmw4wUc6l6XLDDtsIQzUSXjx6JVl/g/UQT76fDuKfH19sITNbo+
	 gxiQEAn7T2K70X05MQgyGPKOyMjRCUTNxpd5SqW8=
Date: Tue, 10 Nov 2026 13:58:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 2/3] PM: add sysfs attributes for additional
 suspend/resume metrics
Message-ID: <2026111004-landmine-residue-a660@gregkh>
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
 <20261110-pm-runtime-summary-v1-2-12ebf283db78@kernel.org>
 <2026111023-padlock-deluge-4173@gregkh>
 <20261110195020.7d07ae63@systembl0wer>
 <2026111027-purifier-revolver-37c3@gregkh>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026111027-purifier-revolver-37c3@gregkh>

On Tue, Nov 10, 2026 at 01:54:05PM -0500, Greg Kroah-Hartman wrote:
> On Tue, Nov 10, 2026 at 07:50:20PM +0100, Joshua Crofts wrote:
> > On Tue, 10 Nov 2026 12:29:11 -0500
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > ...
> > 
> > > > +static ssize_t runtime_resume_count_show(struct device *dev,
> > > > +					 struct device_attribute *attr,
> > > > +					 char *buf)
> > > > +{
> > > > +	u64 count;
> > > > +
> > > > +	spin_lock_irq(&dev->power.lock);
> > > > +	count = dev->power.resume_count;
> > > > +	spin_unlock_irq(&dev->power.lock);  
> > > 
> > > Why is a lock needed at all?  The value isn't going to "smear", it will
> > > change right after the lock anyway.
> > 
> > On 64-bit systems an aligned u64 read is atomic, but on 32-bit systems it
> > gets split into two 32-bit loads. Without locking, the read can tear
> > between the upper and lower halves.
> 
> Are you sure?  ANd if so, is that so bad?  The value is "best effort" as
> it can, and will, change right after reading it.

And even more relevant, what specific 32bit system are you using that
this new api is going to be relying on?

thanks,

greg k-h
