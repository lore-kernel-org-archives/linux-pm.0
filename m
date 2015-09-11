From: Arjun Sreedharan <arjun024@gmail.com>
Subject: Re: [PATCH] cpupower: fix potential memory leak
Date: Sat, 12 Sep 2015 01:21:09 +0530
Message-ID: <CAJFMrCH_sq9d6R_rN3MA2H7gFYUgMB+XqMfwtg_UpyLGRjPV9w@mail.gmail.com>
References: <1440244862-7255-1-git-send-email-arjun024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34177 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbbIKTvd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 15:51:33 -0400
In-Reply-To: <1440244862-7255-1-git-send-email-arjun024@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Ping !

On 22 August 2015 at 17:31, Arjun Sreedharan <arjun024@gmail.com> wrote:
> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
> ---
>  tools/power/cpupower/bench/parse.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
> index f503fb5..058a351 100644
> --- a/tools/power/cpupower/bench/parse.c
> +++ b/tools/power/cpupower/bench/parse.c
> @@ -65,7 +65,7 @@ FILE *prepare_output(const char *dirname)
>  {
>         FILE *output = NULL;
>         int len;
> -       char *filename;
> +       char *filename, *filename_tmp;
>         struct utsname sysdata;
>         DIR *dir;
>
> @@ -80,17 +80,19 @@ FILE *prepare_output(const char *dirname)
>         }
>
>         len = strlen(dirname) + 30;
> -       filename = malloc(sizeof(char) * len);
> +       filename = malloc(sizeof(*filename) * len);
>
>         if (uname(&sysdata) == 0) {
>                 len += strlen(sysdata.nodename) + strlen(sysdata.release);
> -               filename = realloc(filename, sizeof(char) * len);
> +               filename_tmp = realloc(filename, sizeof(*filename) * len);
>
> -               if (filename == NULL) {
> +               if (filename_tmp == NULL) {
> +                       free(filename);
>                         perror("realloc");
>                         return NULL;
>                 }
>
> +               filename = filename_tmp;
>                 snprintf(filename, len - 1, "%s/benchmark_%s_%s_%li.log",
>                         dirname, sysdata.nodename, sysdata.release, time(NULL));
>         } else {
> --
> 2.4.5
>



-- 
Arjun Sreedharan
arjunsreedharan.org
