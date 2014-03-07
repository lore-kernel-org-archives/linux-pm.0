From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 6/7] Cpuidle: Deal with timer expiring in the past
Date: Thu, 6 Mar 2014 22:09:17 -0500
Message-ID: <CAJvTdKms3LNZfQ82CofNdtPKtFyEz6XtJGEfMWQDVLEvurkijw@mail.gmail.com>
References: <1393223377-5744-1-git-send-email-tuukka.tikkanen@linaro.org>
	<1393223377-5744-7-git-send-email-tuukka.tikkanen@linaro.org>
	<CAJvTdKneVk_ToJ=Sv4GnMfn5a0r=ynfL4fRLOoKHsqMrDYr8JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJvTdKneVk_ToJ=Sv4GnMfn5a0r=ynfL4fRLOoKHsqMrDYr8JA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

NAK

tick_nohz_get_sleep_length() has exactly 1 consumer -- cpuidle.

Rather than have cpuidle second guess what is returned,
tick_nohz_get_sleep_length() should be updated to return a value
that makes sense to cpuidle.

thanks,
Len Brown, Intel Open Source Technology Cent
