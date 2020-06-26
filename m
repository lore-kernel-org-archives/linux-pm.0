Return-Path: <SRS0=MKj8=AH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3D5C433DF
	for <linux-pm@archiver.kernel.org>; Fri, 26 Jun 2020 15:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07168207E8
	for <linux-pm@archiver.kernel.org>; Fri, 26 Jun 2020 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593186579;
	bh=4knNSS/CwU+90oAn5cWqpVGITLx0/+fHD7HbP1ut23Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=It8BZqJNLabFJgbKOHEE3Hwy6x+JjgzozevuPLWxG4WPBAcILuqdukOhsk3AStYeR
	 WAgLPhQg5093klhMPRIB81+QqE7/CCcnCgY5Twbdwagt6VSEQVcpYhw5Ik8BTVyljw
	 Zp1O1S8vIEXnWmJHCvPPSC+riFitHvWJXRWXB0q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgFZPth (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:49:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38860 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgFZPth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 11:49:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id r8so8444931oij.5;
        Fri, 26 Jun 2020 08:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KjUbu0zXqV6UXI5AcJGWUkK1HoxHXhpiqasUK9nCWE0=;
        b=bfM9Iso7LhnU5jlrjzBFHWtT401AwqKBRJxKP0rTkbqLjKH7Rzx0t3AX9tstF+GKwR
         LQp4kDunQ8iQ1XIKPdWRBbu4Fa9zD62aLUnqJfA5BdPXtsiJNZ92pVgtrZAIIHJPjtgc
         w/rh2kmW1U6xCvh/tpkvHyLwCb6452T1riya+PgwZmE5GYV68b2lsrCdca1QMpr1zUzr
         3NWpfGCsIkJX7Cf0Ll/zKLO4k9rFYSWeUjbO4eVUohrzhBtgnmKfnKnocyAA5CYns3To
         vq96q/zQJXEJJqM4LqXbTnKgDsL8xs8mkEKVnU+lsDiEMNjgAfuOjewnMJi2f3HY6joZ
         WVaQ==
X-Gm-Message-State: AOAM533nKaofuuPJehPc3H4ocIufltSnx8m7hX5ulkTMvz0lLvPONVPc
        pUmYH385YTIJ8Sg6zgYUzhEGzPHkuJLyBOv5chw=
X-Google-Smtp-Source: ABdhPJzF29EHzCYbhXZOQiMmBGqCDbEVYzf0yT6LpjaTi+/OOZ29wvayMBJ56u7AiFHEMyA6ntW6JA0ptSQyUflWCxU=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr3044049oia.103.1593186577071;
 Fri, 26 Jun 2020 08:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200625224931.1468150-1-srinivas.pandruvada@linux.intel.com>
 <20200626084903.GA27151@zn.tnic> <20200626102255.GZ4817@hirez.programming.kicks-ass.net>
 <20200626104442.GF117543@hirez.programming.kicks-ass.net>
In-Reply-To: <20200626104442.GF117543@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Jun 2020 17:49:26 +0200
Message-ID: <CAJZ5v0iDuF1bPud=97qwhp3iy+CCrbGz7ZBSuFgTe4So1Kv+cQ@mail.gmail.com>
Subject: Re: [PATCH] lib: Extend kstrtobool() to accept "true"/"false"
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, jic23@cam.ac.uk,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 26, 2020 at 12:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 26, 2020 at 12:22:55PM +0200, Peter Zijlstra wrote:
>
> > > This is too lax - it will be enabled for any !0 value. Please accept
> > > only 0 and 1.
> >
> > kstrtobool() ftw
>
> And looking at that, I find it really strange it does not in fact accept
> "true" / "false", so how about this?
>
> ---
> Subject: lib: Extend kstrtobool() to accept "true"/"false"
>
> Extend the strings recognised by kstrtobool() to cover:
>
>   - 1/0
>   - y/n
>   - yes/no      (new)
>   - t/f         (new)
>   - true/false  (new)
>   - on/off
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  lib/kstrtox.c | 60 ++++++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 15 deletions(-)
>
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 1006bf70bf74..b8b950325097 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -325,9 +325,17 @@ EXPORT_SYMBOL(kstrtos8);
>   * @s: input string
>   * @res: result
>   *
> - * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
> - * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
> - * pointed to by res is updated upon finding a match.
> + * This return return 0 on success, otherwise it will return -EINVAL.
> + * It will accept (case invariant):
> + *
> + *  - 1/0
> + *  - y/n
> + *  - yes/no
> + *  - t/f
> + *  - true/false
> + *  - on/off
> + *
> + * and set @*res to either true/false respectively.
>   */
>  int kstrtobool(const char *s, bool *res)
>  {
> @@ -335,30 +343,52 @@ int kstrtobool(const char *s, bool *res)
>                 return -EINVAL;
>
>         switch (s[0]) {
> +       case 't':
> +       case 'T':
> +               if (!s[1] || !strcasecmp(s, "true"))
> +                       goto have_true;
> +
> +               break;
> +
>         case 'y':
>         case 'Y':
> +               if (!s[1] || !strcasecmp(s, "yes"))
> +                       goto have_true;
> +
> +               break;
> +
>         case '1':
> +have_true:
>                 *res = true;
>                 return 0;
> +
> +       case 'f':
> +       case 'F':
> +               if (!s[1] || !strcasecmp(s, "false"))
> +                       goto have_false;
> +
> +               break;
>         case 'n':
>         case 'N':
> +               if (!s[1] || !strcasecmp(s, "no"))
> +                       goto have_false;
> +
> +               break;
>         case '0':
> +have_false:
>                 *res = false;
>                 return 0;
> +
>         case 'o':
>         case 'O':
> -               switch (s[1]) {
> -               case 'n':
> -               case 'N':
> -                       *res = true;
> -                       return 0;
> -               case 'f':
> -               case 'F':
> -                       *res = false;
> -                       return 0;
> -               default:
> -                       break;
> -               }
> +               if (!strcasecmp(s, "on"))
> +                       goto have_true;
> +
> +               if (!strcasecmp(s, "off"))
> +                       goto have_false;
> +
> +               break;
> +
>         default:
>                 break;
>         }
