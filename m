From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 0/3] PM: Improve ACPI handling during
	suspend and hibernation (rev. 3)
Date: Thu, 30 Aug 2007 00:31:25 +0200
Message-ID: <200708300031.26699.rjw__38140.4775348075$1188426093$gmane$org@sisk.pl>
References: <200708272347.45438.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708272347.45438.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, 27 August 2007 23:47, Rafael J. Wysocki wrote:
> Hi,
>=20
> The patches in this series are intended to improve the handling of the =
ACPI
> platform during suspend and hibernation.
>=20
> They do the following things:
> * make hibernation_platform_enter() consistent with the sleep state ent=
ering
> =A0 code in kernel/power/main.c
> * introduce global platform callbacks allowing us to handle ACPI in a m=
ore fine
> =A0 grained way during suspend and hibernation
> * improve the handling of the system status indicator during suspend an=
d
> =A0 hibernation.

Please regard this patch series as withdrawn.

I have found a corner case that requires special treatment clashing with =
the
2/3 and 3/3 patches and the 1/3 patch will be resubmitted separately.

Greetings,
Rafael
