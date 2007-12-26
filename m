From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] sleepy linux
Date: Wed, 26 Dec 2007 12:43:56 -0800
Message-ID: <4772BD0C.3040609@zytor.com>
References: <20071225230731.GA29030@elf.ucw.cz> <4772A3FB.8080108@zytor.com> <200712262108.35643.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752981AbXLZUpN@vger.kernel.org>
In-Reply-To: <200712262108.35643.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Oliver Neukum wrote:
> Am Mittwoch, 26. Dezember 2007 19:56:59 schrieb H. Peter Anvin:
>>> 3) Network card that is either down
>>>    or can wake up system on any packet (and not loose too many packets)
>>>
>> This is the big crux I see.  You're going to constantly wake up the 
>> machine due to broadcast packets, and spend a lot of power just going in 
>> and out of S3.
> 
> How many machines care a lot about saving power while they are connected
> to an ethernet? Wlan might be more of a problem.

A lot of them should.  An inordinate amount of machines sit there 
burning power for no reason.  You can argue that S3 isn't needed -- that 
nohz + C3/C4 + turning off the screen would be enough, and that might be 
legit.  Heck, I'm constantly frustrated by every distro upgrade breaking 
power management for my monitor.

	-hpa
