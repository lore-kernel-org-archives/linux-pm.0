From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Changes in sleep mode, on x86 PC
Date: Tue, 29 Mar 2016 15:06:36 +0200
Message-ID: <4224351.Xlkh4fNNHG@vostro.rjw.lan>
References: <20160328212010.GA22713@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47838 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751526AbcC2NEQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 09:04:16 -0400
In-Reply-To: <20160328212010.GA22713@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>

On Monday, March 28, 2016 11:20:12 PM Pavel Machek wrote:
> Hi!
> 
> Few releases ago, I could wake up PC from S3 sleep by hitting any
> key. That ceased to work some time before, keyboard would just light a
> NUM lock LED when I hit a key (4.5). Now PC seems to be sleeping (in
> S3) with NUM lock LED on (4.6-rc0).
> 
> Any idea what is going on there? Does it happen for you, too? What is
> the expected behaviour?
>
> Debian 8.3, with MATE desktop, I just hit the "moon" key to make it
> sleep. Keyboard is on USB.

That's rather important.

Clearly, something in the USB HID land has changed lately.

The expected behavior depends on whether or not the keyboard itself and the
USB controller are both enabled to wake up.  If they are, I'd expect any
key press to generate a wakeup event.

Thanks,
Rafael

