From: Jarek Poplawski <jarkao2@gmail.com>
Subject: Re: 2.6.33-rc2: Reported regressions 2.6.31 -> 2.6.32
Date: Tue, 29 Dec 2009 23:00:51 +0100
Message-ID: <20091229220051.GA3185__25322.1848550767$1262124119$gmane$org@del.dom.local>
References: <oBElxfTZdhL.A.bx.-vhOLB@chimera> <4B3A5BC2.10207@gmail.com>
	<4B3A6CB1.3030305@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B3A6CB1.3030305@freemail.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 29, 2009 at 09:55:13PM +0100, N=E9meth M=E1rton wrote:
> Jarek Poplawski wrote:
> > Rafael J. Wysocki wrote, On 12/29/2009 04:26 PM:
> > =

> > ...
> >> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=3D14794
> >> Subject		: IP address assigned by DHCP is dropped after ~40 seconds
> >> Submitter	: M=E1rton N=E9meth <nm127@freemail.hu>
> >> Date		: 2009-12-13 08:59 (17 days old)
> >>
> > =

> > =

> > IMHO this bug might be considered as fixed by updating a userspace tool
> > (KNetworkManager) - unless somebody wants to seek for the exact reason.=
..
> =

> For me (I am the reporter) the problem was solved by upgrading a userspace
> tool, so I think the bug filed against the kernel can be closed marking
> that this was not really a kernel bug.

Yes, let's hope author(s) of KNetworkManager would let us know if they
had to change it because of the kernel error.

Regards,
Jarek P.
