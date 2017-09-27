From: Oliver Neukum <oneukum@suse.com>
Subject: Re: Huawei integrated modem causes instant resume from suspend on
 Acer P648-G3
Date: Wed, 27 Sep 2017 09:12:59 +0200
Message-ID: <1506496379.28482.1.camel@suse.com>
References: <20170927061446.15512-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58597 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751021AbdI0HNH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Sep 2017 03:13:07 -0400
In-Reply-To: <20170927061446.15512-1-drake@endlessm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux@endlessm.com

Am Mittwoch, den 27.09.2017, 14:14 +0800 schrieb Daniel Drake:
> There are no errors in the logs showing any suspend/resume-related issues.
> When the system wakes up due to the modem, log-wise it appears to be a
> normal resume.
> 
> Does anyone have any suggestions for how we can investigate further, or how
> we should workaround this issue in upstreamable form?

Hi,

unfortunately you left out the most important information

1) kernel version?
2) driver used?
3) device descriptors (lsusb)
4) s2idle or S3?

	Regards
		Oliver
