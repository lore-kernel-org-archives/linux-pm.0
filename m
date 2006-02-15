From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Wed, 15 Feb 2006 16:04:45 +0100
Message-ID: <43F3430D.1010002@suse.de>
References: <20060208125753.GA25562@srcf.ucam.org> <20060210121913.GA4974@elf.ucw.cz> <43F216FE.7050101@suse.de> <200602142117.31232.rjw@sisk.pl> <43F3206B.6090902@suse.de> <20060215124729.GA10968@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20060215124729.GA10968@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>, linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Matthew Garrett wrote:
> On Wed, Feb 15, 2006 at 01:36:59PM +0100, Thomas Renninger wrote:
> 
>> Maybe I oversaw an issue, but I really don't see a reason for connecting
>> the brightness to ac in kernel space.
> 
> The backlight class maintainer specified that /sys/../brightness should 
Who's that? Is there more info/spec available?
> return the *current* brightness. In some cases that's impossible without 
> knowing the ac status.
> 
Ok.
The ac/battery status is used to guess the current brightness? Please
do not set suggested values automatically, IMO this is not a nice feature...
I am really looking forward to see a general /sys/../brightness.
Thanks a lot for working on this!
Just an idea for later:
Beside min/max there probably should be a /sys/../brightness_bat 
and /sys/../brightness_ac.
- If ac/battery brightness will not be set by kernel, userspace can write the
  right value to /sys/../brightness and the above two can be readonly.
- If ac/battery brightness will be set by kernel the above two should even be
  writeable so that people can avoid the need of pressing "brightness up"
  button without hacking the kernel.

I vote for letting userspace doing the stuff..., e.g. changing brightness behind
the back of some userspace tool will result in userspace tools starting to
poll.

Comments?

    Thomas

