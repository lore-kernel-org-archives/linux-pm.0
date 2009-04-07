From: "Trenton D. Adams" <trenton.d.adams@gmail.com>
Subject: Re: 2.6.29-git13: Reported regressions from 2.6.28
Date: Mon, 6 Apr 2009 21:56:27 -0600
Message-ID: <9b1675090904062056v235af58ehc99cce8ff97fe501__43656.8043697209$1239116204$gmane$org@mail.gmail.com>
References: <n4io5wq70ZO.A.gzG.rFn2JB@chimera>
	<alpine.LFD.2.00.0904061443000.7443@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0904061443000.7443@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 6, 2009 at 3:53 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Mon, 6 Apr 2009, Rafael J. Wysocki wrote:
>>
>> Bug-Entry =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D13018
>> Subject =A0 =A0 =A0 =A0 =A0 =A0 =A0 : 2.6.29 on MacBook 2,1 fails to reb=
oot
>> Submitter =A0 =A0 : Trenton Adams <trenton.d.adams@gmail.com>
>> Date =A0 =A0 =A0 =A0 =A0: 2009-03-30 2:04 (8 days old)
>> References =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1238378703072=
49&w=3D4
>> Handled-By =A0 =A0: "Morten P.D. Stevens" <mstevens@win-professional.com>
>
> This went through bisection, but looking at the email log, I tend to
> suspect that maybe Trenton marked some versions good even though they
> weren't (because they got versions numbers from v2.6.27), and didn't
> realize that that messes up bisection in a big way.

Is it appropriate for me to respond to these things?

I was wondering about that.  Someone had mentioned that I should trust
the bisect, even when it takes me into "other versions", and it was
taking me through 2.6.27, which I thought was just really weird.
Would you like me to try the bisect again with a little more
diligence, or do you think it can be found with the info given?  It
may take a week or so, due to being a bit busy.

Thanks
