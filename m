From: Oliver Neukum <oneukum@suse.com>
Subject: Re: Changes in sleep mode, on x86 PC
Date: Tue, 29 Mar 2016 16:00:09 +0200
Message-ID: <1459260009.5124.5.camel@suse.com>
References: <20160328212010.GA22713@amd> <4224351.Xlkh4fNNHG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4224351.Xlkh4fNNHG@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2016-03-29 at 15:06 +0200, Rafael J. Wysocki wrote:
> On Monday, March 28, 2016 11:20:12 PM Pavel Machek wrote:
> > Hi!
> > 
> > Few releases ago, I could wake up PC from S3 sleep by hitting any
> > key. That ceased to work some time before, keyboard would just light a
> > NUM lock LED when I hit a key (4.5). Now PC seems to be sleeping (in
> > S3) with NUM lock LED on (4.6-rc0).
> > 
> > Any idea what is going on there? Does it happen for you, too? What is
> > the expected behaviour?
> >
> > Debian 8.3, with MATE desktop, I just hit the "moon" key to make it
> > sleep. Keyboard is on USB.
> 
> That's rather important.
> 
> Clearly, something in the USB HID land has changed lately.

Not necessarily. ACPI may also be the root cause.

> The expected behavior depends on whether or not the keyboard itself and the
> USB controller are both enabled to wake up.  If they are, I'd expect any
> key press to generate a wakeup event.

What does /proc/acpi/wakeup say?

	Regards
		Oliver
