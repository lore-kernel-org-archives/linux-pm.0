From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 8/8] ACPI / PM: Use existing ACPI iomaps for
	NVS save/restore (v2)
Date: Sat, 5 Feb 2011 19:20:19 +0100
Message-ID: <201102051920.20195.rjw__40034.7036346377$1296930084$gmane$org@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl> <201101250032.07423.rjw@sisk.pl>
	<AANLkTi=nAhadVy6y6f4uOy0-pvTQrdwYgQ0y_4ukui2z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=nAhadVy6y6f4uOy0-pvTQrdwYgQ0y_4ukui2z@mail.gmail.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, February 05, 2011, Jeff Chua wrote:
> The suspend monster is back! The suspend-to-ram is fine, but upon
> resume, screen is blank. Haven't bisected in case someone has also
> done so.
> 
> It's very recent. ... between commit
> 831d52bc153971b70e64eccfbed2b232394f22f8 and
> 44f2c5c841da1b1e0864d768197ab1497b5c2cc1.

No idea.  I bet on DRI.

Thanks,
Rafael
