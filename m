From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Bisected] 3.7-rc1 can't resume (still present in 3.9)
Date: Wed, 01 May 2013 10:33:17 -0700
Message-ID: <518151DD.106@zytor.com>
References: <20130218155439.GA902@onny> <cfd96a3d-5834-4687-b9de-9f044f43b588@email.android.com> <20130223131856.GA682@onny> <51293A8B.5060107@zytor.com> <20130320143257.GA473@onny> <20130501170118.GB488@onny>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:46148 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab3EARdu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 May 2013 13:33:50 -0400
In-Reply-To: <20130501170118.GB488@onny>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonas Heinrich <onny@project-insanity.org>
Cc: len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 05/01/2013 10:01 AM, Jonas Heinrich wrote:
> Hello, I tried the newest kernel, 3.9 today but the bug is still
> present. Applying the attached patch solves the bug for me.
> 
> Best regards, Jonas Heinrich

Okay... WTF is going on here?  Does pmode_behavior just not get set up
correctly?  Since it seems you can get it to wake up with your patch,
perhaps we can get read out the value of pmode_behavior and print it...

	-hpa


