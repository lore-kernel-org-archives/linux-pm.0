Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336629;
	b=q6hhT2XhfZmKhBvJb1qNzvm7xDp8AHy+oWAWSsZ51zhgVB1fWRHKpW9M7FKW4Ma/Xg6/
	 zpWRQvJCw5tr3triSE6D+R45HELUfK+n/UBCk0yMoXxZKAJMIbim6Xamwk/z4p2DNanz8
	 eoyIW1uHE4xL1kmUE8HSMbnVxcdW2c1G2+kv6It+NCU95TbJLbXXyPpjOD4QIdAmSacOB
	 4wvGc2BSRwWqwMvs7pLgtRCzMR0Mt7rfwP9zjPoDPhJ94cSs+G35eVEmgNByKJqg61pT4
	 UiMrIDtK6fskztUDS/nwFbQ/K2UGdF45DvlLttNEe2LAC9G5COG6/ogaOS/zLzoecNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336629;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5YOvA9188zoishfCwYXS1Hp8AbcNhYvj9GRiJfG9rcM=;
	b=SpAsHSTwGQnVpNg20AdaeihZI+aaA4NT83QTs+pZSabFeDazIoTw/K8zQ/65RLHm938S
	 I9hv3pntTwIjBOgHqwge9PzLHOY26R3Jofc0cwHPAR+MufEN4i94mcdkHu83vUEejjz/G
	 jg4W/HtL7zYkscqHGd9/O4JTBwL5pT2ceUP/fU3zzsQbaWp3jRXJ0DAgbOrG/za8AwZ5/
	 mv7P4DG5BhsPMmnoJCqWpuXJl9XV2XujZevPbcIGPOOo1JfEO1YWOyfF3smbz5LvL4G1o
	 z+AzbWNODUhk4827LJijqPC7yS6VPVDuOFUoBI3RatKRYpj9hBnR+HhHXQAc+jpdDBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7XMkC9S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC99606A323;
	Tue, 10 Nov 2026 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7XMkC9S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CF11F0089F;
	Tue, 10 Nov 2026 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336628;
	bh=5YOvA9188zoishfCwYXS1Hp8AbcNhYvj9GRiJfG9rcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j7XMkC9ShpvFWe+1z4e+VrcQ+jbZyEZnTk7d0I+Iez2DK4BgVKn5Tvj7Ufnntb/dG
	 ZZTF94jMmvEAL03lhLEgjDQeZ5/mJqM1dupv8jS0QlCLfarIB39GpM2SFUOoDufJ+V
	 cLXmfvVTgmhshzfzN02nYEYLCOEpEC6Z7uT4Hx9b7bBfphGCSbUQP103zyuZHZJWjd
	 egziSufQc7ylCsennCkQkxoMrDNRqemCmB99vns3E+mlr7iUCAU26ykWmT4EmiqhLq
	 5PfuP5LPQ6RTL8I5yQuETPKH0bxLkOcw6a0WanFoqyOxL4jCNRPdn0X6t6Go9kGx5T
	 Vb30NZ1UmXutg==
Date: Tue, 10 Nov 2026 19:50:20 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Johan
 Hovold <johan@kernel.org>, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, Dominik
 Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 2/3] PM: add sysfs attributes for additional
 suspend/resume metrics
Message-ID: <20261110195020.7d07ae63@systembl0wer>
In-Reply-To: <2026111023-padlock-deluge-4173@gregkh>
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
	<20261110-pm-runtime-summary-v1-2-12ebf283db78@kernel.org>
	<2026111023-padlock-deluge-4173@gregkh>
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

On Tue, 10 Nov 2026 12:29:11 -0500
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

...

> > +static ssize_t runtime_resume_count_show(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 char *buf)
> > +{
> > +	u64 count;
> > +
> > +	spin_lock_irq(&dev->power.lock);
> > +	count = dev->power.resume_count;
> > +	spin_unlock_irq(&dev->power.lock);  
> 
> Why is a lock needed at all?  The value isn't going to "smear", it will
> change right after the lock anyway.

On 64-bit systems an aligned u64 read is atomic, but on 32-bit systems it
gets split into two 32-bit loads. Without locking, the read can tear
between the upper and lower halves.

> And if you need one, why not a guard()?

Yeah, I realized this after sending the series out, nevertheless
Sashiko flagged some other stuff so I thought I'd fixup in v2.

Thanks!

-- 
Kind regards,
Joshua Crofts
