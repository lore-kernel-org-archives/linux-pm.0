From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Sun, 12 Feb 2006 11:17:51 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0602121116190.25363@yvahk01.tjqt.qr>
References: <20060208125753.GA25562@srcf.ucam.org> <20060210080643.GA14763@suse.de>
 <20060210121913.GA4974@elf.ucw.cz> <20060210123259.GB18577@suse.de>
 <20060210134638.GA5109@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20060210134638.GA5109@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Stefan Seyfried <seife@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

>> > > Ok. Maybe i am not seeing the point. But why do we need this in the kernel?
>> > > Can't we handles this easily in userspace?
>> > 
>> > Some kernel parts need to now: for example powernow-k8: some
>> 
>> we can tell them from userspace.
>
>No, because battery will explode if you do not slow cpu down fast
>enough.

How is that? APC UPS don't explode either if they are switching to battery.


Jan Engelhardt
-- 
