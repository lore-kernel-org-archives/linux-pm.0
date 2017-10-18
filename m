From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v3] USB: Force disconnect Huawei 4G modem during suspend
Date: Wed, 18 Oct 2017 11:31:20 +0200
Message-ID: <1508319080.8211.2.camel@suse.com>
References: <20171018071501.4900-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38183 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934218AbdJRJfJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Oct 2017 05:35:09 -0400
In-Reply-To: <20171018071501.4900-1-drake@endlessm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>, gregkh@linuxfoundation.org
Cc: chiu@endlessm.com, linux@endlessm.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org

Am Mittwoch, den 18.10.2017, 15:15 +0800 schrieb Daniel Drake:
> Notes:
>     v2:
>     - Handle quirk later in suspend, to avoid interfering with other parts
>       of the suspend routine.
>     - Don't do the disconnect on runtime suspend, only for S3 suspend

Hi,

well, can we effectively runtime suspend these devices?
Furthermore, it seems to me that we indeed cannot do a runtime
suspend on external devices needing this quirk, but what about
internal devices?
And if we cannot do runtime suspend, should we not block it?

	Regards
		Oliver
