From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 3.2-rc2+: Reported regressions from 3.0 and 3.1
Date: Mon, 21 Nov 2011 14:07:20 -0800
Message-ID: <CA+55aFxv7+Kf=sRj7RCSeY0dcVFMcUiXVKT=CY-2aFti5bO4yA__42942.7094212317$1321913280$gmane$org@mail.gmail.com>
References: <lx6sezwGldO.A.IhF.UBpWOB@chimera> <201111212249.31196.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201111212249.31196.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 21, 2011 at 1:49 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> Subject =A0 =A0: Simultaneous cat and external keyboard input causing ker=
nel panic
> Submitter =A0: Timo Jyrinki <timo.jyrinki@gmail.com>
> Date =A0 =A0 =A0 : 2011-11-03 12:14
> Message-ID : CAJtFfxmovJHspHHKbvBVc4pw+u5mjGmUejCXEzdV+GqE=3DjVSOQ@mail.g=
mail.com
> References : http://marc.info/?l=3Dlinux-kernel&m=3D132032253903074&w=3D2

So while funny, I doubt this is actually a bug. It's a feature, as
pointed out by Clemens Ladisch in that thread.

It's simply sysrq-c: "perform a system crash by a NULL pointer dereference".

Now, I'm perfectly willing to consider that feature to be a
mis-feature, and that this should be considered a bug to be fixed. But
it is not a regression.

Keeping it on the regression list just because it is amusing is
understandable, though ;)

                    Linus
