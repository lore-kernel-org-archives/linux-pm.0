From: Oliver Neukum <oliver@neukum.org>
Subject: Re:
	=?iso-8859-1?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_ne?=
	=?iso-8859-1?q?w_top_level_suspend=09and_hibernation_callbacks_=28?=
	=?iso-8859-1?q?rev=2E_2=29?=
Date: Tue, 25 Mar 2008 20:48:42 +0100
Message-ID: <200803252048.43792.oliver__46422.9602403522$1206474786$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0803251030220.4838-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803251030220.4838-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 25. M=E4rz 2008 15:33:22 schrieb Alan Stern:
> > so I'd say a
> > failure to resume is just a limited subcase of a device vanishing during
> > sleep.
> =

> I'll go along with that. =A0If a device vanishes during sleep, the PM =

> core isn't responsible for unregistering it -- the device's subsystem =

> is.

Yes, that makes sense. You are right.

	Regards
		Oliver
