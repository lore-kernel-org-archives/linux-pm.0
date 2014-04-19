From: "Valerio Vanni" <valerio.vanni@inwind.it>
Subject: Fw: serial console does not wake from S3 suspend
Date: Sat, 19 Apr 2014 16:49:18 +0200
Message-ID: <25D8F77BCF9142DE87B7CDEAB21A4CE2@vanni.it>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=response
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp1.ngi.it ([88.149.128.112]:54231 "EHLO smtp1.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbaDSOtY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 19 Apr 2014 10:49:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, baryluk@smp.if.uj.edu.pl, davem@davemloft.net, peter@hurleysoftware.com, rmk@arm.linux.org.uk, tianyu.lan@intel.com

> "Valerio Vanni" <valerio@valeriovanni.com> ha scritto nel messaggio
> news:lg9etc$9fl$1@ger.gmane.org
> When resuming from S3 suspend, serial console starts sending garbage
> on the serial port.
> Not continuously, it sends garbage only when in local console prints
> a text.
> It stops only when the (sending) machine is shut down, or if some
> text is sent manually (i.e. with "cat txtfile > /dev/ttyS0").
> 
> Full details are here:
>> https://bugzilla.kernel.org/show_bug.cgi?id=69751

It's still present in 3.15-rc1 and in actual -next.

