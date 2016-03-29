From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Changes in sleep mode, on x86 PC
Date: Tue, 29 Mar 2016 23:46:23 +0200
Message-ID: <1757366.1UQHDJLEeh@vostro.rjw.lan>
References: <20160328212010.GA22713@amd> <4224351.Xlkh4fNNHG@vostro.rjw.lan> <20160329142405.GA24781@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160329142405.GA24781@amd>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 29, 2016 04:24:05 PM Pavel Machek wrote:
> 
> On Tue 2016-03-29 15:06:36, Rafael J. Wysocki wrote:
> > On Monday, March 28, 2016 11:20:12 PM Pavel Machek wrote:
> > > Hi!
> > > 
> > > Few releases ago, I could wake up PC from S3 sleep by hitting any
> > > key. That ceased to work some time before, keyboard would just light a
> > > NUM lock LED when I hit a key (4.5). Now PC seems to be sleeping (in
> > > S3) with NUM lock LED on (4.6-rc0).
> > > 
> > > Any idea what is going on there? Does it happen for you, too? What is
> > > the expected behaviour?
> > >
> > > Debian 8.3, with MATE desktop, I just hit the "moon" key to make it
> > > sleep. Keyboard is on USB.
> > 
> > That's rather important.
> > 
> > Clearly, something in the USB HID land has changed lately.
> > 
> > The expected behavior depends on whether or not the keyboard itself and the
> > USB controller are both enabled to wake up.  If they are, I'd expect any
> > key press to generate a wakeup event.
> 
> Is there anything in /sys I should check?

Generally, power/wakeup files under the involved devices (ie. if they are
present and what's in them if so).

Thanks,
Rafael

