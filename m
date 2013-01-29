From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] mailbox: prevent pl320-ipc code from breaking none-AMBA systems
Date: Wed, 30 Jan 2013 00:11:53 +0100
Message-ID: <27770386.tfMWkOKqd2@vostro.rjw.lan>
References: <1359477413-27881-1-git-send-email-mark.langsdorf@calxeda.com> <1807311.dyJeq56cRL@vostro.rjw.lan> <21672683C5A3814BB4DB938EBE482DE435D976610A@IAD2MBX09.mex02.mlsrvr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <21672683C5A3814BB4DB938EBE482DE435D976610A@IAD2MBX09.mex02.mlsrvr.com>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 29, 2013 05:13:09 PM Mark Langsdorf wrote:
> > From: Rafael J. Wysocki [rjw@sisk.pl]
> > On Tuesday, January 29, 2013 10:36:53 AM Mark Langsdorf wrote:
> > > The pl320-ipc code depends on ARM AMBA, and should have the dependency
> > > in its Kconfig.
> > 
> > May I fold this into "ARM / highbank: add support for pl320 IPC"?
> 
> Yes. I didn't want to regenerate the patch series =)

Done.

Thanks,
Rafael


> > Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> > ---
> >  drivers/mailbox/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> > index 9489554..9545c9f 100644
> > --- a/drivers/mailbox/Kconfig
> > +++ b/drivers/mailbox/Kconfig
> > @@ -8,6 +8,7 @@ menuconfig MAILBOX
> >  if MAILBOX
> >  config PL320_MBOX
> >       bool "ARM PL320 Mailbox"
> > +     depends on ARM_AMBA
> >       help
> >         An implementation of the ARM PL320 Interprocessor Communication
> >         Mailbox (IPCM), tailored for the Calxeda Highbank. It is used to
> >
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
