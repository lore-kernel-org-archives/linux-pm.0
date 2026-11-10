Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336849;
	b=YKjlXOkXzPVgEr9qTerACaKky25cYZDRE0CgLQei6T8NyL4faKPBlftgE4rHmrIohEfS
	 QpF1iC7uZkPnpcbFS9i6+ntQ02eEJ1uOE/VhVWdXVmp+31AsCJja61VnJJWzHrDgk/sJh
	 GmTJRXaxU/OKwgtG7Bjbbq9RVQKRhkmSxbEHpx7bhsmon1HYOwSc1Ml8TJJwgpJ3534ZG
	 Uynje3w8gJeyHkugK8EdnCFsi8+y77cPmx0glN4EmS0D0o7OxNpfV8k7eKyr6S1YQ/wJe
	 xLCJZuzBO5D7vNmoordVocNR7F+i8t56CKFr4WN1tuHmfk/gkkfp/cLQqqy91O9xOJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336849;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8aZiMgdpUIGUYsouHyN6a1Ywpiuzgy+D+c9XrtJxDx4=;
	b=gtPl+RiopUyrDeTND7nk0Aik3gzkNI3zH4X+kUJhuP9S4xRg75WQi9BUJ76PD2c39Rux
	 3qzdjibYAK8OWFu6to/YyQOvzcLEDuXrs/QYUrdyXaxePSP4EimTrHyWQHks/c12Ez+8y
	 y5SVgLOZwOAXUpJCbrcH1n4d56Q6hrhRTpoT1Qkysf4SxbOamI9nxavnBEnJTLDrbhNDd
	 FRdCMjkNzk+9O+JFIv7WH8TDzKwM9GBMxzbzpFkbEkAWoGInQ7+3IfCgOCoYo7akkzKMp
	 f9OUMRdBuoXxp2T0+ZMMZEIrfXl9eVT0txaZdv7yKwQmTxguJifR5kdjvLSxCgd5LbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0Q2xwnIu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41354606A31C;
	Tue, 10 Nov 2026 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0Q2xwnIu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680B31F0089F;
	Tue, 10 Nov 2026 18:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794336848;
	bh=8aZiMgdpUIGUYsouHyN6a1Ywpiuzgy+D+c9XrtJxDx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0Q2xwnIu1XHpGYM5ts5NJYcRAPbKRzaWxjptggBFTxRDc1XwH+UjPC9k/juwxrMRm
	 SRdhdf5KQVl6xB/CnTRQQIbvBcKPsUIl582SLXyJeNu4PYFkt8GthI/us1kfVe8iHO
	 FJKQDenC2Up7fR/yjPLL6Kmbbv2NZCp8S/YTIJXg=
Date: Tue, 10 Nov 2026 13:54:05 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 2/3] PM: add sysfs attributes for additional
 suspend/resume metrics
Message-ID: <2026111027-purifier-revolver-37c3@gregkh>
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
 <20261110-pm-runtime-summary-v1-2-12ebf283db78@kernel.org>
 <2026111023-padlock-deluge-4173@gregkh>
 <20261110195020.7d07ae63@systembl0wer>
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
In-Reply-To: <20261110195020.7d07ae63@systembl0wer>

On Tue, Nov 10, 2026 at 07:50:20PM +0100, Joshua Crofts wrote:
> On Tue, 10 Nov 2026 12:29:11 -0500
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> ...
> 
> > > +static ssize_t runtime_resume_count_show(struct device *dev,
> > > +					 struct device_attribute *attr,
> > > +					 char *buf)
> > > +{
> > > +	u64 count;
> > > +
> > > +	spin_lock_irq(&dev->power.lock);
> > > +	count = dev->power.resume_count;
> > > +	spin_unlock_irq(&dev->power.lock);  
> > 
> > Why is a lock needed at all?  The value isn't going to "smear", it will
> > change right after the lock anyway.
> 
> On 64-bit systems an aligned u64 read is atomic, but on 32-bit systems it
> gets split into two 32-bit loads. Without locking, the read can tear
> between the upper and lower halves.

Are you sure?  ANd if so, is that so bad?  The value is "best effort" as
it can, and will, change right after reading it.

thanks,

greg k-h
