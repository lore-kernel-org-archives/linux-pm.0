From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re:
 =?iso-8859-1?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_ne?=
 =?iso-8859-1?q?w_top_level_suspend=09and_hibernation_callbacks_=28rev=2E_?=
 =?iso-8859-1?q?2=29?=
Date: Wed, 26 Mar 2008 12:36:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803261236080.7344-100000__39070.1479664587$1206549982$gmane$org@iolanthe.rowland.org>
References: <200803261642.29801.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803261642.29801.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Mar 2008, Oliver Neukum wrote:

> Am Mittwoch, 26. M=E4rz 2008 15:40:27 schrieb Alan Stern:
> > Remember, the whole purpose of this is to let drivers know when the =

> > system is going to sleep or waking up. =A0Proper handling of devices is =

> > up to the drivers, not up to the core.
> =

> Then declare these methods void. We cannot introduce methods that deliber=
ately
> ignore errors. Reporting is also better done in the drivers.

That decision is up to Rafael.  Changing the methods to return void is =

okay with me.

Alan Stern
