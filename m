From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: apm emulation driver broken ?
Date: Sun, 18 Nov 2007 20:57:33 +0100
Message-ID: <4740992D.9030906__49654.3726920665$1195415947$gmane$org@gmail.com>
References: <cda58cb80711160706l2cfac2b1p81c7a1090f228f2e@mail.gmail.com>
	<200711171059.57462.rjw@sisk.pl> <473ED715.9000004@gmail.com>
	<200711171346.51363.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711171346.51363.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Saturday, 17 of November 2007, Franck Bui-Huu wrote:
>> ok so now we agreed on this point, can we assert that a user
>> land thread waiting for an event in an UNINTERRUPTIBLE state
>> will prevent a suspend to happen ?
> 
> Yes.
> 

So this driver seems really broken and actually I'm wondering if
it's used by anyone...

See the call to wait_even() made by apm_ioctl(). If any processes
run this, it will prevent the system to suspend...

And no, I don't know why call wait_event() is called.

		Franck
