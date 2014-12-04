From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v7 08/11] arm/arm64: Unexport restart handlers
Date: Thu, 04 Dec 2014 16:06:22 +0100
Message-ID: <3875532.ABOh5kXkPb@wuerfel>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net> <CAMuHMdX-WsVErpiZ_EbFSGxeJEfpu3cRaZzitupiSAA2hXEJ8g@mail.gmail.com> <54807505.2000406@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54807505.2000406-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Watchdog Mailing List <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, Jonas Jensen <jonas.jensen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel@lists
List-Id: linux-pm@vger.kernel.org

On Thursday 04 December 2014 06:51:49 Guenter Roeck wrote:
> On 12/04/2014 06:44 AM, Geert Uytterhoeven wrote:
> > On Thu, Dec 4, 2014 at 3:26 PM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> >> On 12/04/2014 05:36 AM, Geert Uytterhoeven wrote:
> >>> On Wed, Aug 20, 2014 at 2:45 AM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> >>>> Implementing a restart handler in a module don't make sense
> >>>> as there would be no guarantee that the module is loaded when
> >>>> a restart is needed. Unexport arm_pm_restart to ensure that
> >>>> no one gets the idea to do it anyway.
> >>>
> >>> Why not? I was just going to do that, but I got greeted by:
> >>
> >> Because you should register a restart handler instead, like the other
> >> drivers in the same directory now do.
> >
> > That's a different thing. "there would be no guarantee that the module is
> > loaded when a restart is needed" is also valid for restart handlers...
> >
> 
> Not really, because you are supposed to unregister the restart handler
> on unload. Sure, you can instead clear arm_pm_reastart and leave the system
> with no means to restart ...

I agree with Geert that your commit message was confusing, it sounds like
you were referring to drivers that are not yet loaded, while the problem
that you are really address is drivers that have been unloaded later.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
