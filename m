Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD63009D6;
	Sat, 21 Mar 2026 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774091037; cv=none; b=VXqomQU8or2JsnlzTG2bho8rbkdBD2Nr2DjbqdlGMvnmbKWS2PR6jNUgw1K8YoUVTBaKw5yk/zYHzpb1mmW7ObhrVE/IlQoO5t8dK67/H52mFhVjjHikBQ5Xji9L2tYkjqYEm86bAx0XNO7Yzb7xP5OrD9z5BMDxmBNfbVn7p+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774091037; c=relaxed/simple;
	bh=Cx4rFJasLXPhBYfaKJCA6oLZnWmjXXEJex+iH4kBfYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EM/X/r/1r4GDt5G5Ts9Lj+AJPaTiohhSlT0wdvH/gmNHCMmDLzCYTBW2+PIaeN+aff8q7HH6SYgHf6M1EEkc5WttZfhTqXKVGcXxO4SGCxVzICDyiY/LKwQXNe2D0lh4fZ4eDedmNwx4TtEPfkaou0f7EoLJcO9iLTgsmNwlr/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MTgXGxJ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MTgXGxJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A5AC19421;
	Sat, 21 Mar 2026 11:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774091036;
	bh=Cx4rFJasLXPhBYfaKJCA6oLZnWmjXXEJex+iH4kBfYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTgXGxJ/Y/bRUf4Zl2eENuaC0jjSKkzgeTA/OOSYfWcxW1bp0CeDqGRqG0Z85XdpD
	 ECCuN+Ld0QLY1gQ6wxow87sWCcaw9BXD7UrJ/z0FSR21A5GmIF7MXls9DWKFb0mW2d
	 90Py/x6RZGVZXYPQCfa9UDjcAZq71BRlIjha4fXc=
Date: Sat, 21 Mar 2026 12:03:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: stable@vger.kernel.org, rafael.j.wysocki@intel.com,
	linux-pm@vger.kernel.org, christian.loehle@arm.com,
	artem.bityutskiy@linux.intel.com, quic_zhonhan@quicinc.com,
	aboorvad@linux.ibm.com
Subject: Re: [PATCH v2 6.12.y 0/6] cpuidle: menu: Backport
 get_typical_interval() improvements
Message-ID: <2026032124-crabgrass-friday-2788@gregkh>
References: <20260321103721.35114-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321103721.35114-1-ionut.nechita@windriver.com>

On Sat, Mar 21, 2026 at 12:37:15PM +0200, Ionut Nechita (Wind River) wrote:
> From: "Ionut Nechita" <ionut.nechita@windriver.com>
> 
> This series backports 6 upstream commits that improve the menu
> governor's get_typical_interval() function to linux-6.12.y stable.
> 
> These patches are already present in linux-6.18.y but were not picked
> up for 6.12.y because they lack Cc: stable tags.
> 
> The key improvement is in patch 2/6 which merges the two separate loops
> for average and variance computation into a single pass, reducing the
> latency of menu_select() on isolated (nohz_full) cores. The remaining
> patches refactor outlier detection to cover both ends of the sample set,
> update documentation to match the new code, and add a minor bucket
> assignment optimization.
> 
> After applying this series, drivers/cpuidle/governors/menu.c matches
> linux-6.18.y exactly.
> 
> All patches are clean cherry-picks from mainline with one trivial
> conflict resolution in Documentation/admin-guide/pm/cpuidle.rst
> (patch 5/6).
> 
> Changes since v1:
>   - Added upstream commit IDs to each patch (Greg KH)

Still incorrect :(
