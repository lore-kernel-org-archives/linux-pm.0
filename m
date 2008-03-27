From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re:
 =?iso-8859-1?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_ne?=
 =?iso-8859-1?q?w_top_level_suspend=09and_hibernation_callbacks_=28rev=2E_?=
 =?iso-8859-1?q?2=29?=
Date: Wed, 26 Mar 2008 22:48:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803262246460.21714-100000__22451.7311122783$1206586212$gmane$org@netrider.rowland.org>
References: <200803262146.39899.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803262146.39899.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Mar 2008, Rafael J. Wysocki wrote:

> What exactly do you whink would be wrong with using the error codes to avoid
> resuming the children of devices that failed to resume?

Nothing, I guess.  Drivers should work okay either way.

Alan Stern
