Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD923F39DC;
	Tue,  9 Jun 2026 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995896; cv=none; b=CzEixAmIimbTIHX32oMrlUA6UipW6gpdK85IZ2Zw6s3KsDKD2fYjHDRGnGS4YbU5Ddqr7ZVUlhU6j4/Kcp/O3ZONapzk1YvjhPo0PjUyCG4LpINshfPAFAXcDlYzh2jkuQNmZ3P1NkXZOHhC89kF46AsAKzvUFaZ+tk5xeJTRRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995896; c=relaxed/simple;
	bh=jNT0vRvPNIak5LRiwa7vuHn1XgrT0qtwZZuGQppzKNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJRAwHKiR3P/4FXVT6OH3XlWUSSBcQuYRncPWCZ+vGif7ZbdB6x6ZvOGedhyuZOWIEPFLb3xTEw3ne90bKcl0YP4yForJ6Jbjix03bABYEJWsHc8THm5PFrgLZd61OMK69TFc3Kfsy9BEbMh6VsUW4wiYMFSaikbDH7YcMG0oks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmYHe/CY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmYHe/CY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26B41F0089D;
	Tue,  9 Jun 2026 09:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780995895;
	bh=eSRSkbJIvvOIaNuAXjyCBIT0W80idOeY0BphXmsbFsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JmYHe/CYVQwajXM9Ux+6DyTePS3RYY6UJwF93cVlMkmOPW6scRShAAw7sF5YJxo9t
	 eR/g3kKWzLir872oJBk8NReeZ+lsaQbfiOrw5K1RoHgO6BPX5bgIv9GLPc7tRwqdYg
	 3oCOGH9YkAgwshpki84BM3jTYyaUr9Bqc6bUxXdeg7Nj2/tonEZE0Z7KulnoPraNrJ
	 ftCu93KRu/OAGsmfg4sV9n2BbXUIIDr2Del7zLdddxvqLomD1k1XXcdhVOrDbM6Rvn
	 ZtfSFTNJ3at2rwPZlVuvXNzZsllzjrfqCNoT2O/aKS/PtJO2ZVlP9CwQJobeIdmnpO
	 L8IW1DtFSvnaQ==
Date: Tue, 9 Jun 2026 09:04:51 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	tfiga@chromium.org, senozhatsky@chromium.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 2/3] PM: dpm_watchdog: Allow disabling DPM watchdog by
 default
Message-ID: <aifXM4XgkMkXNl8J@google.com>
References: <20260608021526.1023248-1-tzungbi@kernel.org>
 <20260608021526.1023248-3-tzungbi@kernel.org>
 <CAJZ5v0g4VuR20dF+Zw0b75u4=ajFBOBAKokCoyDBtjCETexK3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g4VuR20dF+Zw0b75u4=ajFBOBAKokCoyDBtjCETexK3Q@mail.gmail.com>

On Mon, Jun 08, 2026 at 04:14:09PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 8, 2026 at 4:16 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > Introduce the CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED Kconfig option to
> > allow the device suspend/resume watchdog (DPM watchdog) to be disabled
> > by default at compile time.
> >
> > Additionally, introduce the "dpm_watchdog_enabled" module parameter to
> > allow the watchdog to be enabled or disabled at boot time (via
> > "power.dpm_watchdog_enabled") and at runtime (via sysfs).
> 
> I think that the new module param is more important because the new
> config option is just its default value, so I'd rearrange the
> changelog.
> 
> Also, I think that the "DEFAULT_" part of the new config option name
> doesn't provide any additional value, so I'd just drop it.

Will fix them in the next version.
