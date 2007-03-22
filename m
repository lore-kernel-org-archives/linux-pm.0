From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] remove software_suspend() and fix compile w/
	SOFTWARE_SUSPEND disabled
Date: Thu, 22 Mar 2007 22:12:44 +0100
Message-ID: <200703222212.45050.rjw@sisk.pl>
References: <1174571192.32051.5.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174571192.32051.5.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 22 March 2007 14:46, Johannes Berg wrote:
> This patch kills off software_suspend() and all it's users,
> pm_suspend(PM_SUSPEND_DISK) is much cleaner anyway. Also, this
> makes the kernel compile again w/o CONFIG_SOFTWARE_SUSPEND after
> Rafael's patches to kill the suspend pageflags broke it.

The patches have been reworked after Andrew rejected them due to this break=
age.
The current versions are in the -mm tree (http://lkml.org/lkml/2007/3/20/32=
7).

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> =

> ---
> Have the pageflags removal patches been applied anywhere already? If so
> please just apply this on top. If not, could you (Rafael) then fix your
> patches to compile w/o software suspend and then I'll post the removal
> of software_suspend() as an extra patch.

See above. :-)

As far as the rest of the patch is concerned, I have no objections.

Rafael
