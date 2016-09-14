From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][v2] PM / sleep: Increase default DPM watchdog timeout to 120
Date: Wed, 14 Sep 2016 03:05:44 +0200
Message-ID: <8853207.pbmSBV8iSz@vostro.rjw.lan>
References: <1471581443-22184-1-git-send-email-yu.c.chen@intel.com> <20160819071955.GA2450@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160819071955.GA2450@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, August 19, 2016 09:19:55 AM Pavel Machek wrote:
> On Fri 2016-08-19 12:37:23, Chen Yu wrote:
> > Recently we have a new report that, the harddisk can not
> > resume on time due to firmware issues, and got a kernel
> > panic because of DPM watchdog timeout. So adjust the
> > default timeout from 60 to 120 to survive on this platform,
> > and make DPM_WATCHDOG depending on EXPERT.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=117971
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Patch applied.

Thanks,
Rafael
