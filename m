From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: bq2415x_charger: Use common error handling code in
 bq2415x_timer_work()
Date: Thu, 9 Nov 2017 14:22:18 +0100
Message-ID: <935e992c-e5ee-841b-c42a-4a7bf891d984@users.sourceforge.net>
References: <48b34d35-8c41-d25b-0cb7-6257b37c5a44@users.sourceforge.net>
 <20171109120842.GA28552@atrey.karlin.mff.cuni.cz>
 <d680ca7e-9806-1f39-80da-58fa7239a31c@users.sourceforge.net>
 <20171109131433.x7xuh4bqvqm72wb5@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109131433.x7xuh4bqvqm72wb5@pali>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

>> Which information (or wording) would you find more appropriate
>> at these places?
> 
> Hi! Basically dropping your patch and instead of the "Unknown error"
> return to user reason why BQ2415X_BOOST_MODE_STATUS or
> BQ2415X_FAULT_STATUS commands failed. Or at least instead of the
> "Unknown error" write "Unknown error during BQ2415X_FAULT_STATUS".

Can the error description become better?

Regards,
Markus
