From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Bisected] 3.7-rc1 can't resume
Date: Sat, 23 Feb 2013 13:54:19 -0800
Message-ID: <51293A8B.5060107@zytor.com>
References: <20130218155439.GA902@onny> <cfd96a3d-5834-4687-b9de-9f044f43b588@email.android.com> <20130223131856.GA682@onny>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:42965 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759258Ab3BWVzr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 23 Feb 2013 16:55:47 -0500
In-Reply-To: <20130223131856.GA682@onny>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonas Heinrich <onny@project-insanity.org>
Cc: len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 02/23/2013 05:18 AM, Jonas Heinrich wrote:
> Hi,
> thank you for your replay and the effort you invest in helping me out
> with this problem.
> Today, I further debuged the problem and reverted this part of your commit
> (without understanding the actual code):
>

Hi, that commit is indeed buggy, but it has already been fixed; commit
1396adc3c2bdc556d4cdd1cf107aa0b6d59fbb1e contains the fix.

So to bisect anything between 73201dbec64aebf6b0dca855b523f437972dc7bb 
and 1396adc3c2bdc556d4cdd1cf107aa0b6d59fbb1e in a meaningful way you 
will have to apply 1396adc3c2bdc556d4cdd1cf107aa0b6d59fbb1e on top.

If 73201dbec64aebf6b0dca855b523f437972dc7b with 
1396adc3c2bdc556d4cdd1cf107aa0b6d59fbb1e on top fails whereas the 
previous one does, then that is very interesting and something we can 
work with.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

