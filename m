From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
	=?iso-8859-1?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_ne?=
	=?iso-8859-1?q?w_top_level_suspend=09and_hibernation_callbacks_=28?=
	=?iso-8859-1?q?rev=2E_2=29?=
Date: Wed, 26 Mar 2008 21:46:38 +0100
Message-ID: <200803262146.39899.rjw__25410.6585555293$1206564672$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803261236080.7344-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803261236080.7344-100000@iolanthe.rowland.org>
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

On Wednesday, 26 of March 2008, Alan Stern wrote:
> On Wed, 26 Mar 2008, Oliver Neukum wrote:
> =

> > Am Mittwoch, 26. M=E4rz 2008 15:40:27 schrieb Alan Stern:
> > > Remember, the whole purpose of this is to let drivers know when the =

> > > system is going to sleep or waking up. =A0Proper handling of devices =
is =

> > > up to the drivers, not up to the core.
> > =

> > Then declare these methods void. We cannot introduce methods that delib=
erately
> > ignore errors. Reporting is also better done in the drivers.
> =

> That decision is up to Rafael.  Changing the methods to return void is =

> okay with me.

But that's not what they currently do, either.

If I change the methods to void and it turns out in the future that it's
better if they return error codes, it will be rather difficult to go back a=
nd
change everything.  For this reason, I'd prefer to retain the returning of
error codes.

What exactly do you whink would be wrong with using the error codes to avoid
resuming the children of devices that failed to resume?

Rafael
