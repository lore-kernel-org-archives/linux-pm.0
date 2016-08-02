From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0077/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 14:42:56 +0200
Message-ID: <20160802124256.GA25315@amd>
References: <20160802103855.18883-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40636 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935091AbcHBMnB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2016 08:43:01 -0400
Content-Disposition: inline
In-Reply-To: <20160802103855.18883-1-baolex.ni@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com

On Tue 2016-08-02 18:38:55, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>

Sorry, the macros just make it _less_ readable, because you do chmod
666, not chmod S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH.

NAK.
							Pavel
							
> -static DEVICE_ATTR(control, 0644, control_show, control_store);
> +static DEVICE_ATTR(control, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, control_show, control_store);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
