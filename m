From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI PCC probe failed.
Date: Wed, 04 Feb 2015 14:48:02 +0100
Message-ID: <158128306.gX9FjqECDu@vostro.rjw.lan>
References: <CABwnbUkGNJEZkW5bL9pXvcZwqz4fZKiub_-vTRDLp=FeiQq8cw@mail.gmail.com> <3337572.5q6DLI5fhi@vostro.rjw.lan> <CABwnbUmOwf1VGwD0i9AW12No6nueHda+M7NnhX87uRLwKzw=aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CABwnbUmOwf1VGwD0i9AW12No6nueHda+M7NnhX87uRLwKzw=aA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Cristian <caravena@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: linux-acpi@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 03, 2015 09:44:36 PM Cristian wrote:
> 2015-02-03 12:11 GMT-03:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> > On Tuesday, February 03, 2015 10:40:00 AM Cristian wrote:
> >> Hello,
> >>
> >> linux 3.19-rc7
> >> Ubuntu Vivid 14.04 alpha
> >>
> >> dmesg:
> >> [    1.293820] ACPI PCC probe failed.
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=92551
> >
> > Is that a functional problem or just the message?
> >
> >
> > --
> > I speak only for myself.
> > Rafael J. Wysocki, Intel Open Source Technology Center.
> 
> Apparently one message.

So it looks like you build the PCC mailbox driver which is new in 3.19-rc and
that driver fails to load, because it doesn't find hardware to work with.

The message is harmless, but it also is not useful.  The driver in question
seems to be overly verbose to me in general.

The patch below should make the message go away unless the printing of debug
messages is on.

Ashwin, that whole thing requires cleaning up:
 - It prints uninteresting debug messages with KERN_ERR or warning priority in
   *many* places.
 - The error codes from acpi_pcc_probe() are ignored, so why bother to return
   any error codes from there?
 - If platform_create_bundle() fails, the debug message doesn't tell us the
   reason, so why bother to print it?

I'm not going to consider any users of this for merging before that cleanup
happens.

Rafael


---
 drivers/mailbox/pcc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/mailbox/pcc.c
===================================================================
--- linux-pm.orig/drivers/mailbox/pcc.c
+++ linux-pm/drivers/mailbox/pcc.c
@@ -386,7 +386,7 @@ static int __init pcc_init(void)
 	ret = acpi_pcc_probe();
 
 	if (ret) {
-		pr_err("ACPI PCC probe failed.\n");
+		pr_debug("ACPI PCC probe failed.\n");
 		return -ENODEV;
 	}
 
@@ -394,7 +394,7 @@ static int __init pcc_init(void)
 			pcc_mbox_probe, NULL, 0, NULL, 0);
 
 	if (!pcc_pdev) {
-		pr_err("Err creating PCC platform bundle\n");
+		pr_debug("Err creating PCC platform bundle\n");
 		return -ENODEV;
 	}
 

