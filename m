From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V1 Resend 02/11] PM / OPP: Drop unlikely before
 IS_ERR(_OR_NULL)
Date: Mon, 10 Aug 2015 23:15:10 +0200
Message-ID: <20150810211510.GA5553@amd>
References: <cover.1439187003.git.viresh.kumar@linaro.org>
 <c3394808aef37f65b0fa2db650cf0cf1bfcaa970.1439187003.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38939 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932741AbbHJVPN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 17:15:13 -0400
Content-Disposition: inline
In-Reply-To: <c3394808aef37f65b0fa2db650cf0cf1bfcaa970.1439187003.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: akpm@linux-foundation.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Mon 2015-08-10 11:42:24, Viresh Kumar wrote:
> IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
> is no need to do that again from its callers. Drop it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
