From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: 2.6.30-rc2-git2: Reported regressions from 2.6.29
Date: Fri, 17 Apr 2009 09:37:10 +0800
Message-ID: <d82e647a0904161837w6b6fb652la0da05f9061e95dc__2387.13297662816$1239932613$gmane$org@mail.gmail.com>
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
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, mchehab@infradead.org, Linux ACPI <linux-acpi@vger.kernel.org>, video4linux-list@redhat.com, laurent.pinchart@skynet.be, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2009/4/17 Rafael J. Wysocki <rjw@sisk.pl>:
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D13125
> Subject =A0 =A0 =A0 =A0 : active uvcvideo breaks over suspend
> Submitter =A0 =A0 =A0 : Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2009-04-15 10:12 (2 days old)
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1239790095=
08840&w=3D4
>

It is a bug in resume path of uvcvideo driver, and I have sent a patch
to laurent.pinchart@skynet.be,
mchehab@infradead.org  and video4linux-list@redhat.com to fix it, but
still no echo from them.

The patch title is V4L/DVB:usbvideo:fix uvc resume failed.

Rafael J.
        If you would like to apply it ,I can resend to you.  Thanks!

-- =

Lei Ming
