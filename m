From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
Date: Thu, 29 Mar 2018 23:54:55 +0200
Message-ID: <16373191.Y168Qu1tFx@aspire.rjw.lan>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com> <CADAEsF8j4yfuzDSfyO4VtqSP6rGY2r6L_AEn6MEhhhAUdo+7dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADAEsF8j4yfuzDSfyO4VtqSP6rGY2r6L_AEn6MEhhhAUdo+7dA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, March 29, 2018 9:49:43 AM CEST Ganesh Mahendran wrote:
> ping.
> 
> 2018-03-05 16:47 GMT+08:00 Ganesh Mahendran <opensource.ganesh@gmail.com>:
> > single_open() interface requires that the whole output must
> > fit into a single buffer. This will lead to timeout when
> > system memory is not in a good situation.
> >
> > This patch use seq_open() to show wakeup stats. This method
> > need only one page, so timeout will not be observed.
> 
> We have resolved the watchdog timeout issue by this patch.
> Please help to review.

Sorry for the delay.

I'll have a look tomorrow if possible.

Thanks!
