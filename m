From: =?ISO-8859-1?Q?=C1kos_Mar=F3y?= <akos@maroy.hu>
Subject: Re: pm-suspend working, but pm-hibernate fails
Date: Mon, 01 Mar 2010 08:46:37 +0100
Message-ID: <4B8B70DD.7000208@maroy.hu>
References: <4B86F96A.1010306@maroy.hu> <20100227135144.GA18662@qp>
	<4B89288F.8070302@maroy.hu> <201002271908.58333.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002271908.58333.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Rafael,

> You can actually do that with the in-kernel hibernate too.
> 
> Please read Documentation/power/basic-pm-debugging.txt, there are more
> hibernate debugging hints in there.

thanks for the tip. I tried the various levels of hibernation, and the
freezer mode works, while the devices mode fails the same as the
'normal' hibernation.

as the only point forward in the documentation is to do a binary search
on the kernel modules by unloading them before the test, I'll have to
find the time to do this. this is also quite complicated because of how
modules depend on each other.


Akos
