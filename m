From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 15 May 2008 23:20:13 +0200
Message-ID: <200805152320.14016.rjw__36891.275100834$1210886665$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803221645190.27399-100000@netrider.rowland.org>
	<200805150147.24968.rjw@sisk.pl>
	<m1fxsjp9ry.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1fxsjp9ry.fsf@frodo.ebiederm.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Len Brown <len.brown@intel.com>, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, 15 of May 2008, Eric W. Biederman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Thursday, 15 of May 2008, Eric W. Biederman wrote:
> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> 
> >> Just an added data partial point.  In the kexec case I have had not heard
> >> anyone screaming to me that ACPI doesn't work after we switch kernels.
> >
> > You don't remove power from devices while doing that.
> 
> No.  It is the second half of S5.  When we go from the boot kernel
> to the restored kernel I am talking about.

Well, you don't remove the power from devices doing that, do you?

I was referring to the fact that you remove the power from devices after saving
the image (ie. in the "poweroff" stage).  Then, you initialize them and pass
all that to the restored kernel and the question here is:
(a) Should they be reinitialized before the restored kernel has a chance to
    access them?
(b) If they should, what state they ought to be in when the restored kernel
    accesses them.

That basically depends on how you're going to handle the resuming of devices,
especially on the ACPI bus, in the restored kernel.

If we are to follow ACPI, the answer to (a) is "no", except for devices used to
read the image and it's better if the boot kernel doesn't touch ACPI at all.
Then, the benefit of putting the system into S4 during the "poweroff" stage is
that (a) the resume can be carried out faster and (b) the restored kernel may
use some context preserved by the platform over the sleep state.

Also, that allows you to use the wake up capabilities of some devices that
need not be available from S5.

In any case, however, I don't really think that doing the kexec jump before
creating the image is really necessary.  The kexec jump during resume is in
fact very similar to what the current hibernation code does, but it's slightly
more complicated. :-)

Thanks,
Rafael
