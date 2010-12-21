From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Trying to find a TuxOnIce merging plan that works.
Date: Wed, 22 Dec 2010 07:52:17 +1100
Message-ID: <4D111381.5000609@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael.

As you may recall, I started working on a bunch of patches about six 
months ago that have been very slow to get merged (yes, mostly my fault 
for perhaps being overly careful about testing). Unfortunately, in the 
process, you've merged other patches (the compression ones) that mean I 
have to rewrite what I'd already done.

To avoid this happening again, I'm proposing that I only work on one 
patch (or very small series of patches) at a time, and not start on the 
next one until you've merged the previous into your for-Linus tree. I'll 
keep an overall plan of where I intend to go, but take things very 
slowly so I don't waste time like that again.

The downside is that means I won't always be able to show demonstrably 
improvements immediately, but I guess we'll just have to cope with that 
situation. I guess I can mitigate this downside by explaining where I'm 
going, even if I can't provide numbers to prove it will be a real 
improvement.

Does this sound feasible to you?

Regards,

Nigel
