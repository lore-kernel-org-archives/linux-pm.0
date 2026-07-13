Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408D40E8C8;
	Mon, 13 Jul 2026 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948823; cv=none; b=QvbIoQCKmw2BkPPhJnovvcyLuRWxRV1L7M+DOKPgYOBfc0DeCJroz3C0pFgMeXtpldGokFIG6q+i+LGKnSZgguB4MgcoxFvXL+w0L2zr2YtcbAqkfZ1ybaCAlLUgYzu9UC44c2Q378xrFk7hFhcf6LnLmRilGjCf0DqxbzCv/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948823; c=relaxed/simple;
	bh=d+2ic0oTZzAVjp+sjkONAPBlcUXc0AFuk+1g3VtP23Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfbHUjAmUZdBKYLmCkyM6fwNkv7lcf/sRSTpf9YsyKFXNRurgy82/d00mJ0/T1zCkTehfi040xeI3wprppu+whIn8rmpWmPJY1nLZjiheOcRi+zVpAfWDJiaqJPD5zAiefzrkVbSYL6FvqDKeZT0AgL5cCVVmlh2WWu21isqZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5p3eXUa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5p3eXUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0921F00A3A;
	Mon, 13 Jul 2026 13:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948822;
	bh=kGAB2PLdWDPq46qZpmgueYFz09Hml5TqJsy1+tFEQOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h5p3eXUa3Y4SALApV9JjMD027ZQNoatVDcwFZmsQBRzwRyykyqTXUfY4M8qcCgK/a
	 AkAIwMxlSm4gr/4FspafrpiFhvq04x6TR/5USDtjplgiPGZ6ki/ZZakU1OYFbQMhtr
	 nMh7I6NZ6UO3vqdggBh8aab8E6OdLoPXLPIun/QHcX6TbRPF7l3k3Le9HeZizqMSfX
	 xVNYAqoy+3Akc39aCWD/MPnluhpkWmqG/aXjXmxPoMVRzWuf3/s5GqAssILC7H/6+V
	 zSXf9QMMvWniIGonhEGfp8DnCaW3P+wfhclMx9eME9f2c/t9sHhPZEExnBG7Q1OtF6
	 WH/KuuZI9K3/w==
Date: Mon, 13 Jul 2026 14:20:19 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 08/17] ACPI: processor: idle: Rework first-level _LPI
 states processing
Message-ID: <20260713-foamy-friendly-zebra-4c72dc@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <3703077.iIbC2pHGDl@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3703077.iIbC2pHGDl@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:37:09PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The first-level _LPI states need not be combined with the previous
> level and the entry method for them cannot be ACPI_CSTATE_INTEGER, so
> process them directly in acpi_processor_get_lpi_info() instead of doing
> a special case for them in flatten_lpi_states().
> 

Good point, didn't think about that when it was original written.

> Also bail out if there are no _LPI states at the first level because
> that means that there are no _LPI states at all.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
