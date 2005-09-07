From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: swsusp doesn't suspend devices
Date: Wed, 07 Sep 2005 22:17:08 +0200
Message-ID: <431F4AC4.9030206@drzeus.cx>
References: <431ECCE3.8080408@drzeus.cx> <200509072203.19283.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751306AbVIGURM@vger.kernel.org>
In-Reply-To: <200509072203.19283.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:

>On Wednesday, 7 of September 2005 13:20, Pierre Ossman wrote:
>  
>
>>It would seem that swsusp doesn't properly suspend devices, or more
>>precisely it wakes them up again before suspending the machine.
>>    
>>
>
>Yes, it does.  By design.
>
>  
>

That seems counter-productive, so I'm obviously missing something.
