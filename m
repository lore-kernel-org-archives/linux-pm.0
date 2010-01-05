From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: Re: [suspend/resume] Re: userspace notification from
 module
Date: Tue, 5 Jan 2010 22:26:57 +0100
Message-ID: <20100105222657.27218c4c__31327.6107692674$1262726941$gmane$org@strolchi.home.s3e.de>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001040045.39517.rjw@sisk.pl>
	<a522f3c.3bab16d1.4b413b9c.ec43@o2.pl>
	<201001042043.27037.rjw@sisk.pl>
	<20100105090706.751D233C4B0@tippex.mynet.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100105090706.751D233C4B0@tippex.mynet.homeunix.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Anders Eriksson <aeriksson@fastmail.fm>
Cc: awalls@radix.net, linux-kernel@vger.kernel.org, =?UTF-8?B?QmFydMWCb21pZWogWmltb8WE?= <uzi18@o2.pl>, linux-pm@lists.linux-foundation.org, danborkmann@googlemail.com
List-Id: linux-pm@vger.kernel.org

On Tue, 05 Jan 2010 10:07:06 +0100
Anders Eriksson <aeriksson@fastmail.fm> wrote:

> 
> rjw@sisk.pl said:
> >> > I don't see a problem with this in principle, although I don't think signals
> >> > are very suitable for this particular purpose, because you need two-way
> >> > communication between the power manager and the processes it's going to
> >> > notify (because it has to wait for the processes to finish their preparations
> >> > and to tell it that they are ready). 
> 
> Wouldn't there need to be dependecy tracking for the userspace processes? A 
> process couldn't signal "done" until it know there's no more work to do, which 
> requires all other processes to finish up first.

No. 99% of the processes don't care about suspend. They don't need
notifications or anything.
The few that do care, register themselves with the power manager. They
get notified before suspend and the power manager might wait until they
tell him that they are ready.
A special case are processes that only want to inhibit suspend - the CD
burning application case - they just tell the power manager "I am
important and you must not suspend now". They do this even if there is
no suspend notification, and once they are done with the critical part
of their work, they remove their "inhibit flag".

This all works pretty well already, and is really not very complicated.
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
