From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to
 iomaps management
Date: Sun, 23 Jan 2011 16:20:37 -0200
Message-ID: <20110123182037.GH24071__13039.9110763848$1295806921$gmane$org@khazad-dum.debian.net>
References: <201101201226.41021.rjw@sisk.pl> <201101212206.37469.rjw@sisk.pl>
	<AANLkTimEoAhO9TRx4Aq7NnTTt6G-u+cHJRyAMjSAJgTm@mail.gmail.com>
	<201101221013.10239.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201101221013.10239.rjw@sisk.pl>
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
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 22 Jan 2011, Rafael J. Wysocki wrote:
> > I discovered CONFIG_THINKPAD_ACPI caused suspend-to-disk to hang. I
> > need the Thinkpad ACPI to control the fan and bluetooth. It looks like
> > the thinkpad acpi is trying acquire locks while suspending.  Disabling
> > cmos, light, led and hotkeys makes suspend-to-disk works again.
> 
> Well, we should tell the thinkpad_acpi maintainer about that, then (CCed).

What are the requirements re. mutexes for sleep-to-disk versus sleep-to-ram?

Did something change in that area that caused the driver to hang?  A pointer
to the ML threads, documentation, or patchset/git commit with those changes
would be enough answer, and I will pursue it from there.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
