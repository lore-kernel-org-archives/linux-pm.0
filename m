From: Betty Dall <betty.dall@hp.com>
Subject: Re: [PATCH 7/7] tools/power turbostat: print Watts
Date: Thu, 15 Nov 2012 13:50:46 -0700
Message-ID: <1353012646.3055.25.camel@ejdallLaptop>
References: <39300ffb9b6666714c60735cf854e1280e4e75f4.1352925508.git.len.brown@intel.com>
	 <f3c7bfa850840c6c96a26796786ffdc7761519ef.1352925508.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f3c7bfa850840c6c96a26796786ffdc7761519ef.1352925508.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2012-11-14 at 15:43 -0500, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
...

> @@ -1644,7 +1967,7 @@ int main(int argc, char **argv)
>  	cmdline(argc, argv);
>  
>  	if (verbose > 1)
> -		fprintf(stderr, "turbostat v2.1 October 6, 2012"
> +		fprintf(stderr, "turbostat v3.0 November 14, 2012"
>  			" - Len Brown <lenb@kernel.org>\n");
>  
>  	turbostat_init();

I applied these 7 patches in order to a the upstream kernel and this
last hunk was rejected:

$ cat turbostat.c.rej
--- tools/power/x86/turbostat/turbostat.c
+++ tools/power/x86/turbostat/turbostat.c
@@ -1967,7 +2290,7 @@
 	cmdline(argc, argv);
 
 	if (verbose > 1)
-		fprintf(stderr, "turbostat v2.1 October 6, 2012"
+		fprintf(stderr, "turbostat v3.0 November 14, 2012"
 			" - Len Brown <lenb@xxxxxxxxxx>\n");
 
 	turbostat_init();


-Betty
