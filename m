From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] sleepy linux
Date: Wed, 26 Dec 2007 11:22:59 -0800
Message-ID: <4772AA13.4030004@zytor.com>
References: <20071225230731.GA29030@elf.ucw.cz> <4772A3FB.8080108@zytor.com> <20071226190045.GB8094@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752319AbXLZTXU@vger.kernel.org>
In-Reply-To: <20071226190045.GB8094@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> 
> Yep... for the first version, I'll be very happy if it autosleeps when
> I'm traveling by bus or something. Working with ethernet plugged in is
> quite a distant goal.
> 
> (But I guess some cleverness could be done on the router or
> something. Automagically converting "interesting" packets into WoL
> enabled ones, or...?)
> 									Pavel

You've just eliminated 90%+ of the available Ethernet infrastructure.

However, there may be Ethernet controllers which can do something smart 
with incoming packets, and perhaps more importantly, we can always write 
a spec and try to push it to Intel, Broadcom, Realtek and Nvidia.

	-hpa
