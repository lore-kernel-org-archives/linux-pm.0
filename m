From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH 1/1] x86: replace RDRAND forced-reseed with simple sanity
 check
Date: Sun, 2 Aug 2015 12:42:40 -0500
Message-ID: <20150802174239.GD58373@unpythonic.net>
References: <001e354e9435443b1720838a111620c4eec12a61.1438356386.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from zeroeth.unpythonic.net ([162.243.242.154]:34171 "EHLO
	zeroeth.unpythonic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbHBRmn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2015 13:42:43 -0400
Content-Disposition: inline
In-Reply-To: <001e354e9435443b1720838a111620c4eec12a61.1438356386.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, Jul 31, 2015 at 11:27:39AM -0400, Len Brown wrote:
>  	if (!cpu_has(c, X86_FEATURE_RDRAND))
> -		return;		/* Nothing to do */
> +		return;

Why remove this comment?
