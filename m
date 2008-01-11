From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend (rev. 3)
Date: Fri, 11 Jan 2008 10:07:38 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801111006410.4263-100000__42016.5990632542$1200064247$gmane$org@iolanthe.rowland.org>
References: <200801110216.35446.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801110216.35446.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 11 Jan 2008, Rafael J. Wysocki wrote:

> Hi,
>=20
> The patch below is intended as a replacement for
> gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch that de=
adlocked
> suspend and hibernation on some systems. =C2=A0The present patch contai=
ns some
> safeguards against deadlocks in the relevant cases and a mechanism to p=
rint
> warnings if a deadlock is probable.
>=20
> Greetings,
> Rafael
>=20
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>, Alan Stern <stern@rowland.harvar=
d.edu>
>=20
> This patch reorganizes the way suspend and resume notifications are
> sent to drivers.  The major changes are that now the PM core acquires
> every device semaphore before calling the methods, and calls to
> device_add() during suspends will fail, while calls to device_del()
> during suspends will block.
>=20
> It also provides a way to safely remove a suspended device with the
> help of the PM core, by using the device_pm_schedule_removal() callback
> introduced specifically for this purpose, and updates two drivers (msr
> and cpuid) that need to use it.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
