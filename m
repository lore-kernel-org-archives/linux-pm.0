From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to
	iomaps management
Date: Sat, 22 Jan 2011 20:12:13 +0100
Message-ID: <201101222012.14028.rjw__2113.25416244126$1295723630$gmane$org@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl> <201101221025.49327.rjw@sisk.pl>
	<AANLkTi=MDyaPj9D+28NWRRK13qhJfKw098xPPhwrGZoa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=MDyaPj9D+28NWRRK13qhJfKw098xPPhwrGZoa@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, January 22, 2011, Jeff Chua wrote:
> 2011/1/22 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Saturday, January 22, 2011, Jeff Chua wrote:
> 
> > means that my patch [11/11] _and_ the replacement are totally wrong, because you have
> > _multiple_ NVS regions.  That really helped, thanks a lot.
> 
> Would it be different if I offline all CPUs before suspending to ram?
> It seems to help with suspending to disk.

No, that doesn't matter.  NVS regions are just sitting there regardless of
what happens at run time.

Thanks,
Rafael
