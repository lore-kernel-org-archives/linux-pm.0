From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCHv v3] power: Include additional information in pm_print_times
Date: Sat, 22 Jun 2013 21:52:52 +0200
Message-ID: <2732229.sfB5fHUFTc@vostro.rjw.lan>
References: <1371497795-20084-1-git-send-email-shuah.kh@samsung.com> <2534796.mOHH0DCD2A@vostro.rjw.lan> <1371868042.2086.0.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371868042.2086.0.camel@joe-AO722>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Shuah Khan <shuah.kh@samsung.com>, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-pm@vger.kernel.org

On Friday, June 21, 2013 07:27:22 PM Joe Perches wrote:
> On Sat, 2013-06-22 at 02:24 +0200, Rafael J. Wysocki wrote:
> > Namely, there are tools that use these messages to create suspend/resume time
> > charts and they will stop working after the proposed changes.
> 
> dmesg output isn't guaranteed to be stable.

So?
