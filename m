From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/4] hibernate: fix disk and module leak on successfull resume
Date: Wed, 03 Feb 2016 02:37:27 +0100
Message-ID: <2052409.7mYyWn9zFL@vostro.rjw.lan>
References: <1454338315-13465-1-git-send-email-roman.penyaev@profitbricks.com> <1454338315-13465-5-git-send-email-roman.penyaev@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54052 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752733AbcBCBg0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 20:36:26 -0500
In-Reply-To: <1454338315-13465-5-git-send-email-roman.penyaev@profitbricks.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Gi-Oh Kim <gi-oh.kim@profitbricks.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, February 01, 2016 03:51:55 PM Roman Pen wrote:
> Do not forget to put the disk back.
> 
> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> Cc: Gi-Oh Kim <gi-oh.kim@profitbricks.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  kernel/power/hibernate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index b7342a2..1f53dc2 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -785,8 +785,11 @@ static int software_resume(void)
>  	 */
>  	if (isdigit(resume_file[0]) && resume_wait) {
>  		int partno;
> -		while (!get_gendisk(swsusp_resume_device, &partno))
> +		struct gendisk *disk;
> +
> +		while (!(disk = get_gendisk(swsusp_resume_device, &partno)))
>  			msleep(10);
> +		put_gendisk(disk);
>  	}
>  
>  	if (!swsusp_resume_device) {
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
