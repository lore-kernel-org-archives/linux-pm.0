From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: 4.1-rc7, thinkpad X60: platform mode hibernation does very
 wrongthing
Date: Wed, 17 Jun 2015 16:02:34 +0200
Message-ID: <1434549754.2400.5.camel@x220>
References: <20150617121352.GA20553@amd> <7336539.OpACL0uN6J@vostro.rjw.lan>
	 <20150617123333.GA21389@amd> <2490787.R6LzZId8tR@vostro.rjw.lan>
	 <20150617131608.GA24030@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150617131608.GA24030@amd>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linus <linus_torvalds@foxmail.com>, lenb <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2015-06-17 at 15:16 +0200, Pavel Machek wrote:
> 3.19 is broken. Some kind of strange 3.17 works ok.
> 
> (On an additional note, x60 fails to boot when "hot" halting at
> 
> "ACPI: All ACPI Tables successfully acquired"
> 
> That was happening before, but it is really annoying for debugging. As
> you do two reboots, machine gets hot enough, and you have to wait to
> cool it down. Any ideas what to do there?)
> 
> I tried no_console_suspend=1, but it still suspended the console.

And this all reminded me of https://lkml.org/lkml/2015/3/18/133 . So I
think that's another system not covered by commit ab3be73fa7b4
("drm/i915: gen4: work around hang during hibernation").

Hope this helps,


Paul Bolle

