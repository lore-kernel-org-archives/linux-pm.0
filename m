Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345386;
	b=h0234a1zPDu9UFq72Yqn3VktCKxaRML8VkXcWsWFt3jF0Jv+uo/Ac9blIvN9FdgBIUqr
	 wk7/clUxPdYE6vh4F0Tfb5oDN00JzTlDv4qhiKljOELruXQSf/hSt5ZX/APQY6lwel6IY
	 i0E9VwsYEPDnzpyY7C1CsnZ5zJedZ+U5gNaL2dYD6xXvVzatuG9ikgzPlP+/MRTF3mTgp
	 zZDwjINxew1MpzmDWCNOWxm/eewSu6zDFrAcaPqKG/YEYYfoJliKJSR3zb9ayzKo6cr62
	 H03xuvVVmqCOydG2ZGl7VBLyeI0fi5SfVSH0aQCrvc0QXCWjYAeVXPe7h15P06UJP+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345386;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=f2xxir49kH924Q8nc9HfK5Im8oQ4gV9kzCsSqvll8RA=;
	b=s2rnGOB52OKlLcHlcJG4GlhEMuQRqoNGJrM74Oberph+1WNHY7TX8LKkAXq+QgXIndmN
	 1ualvACDUp6fnxrpQ0HIomc46IvU+BKQUoFLb+ah9r9q1QRLot7kZ2m0EtXbm6d9L+4JG
	 ojIfl4NRmC1gB9gL4c1x9IMKsfhEcNSgTfCy3ghqO5YWqqQ7xsjm9GOOTLTWzn6SsEs6b
	 Oc4mgihr3VoSlCIcA6gWfiP1oZ+LzA3Eids9mBU1QSQnkSMWGbR1uF0cgutnXcp2ykcHf
	 zUF5KWrVUQwHwvh0boclzzbv2BVoPKPfotVDjgItJ6IIwIx5YHH0hmEkMXPWwx4a4Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="k/dY/UWV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288FE606A321;
	Tue, 10 Nov 2026 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=k/dY/UWV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707611F0089F;
	Tue, 10 Nov 2026 21:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794345385;
	bh=f2xxir49kH924Q8nc9HfK5Im8oQ4gV9kzCsSqvll8RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k/dY/UWVqnJsn4pWVeby6n8so5Iarg1v5YlTCw/EMsYdsymY6IA4a1iTTs0sp79/r
	 NQzBA/j9mOWBf1/rYr6hYK346KJy39hmFmeECvgBDUvEi+TlArmCWyBjMk/rT/PoNG
	 Vkz6umn3yIdFLro/AofWcrESQ285qbdN7J7iH81g=
Date: Tue, 10 Nov 2026 16:16:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 2/3] PM: add sysfs attributes for additional
 suspend/resume metrics
Message-ID: <2026111004-stability-crisping-1204@gregkh>
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
 <20261110-pm-runtime-summary-v1-2-12ebf283db78@kernel.org>
 <2026111023-padlock-deluge-4173@gregkh>
 <20261110195020.7d07ae63@systembl0wer>
 <2026111027-purifier-revolver-37c3@gregkh>
 <2026111004-landmine-residue-a660@gregkh>
 <20261110200242.70e533e9@systembl0wer>
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
In-Reply-To: <20261110200242.70e533e9@systembl0wer>

On Tue, Nov 10, 2026 at 08:02:42PM +0100, Joshua Crofts wrote:
> On Tue, 10 Nov 2026 13:58:34 -0500
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Nov 10, 2026 at 01:54:05PM -0500, Greg Kroah-Hartman wrote:
> > > On Tue, Nov 10, 2026 at 07:50:20PM +0100, Joshua Crofts wrote:  
> > > > On Tue, 10 Nov 2026 12:29:11 -0500
> > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > ...
> > > >   
> > > > > > +static ssize_t runtime_resume_count_show(struct device *dev,
> > > > > > +					 struct device_attribute *attr,
> > > > > > +					 char *buf)
> > > > > > +{
> > > > > > +	u64 count;
> > > > > > +
> > > > > > +	spin_lock_irq(&dev->power.lock);
> > > > > > +	count = dev->power.resume_count;
> > > > > > +	spin_unlock_irq(&dev->power.lock);    
> > > > > 
> > > > > Why is a lock needed at all?  The value isn't going to "smear", it will
> > > > > change right after the lock anyway.  
> > > > 
> > > > On 64-bit systems an aligned u64 read is atomic, but on 32-bit systems it
> > > > gets split into two 32-bit loads. Without locking, the read can tear
> > > > between the upper and lower halves.  
> > > 
> > > Are you sure?  ANd if so, is that so bad?  The value is "best effort" as
> > > it can, and will, change right after reading it.  
> 
> Fair enough, I agree this is "best effort", so no problem on my end with
> dropping the locks. 
> 
> > And even more relevant, what specific 32bit system are you using that
> > this new api is going to be relying on?
> 
> I'm not using any 32-bit system, this issue was flagged by a local Sashiko
> run and at the time it made sense to me.

Don't let a random number generator replace your thinking :)
