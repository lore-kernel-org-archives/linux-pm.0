From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 13 Mar 2008 17:07:17 -0600
Message-ID: <m1ejaew7dm.fsf__7938.11047119579$1205450048$gmane$org@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
	<200803122253.07631.rjw@sisk.pl>
	<m1iqzrxy26.fsf@ebiederm.dsl.xmission.com>
	<200803131803.31120.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803131803.31120.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 13 Mar 2008 18:03:29 +0100")
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From the ACPI compliance point of view it's better to do it this way.  We need
> to put the devices into low power states anyway before "powering off" the
> system and we won't need to touch them for the second time if we do that
> in advance.

Interesting.  From a kexec jump where we exit the kernel and then return
to it seem all that is required.

I will have to look at the ACPI case.  That seems to be the lynch pin
of a couple of arguments for doing strange things: ACPI requires it.

> Still, it would be sufficient if we disconnected the drivers from the hardware
> and thus prevented applications from accessing that hardware.

My gut feeling is that except for a handful of drivers we could even
get away with simply implementing hot unplug and hot replug.  Disks
are the big exception here.

Which suggests to me that it is at least possible that the methods we
want for a kexec jump hibernation may be different from an in-kernel
hibernation and quite possibly are easier to implement.

Eric
