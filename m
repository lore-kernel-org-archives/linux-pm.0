From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 07/16] ARM64 idle: delete pm_idle
Date: Tue, 12 Feb 2013 11:03:28 +0000
Message-ID: <20130212110328.GB14899@arm.com>
References: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
 <c09e2c0f2928cfe6173bcafe0d906bf87287d5c2.1360475150.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:43721 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758296Ab3BLLE6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Feb 2013 06:04:58 -0500
Content-Disposition: inline
In-Reply-To: <c09e2c0f2928cfe6173bcafe0d906bf87287d5c2.1360475150.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Feb 10, 2013 at 05:58:14AM +0000, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> pm_idle() on arm64 was a synonym for default_idle(),
> so remove it and invoke default_idle() directly.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
