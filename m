From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH pm] PM / hibernate: swsusp_page_is_valid() can be static
Date: Tue, 14 Jul 2015 12:12:43 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6402F9CE9@SHSMSX101.ccr.corp.intel.com>
References: <201507141612.6eLYehfL%fengguang.wu@intel.com>
 <20150714082338.GA66904@snb>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150714082338.GA66904@snb>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Wu, Fengguang" <fengguang.wu@intel.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Wu, Fengguang
> Sent: Tuesday, July 14, 2015 4:24 PM
> To: Chen, Yu C
> Cc: kbuild-all@01.org; Rafael J. Wysocki; Lee, Chun-Yi; linux-
> pm@vger.kernel.org; Pavel Machek; Brown, Len; linux-
> kernel@vger.kernel.org
> Subject: [PATCH pm] PM / hibernate: swsusp_page_is_valid() can be static
> 
> 
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>  snapshot.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c index
> ebbb995..0e4112f4 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -925,7 +925,7 @@ static void swsusp_unset_page_forbidden(struct
> page *page)
>  		memory_bm_clear_bit(forbidden_pages_map,
> page_to_pfn(page));  }
> 
> -int swsusp_page_is_valid(struct page *page)
> +static int swsusp_page_is_valid(struct page *page)
>  {
>  	return valid_pages_map ?
>  		memory_bm_test_bit(valid_pages_map,
> page_to_pfn(page)) : 0;
OK, thanks Fengguang



Best Regards,
Yu
