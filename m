Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA3422552;
	Mon, 13 Jul 2026 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949034; cv=none; b=CFW3+3+QdD3qw8KsVQ0d2HHtgQSiqQ/0bswrLEpYXTvJuWEOBhOZaO2dY0CAl7nSl6sPr2wiuXR9KE0V1+cypqVGtGsSY2o6J+yEMxxBN/6RFhJZgNiZSU3T9Kz14N66V9QZZ2LnEg1vf9EYrzNLCcGGdBmQvjOQPtnX+YWN+lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949034; c=relaxed/simple;
	bh=056eOz/k5VBRiA76rXy9WLW+TRu86FA9xsYttVqFx9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cu/BLxcBleqcsjwaX99GEwCRZvovxHrvOU0EhnDxPl4PEvD7ZTyQ29EE4lJpqZoLYVUK5NoCs5kTWjROGoiI+0vqPHrBLjV6HfTXqOJJKMnQ+9CuRrmzdnp7w9OjcBzJdt9nokRQdQaBzxZPhaq7r9olOkIZtjbAR9kxPs4yeXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6jaqcbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6jaqcbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007901F000E9;
	Mon, 13 Jul 2026 13:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949032;
	bh=ZSMEE1nB2ScVoEokNvwIEkHnNb+xGxBB5l9/2VUhvyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K6jaqcbzmYReHSbxJqLXA5fxL4ypD57TpHDnTqYQzYutL0XLQgI+kuOtII+6ZxMzy
	 1fcTOyskJI0D40mm2Ks0+58fmqaC49WKxHsgoQ9DSc4CBUfymkNDB/d5FTZfnc3Tc5
	 bhNSog2HqziC7cRlYhmvQ3p7sgiHtx8JRQEp4ifJz46TA5M7Yb/OegLFTx1r9Tmhed
	 742othwIeVao7tl2pg4EtiHJ5zY0l3ujRxXII6MERy54Cje7nkGYeLqR0sygITu1un
	 uBQNIRGPB5w5ZRmGgxY2z7VjykasLMEbzAoV0qL6sD16xIHWPi5U/Bk3/BMJaH0shw
	 gLuEz9TGxoA1Q==
Date: Mon, 13 Jul 2026 14:23:49 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 12/17] ACPI: processor: idle: Introduce
 too_many_states() for _LPI
Message-ID: <20260713-adept-quiet-giraffe-ca9af4@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <1964818.CQOukoFCf9@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1964818.CQOukoFCf9@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:39:49PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> To reduce code duplication, introduce a function called too_many_states()
> that will check if the total number of _LPI states for a given CPU is
> too large and print a message in that case.
> 
> Use that function in flatten_lpi_states() and acpi_processor_get_lpi_info().
> 
> No functional impact beyond reducing dynamic debug flexibility.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
