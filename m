From: Ralf Jung <post@ralfj.de>
Subject: Re: [bug?] Battery notifications produce flashing battery icon, syslog spam (Re: [PATCH 11/11] ACPI / Battery: Update information on info notification and resume)
Date: Tue, 1 May 2012 21:42:55 +0200
Message-ID: <201205012142.55664.post@ralfj.de>
References: <201101062331.17079.rjw@sisk.pl> <4FA032EA.1090608@gmail.com> <20120501191408.GD19143@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120501191408.GD19143@burratino>
Sender: linux-acpi-owner@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Adrian Fita <adrian.fita@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Paolo Scarabelli <paolo@msw.it>, Andy Whitcroft <apw@canonical.com>
List-Id: linux-pm@vger.kernel.org

Hi,

in addition to the constant flickering when running on AC, there is a more 
"high frequency" flickering immediately after plugging in the AC: For some 5 
to 10 seconds, the battery appears and disappears (according to upower) around 
once per second. There's also a short moment without battery after plugging 
out the AC.
All this is gone after going to a kernel version without this patch applied.

I did not notice unusual high CPU usage of upower on my system, however I 
noticed disc activity - according to iotop, upower is writing several MiB of 
data per minute to /var/lib/upower/ where it keeps some battery statistics. I 
do not know whether this is out of the ordinary.

Kind regards,
Ralf


On Tuesday 01 May 2012 21:14:08 Jonathan Nieder wrote:
> (cc-ing Andy)
> 
> Adrian Fita wrote:
> > Also, searching on Google after "upowerd device
> > removed:/org/freedesktop/UPower/devices/battery_BAT0", reveals much
> > more bug reports with the exact issue.
> 
> Thanks.  That confirms the high CPU consumption in upowerd ---
> see [1], for example.
> 
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/987807
