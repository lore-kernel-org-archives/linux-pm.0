From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 15 May 2008 13:55:29 -0700
Message-ID: <m1fxsjp9ry.fsf__9418.31681780077$1210885413$gmane$org@frodo.ebiederm.org>
References: <Pine.LNX.4.44L0.0803221645190.27399-100000@netrider.rowland.org>
	<200803222229.45673.rjw@sisk.pl> <m1k5hwzf2z.fsf@frodo.ebiederm.org>
	<200805150147.24968.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805150147.24968.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 15 May 2008 01:47:23 +0200")
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
Cc: Len Brown <len.brown@intel.com>, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Thursday, 15 of May 2008, Eric W. Biederman wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>> Just an added data partial point.  In the kexec case I have had not heard
>> anyone screaming to me that ACPI doesn't work after we switch kernels.
>
> You don't remove power from devices while doing that.

No.  It is the second half of S5.  When we go from the boot kernel
to the restored kernel I am talking about.

That path is exactly what happens successfully in the kexec case.
Transitioning from one kernel to another.

If that path works reliably in kexec then we are talking about
something that can be solved without respect to any specific
ACPI implementation.

Eric
