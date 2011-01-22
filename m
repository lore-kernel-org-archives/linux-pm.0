From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to
	iomaps management
Date: Sun, 23 Jan 2011 01:24:32 +0800
Message-ID: <AANLkTi=MDyaPj9D+28NWRRK13qhJfKw098xPPhwrGZoa__48183.3258913413$1295717120$gmane$org@mail.gmail.com>
References: <201101201226.41021.rjw@sisk.pl>
	<AANLkTimEoAhO9TRx4Aq7NnTTt6G-u+cHJRyAMjSAJgTm@mail.gmail.com>
	<AANLkTin3d4LdnqDYtrTK=KdmjADA2MsaWYoLG19FxOzG@mail.gmail.com>
	<201101221025.49327.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101221025.49327.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2011/1/22 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday, January 22, 2011, Jeff Chua wrote:

> means that my patch [11/11] _and_ the replacement are totally wrong, beca=
use you have
> _multiple_ NVS regions. =A0That really helped, thanks a lot.

Would it be different if I offline all CPUs before suspending to ram?
It seems to help with suspending to disk.

Thanks,
Jeff
