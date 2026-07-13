Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8442B334;
	Mon, 13 Jul 2026 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948878; cv=none; b=cuQBOuXyLrX0LZGfu3YhumtFXYNuEGgafcYalmhdeiqYCqDj/Lgs5TSTOEitSmyoA0QtkXj4WWS2m2bYmu90ulNaxNveIxyfJeZVVNIBcte1bdOhQnxY+jT6mbBTpAYMhpJXrS+lfrMVMUXqmwp4Ppf/6WGYo1X3IWc88aRxiqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948878; c=relaxed/simple;
	bh=T+Mnob5iFrr/kcdEVIBBW+XHwHAjeClBGCWrwyOugkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt7J7xHmLQC7+799PYfp4BDXv3slGUqTTsjHRQsEGKaS6dJPXJWWtsGA2BPwo3vs6njKZdk1EkZjrI5cD8IsWsXRmPlY3c/VkFjBQfxvXdADdPWSVvxtCu1Ge5Eui/2CElUOpxkiJ7w49W4JVbwa2ZbNLVLHTAAcRkla3Z8kSG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwfvCLJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwfvCLJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933B41F00A3A;
	Mon, 13 Jul 2026 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948877;
	bh=3CXZPeeSV721Z3myFDmq505d8VnsnF43DzzvewIftFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LwfvCLJIo9kILzGHhsT8T5VX5l7hF38oQyCXgMaI/KAaJleG0I5ZeyezuZzUY2oeD
	 H0e1JFnoiRgKxA7AHyrJTIxv8I/yGI023LkBUCSKZEomShcdwVu0CEZjjAGbv67vtK
	 zvar33IWmtedmpkAh1MxhjZXDdu3POGxsT7p3HgSYSQezsp5M2kJwjiXTZcyyDAVx9
	 vqCGdDoyMnMTeJ8q2O8lDAFmTt3k9qZLq57pgqao+EpAknQmNjWjW+apoopVGuoyqd
	 SX7jvZQ5ScB+ohh5zwq1zNXmFxzJNQkrfVca6PU8MpBfHZZnmUIwCmD3UtIq51gwwJ
	 fyV2ITqUXWPWQ==
Date: Mon, 13 Jul 2026 14:21:14 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 09/17] ACPI: processor: idle: Drop redundant _LPI
 presence checks
Message-ID: <20260713-festive-smoky-marten-cccc96@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <3349003.5fSG56mABF@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3349003.5fSG56mABF@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:37:49PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The acpi_has_method() checks for _LPI in acpi_processor_get_lpi_info()
> are redundant because acpi_processor_evaluate_lpi() returns an error
> when _LPI is not present, so drop them.
> 
> No intentional functional impact.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
