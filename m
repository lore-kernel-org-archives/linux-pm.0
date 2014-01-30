From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 2/2] PM / Hibernate: use name_to_dev_t to parse
 resume
Date: Thu, 30 Jan 2014 19:01:44 +0100
Message-ID: <20140130180144.GB16503@amd.pavel.ucw.cz>
References: <1391039304-3172-1-git-send-email-sebastian.capella@linaro.org>
 <1391039304-3172-3-git-send-email-sebastian.capella@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33149 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaA3SBp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2014 13:01:45 -0500
Content-Disposition: inline
In-Reply-To: <1391039304-3172-3-git-send-email-sebastian.capella@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed 2014-01-29 15:48:24, Sebastian Capella wrote:
> Use the name_to_dev_t call to parse the device name echo'd to
> to /sys/power/resume.  This imitates the method used in hibernate.c
> in software_resume, and allows the resume partition to be specified
> using other equivalent device formats as well.  By allowing
> /sys/debug/resume to accept the same syntax as the resume=device
> parameter, we can parse the resume=device in the init script and
> use the resume device directly from the kernel command line.
> 
> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
