From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: bq2415x_charger: Use common error handling code in
 bq2415x_timer_work()
Date: Thu, 9 Nov 2017 14:04:19 +0100
Message-ID: <d680ca7e-9806-1f39-80da-58fa7239a31c@users.sourceforge.net>
References: <48b34d35-8c41-d25b-0cb7-6257b37c5a44@users.sourceforge.net>
 <20171109120842.GA28552@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:53615 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752678AbdKINE0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Nov 2017 08:04:26 -0500
In-Reply-To: <20171109120842.GA28552@atrey.karlin.mff.cuni.cz>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

> Better fix would be to display separate messages; user is probably
> interested in what failed...

Which information (or wording) would you find more appropriate
at these places?

Regards,
Markus
