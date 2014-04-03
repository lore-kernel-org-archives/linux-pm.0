From: "Valerio Vanni" <valerio@valeriovanni.com>
Subject: Re: serial console does not wake from S3 suspend
Date: Thu, 3 Apr 2014 13:47:43 +0200
Message-ID: <lhjhpg$o2e$1@ger.gmane.org>
References: <lg9etc$9fl$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Valerio Vanni" <valerio@valeriovanni.com> ha scritto nel messaggio
news:lg9etc$9fl$1@ger.gmane.org
> When resuming from S3 suspend, serial console starts sending garbage
> on the serial port.
> Not continuously, it sends garbage only when in local console prints a
> text.
> It stops only when the (sending) machine is shut down, or if some
> text is sent manually (i.e. with "cat txtfile > /dev/ttyS0").
>
> Full details are here:
> https://bugzilla.kernel.org/show_bug.cgi?id=69751

The problem is still present in final 3.14 (and in linux-next).



