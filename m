From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: default value of power/wakeup
Date: Mon, 20 Apr 2015 15:44:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504201527570.1321-100000@iolanthe.rowland.org>
References: <CAGnHSE=pYr+0pDqS3x=G6qQGLtkP+8yx9OZH_0h=pctrfB85JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52838 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753156AbbDTToV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2015 15:44:21 -0400
In-Reply-To: <CAGnHSE=pYr+0pDqS3x=G6qQGLtkP+8yx9OZH_0h=pctrfB85JQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 21 Apr 2015, Tom Yan wrote:

> Yes of course:

Okay, the two devices appear to be the same as far as remote wakeup is
concerned.  The difference lies in the drivers.  From your original
report:

> logitech-djreceiver 0003:046D:C52B.0003: hiddev0,hidraw0: USB HID
> v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-13/input2
> hid-generic 0003:046D:C52E.0005: input,hidraw2: USB HID v1.11 Keyboard
> [Logitech USB Receiver] on usb-0000:00:14.0-14/input0

As you can see, the first device uses the logitech-djreceiver driver
and the second uses the hid-generic driver.  The generic driver
includes code for enabling wakeup by default, but the
logitech-djreceiver driver doesn't.  In fact, it looks like none of the
special-purpose HID drivers will enable wakeup by default.

Alan Stern

