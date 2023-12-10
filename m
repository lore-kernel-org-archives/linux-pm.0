Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F46FAD
	for <linux-pm@vger.kernel.org>; Sun, 10 Dec 2023 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcLZQfHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246A7C433C7;
	Sun, 10 Dec 2023 10:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702204092;
	bh=xna6/O6IZ9waJxH48kfJzUPY0hegji/Pnu2/quXKVrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcLZQfHXxcsdvfsImUzif6GbNVRoqpIB+QE+HSVWl+LIIyHURc0hZOvOT6iQqbSDf
	 CcKrXqkwFYwvNQYeVkhSRGXn3yF8tHbqDrleoF9VBXHSs5RaSLmbgwy4wtsUCHItDQ
	 Tw6mr0EsedGg+s3upiifIo+SVaSFD1JT9TlTwNFI=
Date: Sun, 10 Dec 2023 11:28:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vimal Kumar <vimal.kumar32@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	chinmoyghosh2001@gmail.com, badolevishal1116@gmail.com,
	mintupatel89@gmail.com
Subject: Re: [PATCH v2] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <2023121027-riptide-spiny-0be3@gregkh>
References: <20231210100303.491-1-vimal.kumar32@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210100303.491-1-vimal.kumar32@gmail.com>

On Sun, Dec 10, 2023 at 03:33:01PM +0530, Vimal Kumar wrote:
> +/**
> + * abort_suspend_list_clear - Clear pm_abort_suspend_list.

Again, a horrible global symbol name, please fix all of these up.

thanks,

greg k-h
