From: Dave Jones <davej@redhat.com>
Subject: Re: 3.1-rc3-git6: Reported regressions from 3.0
Date: Sun, 28 Aug 2011 15:35:20 -0400
Message-ID: <20110828193519.GA14132__14118.5206980028$1314560191$gmane$org@redhat.com>
References: <lx6sezwGldO.A.IhF.UBpWOB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <lx6sezwGldO.A.IhF.UBpWOB@chimera>
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
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 28, 2011 at 08:22:05PM +0200, Rafael J. Wysocki wrote:
 =

 > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=3D41742
 > Subject		: duplicate filename  for intel_backlight with the i915 driver
 > Submitter	: Fran=E7ois Valenduc <francois.valenduc@tvcablenet.be>
 > Date		: 2011-08-25 18:51 (4 days old)
 > First-Bad-Commit: http://git.kernel.org/linus/aaa6fd2a004147bf32fce05720=
938236de3361d9
 =

this should be fixed by b727d20269e8ef1de002bfea8099f5e9db9e9f23
 =

	Dave
