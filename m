From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 00/16] Signature verification of hibernate snapshot
Date: Fri, 24 Jul 2015 22:08:49 +0200
Message-ID: <7508149.lVtoIPoiay@vostro.rjw.lan>
References: <1437056730-15247-1-git-send-email-jlee@suse.com> <alpine.LNX.2.00.1507241527410.1141@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43582 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750934AbbGXTl7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 15:41:59 -0400
In-Reply-To: <alpine.LNX.2.00.1507241527410.1141@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>, Matt Fleming <matt.fleming@intel.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <matthew.garrett@nebula.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Josh Boyer <jwboyer@redhat.com>, Vojtech Pavlik <vojtech@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, "Lee, Chun-Yi" <jlee@suse.com>

On Friday, July 24, 2015 07:08:18 PM Jiri Kosina wrote:
> On Thu, 16 Jul 2015, Lee, Chun-Yi wrote:
> 
> > This patchset is the implementation of signature verification of hibernate
> > snapshot image. The origin idea is from Jiri Kosina: Let EFI bootloader
> > generate key-pair in UEFI secure boot environment, then forward it to kernel
> > for sign/verify hibernate image.
> 
> I've finally managed to fully go through the series and test it on my 
> secure boot testing setup.
> 
> 	Reviewed-by: Jiri Kosina <jkosina@suse.com>
> 	Tested-by: Jiri Kosina <jkosina@suse.com>
> 
> for the whole series. Thanks,

Thanks Jiri, much appreciated!

I'd like to hear from Matt, though, and it looks like Ingo han't been CCed ...

Thanks,
Rafael

