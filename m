From: David Brownell <david-b@pacbell.net>
Subject: Re: rtc-cmos not supporting RTC_AIE?
Date: Sun, 8 Jul 2007 12:17:52 -0700
Message-ID: <200707081217.53071.david-b__2961.79392976246$1183922326$gmane$org@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707072226.50069.david-b@pacbell.net>
	<20070708190350.GB20078@dmt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070708190350.GB20078@dmt>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-pm@lists.linux-foundation.org, rtc-linux@googlegroups.com, devel@laptop.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday 08 July 2007, Marcelo Tosatti wrote:

> My point is that RTC_ALM_SET after RTC_AIE_ON works with drivers/char/rtc.c
> but not rtc-cmos:
> 
>         ret = ioctl(fd, RTC_AIE_ON);
>         if (ret) {
>                 perror("ioctl RTC_AIE_ON");
>                 exit(0);
>         }
> 
>         ret = ioctl(fd, RTC_ALM_SET, &rtctime);
>         if (ret) {
>                 perror("ioctl RTC_ALM_SET");
>                 exit(0);
>         }
> 
> I think its fine to consider such applications broken anyway?

I think so ... although that's unfortunately another difference
between the legacy x86-mostly code and the newer RTC framework.

Unless enough folk strongly disagree, I'd say this is just something
else to watch out for as part of converting.  Not every quirk got
carried forward.

- Dave
