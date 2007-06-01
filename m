From: David Greaves <david@dgreaves.com>
Subject: Re: 2.6.22-rc3 hibernate(?) fails totally - regression
Date: Fri, 01 Jun 2007 23:37:33 +0100
Message-ID: <46609FAD.7010203@dgreaves.com>
References: <46608E3F.4060201@dgreaves.com> <200706012342.45657.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758343AbXFAWhp@vger.kernel.org>
In-Reply-To: <200706012342.45657.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Friday, 1 June 2007 23:23, David Greaves wrote:
>> Not a regression though, it does it in 2.6.21
>>
>> If I cause the system to save state to disk then whilst off it no longer
>> responds to g-wol.
> 
> Can you please try with the hibernation and suspend patch series from
> 
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc3/patches/
> 
> applied?
> 
> Greetings,
> Rafael
> 

Sorry I made a mistake in the report.
I was still booting 2.6.21.1 - very sorry :(

The real situation is worse :(

2.6.22-rc3 (no patches) just hangs on suspend at:
Suspending consoles

console switching works but needs a hard reset to reboot.

2.6.22-rc3-skge (with Rafael's patches)
suspends to disk and powers off
wol doesn't work incidentally
resume resumes to the exact same place that 2.6.22-rc3 hangs at...
ie a non-responsive system saying
Suspending consoles

Note, in both cases I can switch VTs, the caps/numlock lights respond.

David
