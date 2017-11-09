From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: bq2415x_charger: Use common error handling code in
 bq2415x_timer_work()
Date: Thu, 9 Nov 2017 14:14:33 +0100
Message-ID: <20171109131433.x7xuh4bqvqm72wb5@pali>
References: <48b34d35-8c41-d25b-0cb7-6257b37c5a44@users.sourceforge.net>
 <20171109120842.GA28552@atrey.karlin.mff.cuni.cz>
 <d680ca7e-9806-1f39-80da-58fa7239a31c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:52174 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbdKINOg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2017 08:14:36 -0500
Content-Disposition: inline
In-Reply-To: <d680ca7e-9806-1f39-80da-58fa7239a31c@users.sourceforge.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Thursday 09 November 2017 14:04:19 SF Markus Elfring wrote:
> > Better fix would be to display separate messages; user is probably
> > interested in what failed...
> 
> Which information (or wording) would you find more appropriate
> at these places?

Hi! Basically dropping your patch and instead of the "Unknown error"
return to user reason why BQ2415X_BOOST_MODE_STATUS or
BQ2415X_FAULT_STATUS commands failed. Or at least instead of the
"Unknown error" write "Unknown error during BQ2415X_FAULT_STATUS".

Basically I do not see any value in your patch. Current coding style
pattern in that function is:

do_something;
if failed:
  print error;
  return;

And your patch just changed some, but not *all* parts of code to:

do_something;
if failed:
  goto end_of_function

If you are changing coding style, I would really suggest to change it on
all places to let it consistent. Because your change introduces just
inconsistency.

-- 
Pali Rohár
pali.rohar@gmail.com
