From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
Subject: Re: [PATCH v12 1/4] battery: Add the battery hooking API
Date: Thu, 4 Jan 2018 12:13:13 +0100
Message-ID: <20180104111313.GA12286@thinkpad>
References: <20180103115847.GA10092@thinkpad>
 <CAHp75Vdj2rasWqdmBKGxNs9Y+Rap=UycoFdOcbG6QgA48Afq5w@mail.gmail.com>
 <20180103145307.GA17694@thinkpad>
 <CAHp75VceXVb2N7hyjoDhAq_M+=2VcDcPc+Jt-FSsWuW7D7eFww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VceXVb2N7hyjoDhAq_M+=2VcDcPc+Jt-FSsWuW7D7eFww@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 03, 2018 at 06:40:12PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 3, 2018 at 4:53 PM, Ognjen Galić <smclt30p@gmail.com> wrote:
> > On Wed, Jan 03, 2018 at 04:25:42PM +0200, Andy Shevchenko wrote:
> >> On Wed, Jan 3, 2018 at 1:58 PM, Ognjen Galic <smclt30p@gmail.com> wrote:
> 
> >> Thanks for an update. I have couple of minors. Otherwise look pretty much good!
> >>
> >> >  drivers/acpi/battery.h |  11 ----
> >> >  include/acpi/battery.h |  21 +++++++
> >>
> >> There are -M and -C command line parameters to git format-patch.
> 
> >> They can take an optional argument (percentage) of threshold.
> >>
> >> Playing with those numbers you can achieve
> 
> ^^^^ Pay attention to the above
> 
> >>
> >> rename ...
> >>
> >> line and see actual diff.
> >>
> >> No need to resend because of this. Just an explanation for the future Git work.
> >
> > I did use thos options. I used the following command:
> >
> > git format-patch -M -C --notes -v12 -o ~/patches/. @^^^^
> >
> > I really don't know what you are targeting. :)
> 
> Please, read what I wrote above and the manual of git-format-patch.
> 
> >> > +void __battery_hook_unregister(struct acpi_battery_hook *hook, int lock)
> >> > +{
> >> > +       struct list_head *position;
> >> > +       struct acpi_battery *battery;
> >>
> >> Missed empty line?
> >
> > checkpatch.pl complains if there are NOT empty lines between
> > declarations and statements.
> 
> checkpatch some times on one hand complains about something which it
> should not, on the other didn't take into consideration cases like
> this one.
> 
> Your statement started with comment, btw.
> 
> >> > +       /*
> >> > +        * In order to remove a hook, we first need to
> >> > +        * de-register all the batteries that are registered.
> >> > +        */
> >> > +       if (lock)
> >> > +               mutex_lock(&hook_mutex);
> 
> > I mean, it's not game-breaking, its just minor style stuff. I won't be
> > sending more revisions because of these small issues, as I think its
> > uneccessary to flood both Rafael and the mailing lists with patch
> > revisions that remove or add a few spaces. No offence, it just got old.
> 
> Yes, his call anyway to apply or ask you for amendments. I'm just
> helping with review.

Rafael, what do you think? Do you want these style/syntax issues fixed
or is it good to go?

Thanks for the time to review Andy! You are a champ! :)

> 
> >> > +static void __exit battery_hook_exit(void)
> >> > +{
> >> > +       struct acpi_battery_hook *hook;
> >> > +       struct acpi_battery_hook *ptr;
> >>
> >> Missed empty line?
> >
> > See above about the checkpatch.pl stuff.
> 
> See above the answer.
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
