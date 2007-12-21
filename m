From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: OOPS: 2.6.24-rc5-mm1 -- EIP is at r_show+0x2a/0x70 --
 (triggered by "cat /proc/iomem" AFTER suspend-to-disk/resume)
Date: Fri, 21 Dec 2007 12:00:00 -0800
Message-ID: <20071221120000.b319b735.akpm__37652.9655223296$1198267335$gmane$org@linux-foundation.org>
References: <a44ae5cd0712192040k7480682eoa29f33d70a91c618@mail.gmail.com>
	<4769F409.6030300@gmail.com> <4769FF37.5060308@gmail.com>
	<476A703B.50804@gmail.com>
	<20071220093206.22f319b0.akpm@linux-foundation.org>
	<a44ae5cd0712202158u31c8b4e1lf5b0df89dde20e7e@mail.gmail.com>
	<20071220222913.92a2c19f.akpm@linux-foundation.org>
	<a44ae5cd0712210806i7f020a71k8c552953f7aeef4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <a44ae5cd0712210806i7f020a71k8c552953f7aeef4d@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miles Lane <miles.lane@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Christoph Lameter <clameter@sgi.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 21 Dec 2007 11:06:49 -0500 "Miles Lane" <miles.lane@gmail.com> wrote:

> > >
> > > How do I determine what comes next?
> > >
> >
> > By comparing it with the /proc/iomem from prior to suspending the machine.
> >
> 
> The offending information seems to be "90000000-90000fff : Intel Flush Page"

ah-hah.  git-agpgart.patch

> I hope this helps,

It does, thanks.

Dave, a `cat /proc/iomem' crashes after a suspend/resume cycle when it
reaches the intel_private.ifp_resource record.


intel_i915_configure() is called on each resume and it calls
intel_i9xx_setup_flush() which zeroes out the already-registered `struct
resource', causing core kernel to oops over a deref of
parent/sibling/child.

Probably this:

--- a/drivers/char/agp/intel-agp.c~a
+++ a/drivers/char/agp/intel-agp.c
@@ -883,8 +883,6 @@ static void intel_i965_g33_setup_chipset
 static void intel_i9xx_setup_flush(void)
 {
 	/* setup a resource for this object */
-	memset(&intel_private.ifp_resource, 0, sizeof(intel_private.ifp_resource));
-
 	intel_private.ifp_resource.name = "Intel Flush Page";
 	intel_private.ifp_resource.flags = IORESOURCE_MEM;
 
_


will be enough to prevent the crash, but I suspect a bit more than that
will be needed.
