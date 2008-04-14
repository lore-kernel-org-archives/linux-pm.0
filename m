From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
 hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 10:51:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804141049370.2236-100000__28361.7072542713$1208185628$gmane$org@iolanthe.rowland.org>
References: <200804132147.03579.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804132147.03579.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 13 Apr 2008, David Brownell wrote:

> I sort of agree.  Looking at it from a whole-system perspective,
> suspending needs to be able to chitchat with userspace ... and I
> don't think that can be done *before* writing to /sys/power/state
> in an acceptably generic/portable way.  (Briefly, applications
> need to have clean stopping points and be able to arrange system
> wakeup.  They may well have more work to do than most drivers.)

Pavel's recent work aside, the only way to initiate a system sleep is 
from userspace.  So it seems natural for all application notifications 
to be made by the initiating program, perhaps via dbus.

Alan Stern
