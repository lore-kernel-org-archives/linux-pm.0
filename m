From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: RE: [PATCH] tools/power turbostat: Make interval calculation per
 thread to reduce jitter
Date: Tue, 23 Apr 2019 17:53:02 +0000
Message-ID: <SN6PR12MB26394D7FEE4582FD19860104F8230@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190325173232.216357-1-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325173232.216357-1-Yazen.Ghannam@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "len.brown@intel.com" <len.brown@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.=
org> On Behalf Of Ghannam, Yazen
> Sent: Monday, March 25, 2019 12:33 PM
> To: linux-pm@vger.kernel.org
> Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; linux-kernel@vger.kernel.org;=
 lenb@kernel.org
> Subject: [PATCH] tools/power turbostat: Make interval calculation per thr=
ead to reduce jitter
>=20
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>=20
> Turbostat currently normalizes TSC and other values by dividing by an
> interval. This interval is the delta between the start of one global
> (all counters on all CPUs) sampling and the start of another. However,
> this introduces a lot of jitter into the data.
>=20
> In order to reduce jitter, the interval calculation should be based on
> timestamps taken per thread and close to the start of the thread's
> sampling.
>=20
> Define a per thread time value to hold the delta between samples taken
> on the thread.
>=20
> Use the timestamp taken at the beginning of sampling to calculate the
> delta.
>=20
> Move the thread's beginning timestamp to after the CPU migration to
> avoid jitter due to the migration.
>=20
> Use the global time delta for the average time delta.
>=20
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---

Hi Len,

Any comments on this patch?

Thanks,
Yazen
