From: Anders Eriksson <aeriksson@fastmail.fm>
Subject: Re: [suspend/resume] Re: userspace notification from
	module
Date: Tue, 05 Jan 2010 10:07:06 +0100
Message-ID: <20100105090706.751D233C4B0__12597.5022129298$1262712692$gmane$org@tippex.mynet.homeunix.org>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001040045.39517.rjw@sisk.pl>
	<a522f3c.3bab16d1.4b413b9c.ec43@o2.pl>
	<201001042043.27037.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201001042043.27037.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?utf-8?q?Bart=C5=82omiej_Zimo=C5=84?= <uzi18@o2.pl>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, danborkmann@googlemail.com, awalls@radix.net
List-Id: linux-pm@vger.kernel.org


rjw@sisk.pl said:
>> > I don't see a problem with this in principle, although I don't think signals
>> > are very suitable for this particular purpose, because you need two-way
>> > communication between the power manager and the processes it's going to
>> > notify (because it has to wait for the processes to finish their preparations
>> > and to tell it that they are ready). 

Wouldn't there need to be dependecy tracking for the userspace processes? A 
process couldn't signal "done" until it know there's no more work to do, which 
requires all other processes to finish up first.
