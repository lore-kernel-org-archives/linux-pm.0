From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: 2.6.30-rc2-git2: Reported regressions from 2.6.29
Date: Fri, 17 Apr 2009 09:28:54 +0800
Message-ID: <b6a2187b0904161828h33ad84d4y8074c993a43dd146__15772.524852264$1239931945$gmane$org@mail.gmail.com>
References: <EJaiQ4Wfaz.A.3YG.4v85JB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <EJaiQ4Wfaz.A.3YG.4v85JB@chimera>
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
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 17, 2009 at 5:42 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D13118
> Subject =A0 =A0 =A0 =A0 : iptables very slow after commit 784544739a25c30=
637397ace5489eeb6e15d7d49
> Submitter =A0 =A0 =A0 : Jeff Chua <jeff.chua.linux@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2009-04-10 16:05 (7 days old)
> References =A0 =A0 =A0: http://lkml.org/lkml/2009/4/10/111
> Handled-By =A0 =A0 =A0: Eric Dumazet <dada1@cosmosbay.com>

Several iterations of patches in progress. See
[PATCH] netfilter: per-cpu spin-lock with recursion (v0.8)


> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D13066
> Subject =A0 =A0 =A0 =A0 : Intel HD Audio oops
> Submitter =A0 =A0 =A0 : Jeff Chua <jeff.chua.linux@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2009-04-01 8:28 (16 days old)
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1238574546=
25829&w=3D4

Fixed as of April 09 2009 git pull.


Thanks,
Jeff
