From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
Date: Fri, 11 Jul 2008 19:23:04 -0700
Message-ID: <m1lk076dtj.fsf__2344.1539764919$1215830142$gmane$org@frodo.ebiederm.org>
References: <1215401122.4660.4.camel@caritas-dev.intel.com>
	<20080711122131.b6461ab1.akpm@linux-foundation.org>
	<20080711202434.GB6261@elf.ucw.cz> <200807112240.59461.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807112240.59461.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri, 11 Jul 2008 22:40:58 +0200")
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> The truth is we could do hibernation without the freezer if
> (a) some drivers were fixed not to rely on it (kexec doesn't help here),
> (b) we had support at the block layer or filesystems level (kexec is a big
>    workaround here).

I just realized with a little care the block layer does have support for this,
or something very close.

You setup a software raid mirror with one disk device.    The physical
device can come in and out while the filesystems depend on the real device.

I expect a hardware pass through device configured to do exactly the
above would be about 100 lines of code, so getting past the filesystem
hurdle should be very doable.  Arguably we should be able to do this
up a level, but it is easy enough to do that you can do a proof of
concept with out that.

Now I'm curious to see how far you can go with just the device hotplug support.

Eric
