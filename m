From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PowerCap: Error with option -Werror=format-security
Date: Tue, 05 Nov 2013 15:25:38 +0100
Message-ID: <17745805.W16rbqgmuH@vostro.rjw.lan>
References: <1383583990-9618-1-git-send-email-srinivas.pandruvada@linux.intel.com> <CAGXu5jJeixN6bAJh6KJWExyKiyJHFsFWboL7Z0Xtn2F-71zg5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65046 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754831Ab3KEONU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2013 09:13:20 -0500
In-Reply-To: <CAGXu5jJeixN6bAJh6KJWExyKiyJHFsFWboL7Z0Xtn2F-71zg5w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux-Next <linux-next@vger.kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

On Monday, November 04, 2013 11:51:25 AM Kees Cook wrote:
> On Mon, Nov 4, 2013 at 8:53 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > Fix compile error with gcc option: -Werror=format-security for
> > dev_set_name(&control_type->dev, name)
> > Changed to
> > dev_set_name(&control_type->dev, "%s", name);
> >
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/powercap/powercap_sys.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> > index 21814f9..8d0fe43 100644
> > --- a/drivers/powercap/powercap_sys.c
> > +++ b/drivers/powercap/powercap_sys.c
> > @@ -625,7 +625,7 @@ struct powercap_control_type *powercap_register_control_type(
> >         control_type->ops = ops;
> >         INIT_LIST_HEAD(&control_type->node);
> >         control_type->dev.class = &powercap_class;
> > -       dev_set_name(&control_type->dev, name);
> > +       dev_set_name(&control_type->dev, "%s", name);
> >         result = device_register(&control_type->dev);
> >         if (result) {
> >                 if (control_type->allocated)
> > --
> > 1.7.11.7
> 
> Thanks for getting this fixed!
> 
> Acked-by: Kees Cook <keescook@chromium.org>

Queued up for 3.13, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
