From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] power management: implement pm_ops.valid
 for everybody
Date: Wed, 21 Mar 2007 17:01:13 -0800
Message-ID: <20070321170113.2c2b4f1f.akpm@linux-foundation.org>
References: <20070321145328.496614000@sipsolutions.net>
	<20070321145421.918490000@sipsolutions.net>
	<20070321235154.GE6060@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070321235154.GE6060@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Mar 2007 00:51:54 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> On Wed 2007-03-21 15:53:31, Johannes Berg wrote:
> > Almost all users of pm_ops only support mem sleep, don't check in .valid
> > and don't reject any others in .prepare so users can be confused if they
> > check /sys/power/state, especially when new states are added (these wou=
ld
> > then result in s-t-r although they're supposed to be something differen=
t).
> > =

> > This patch implements a generic pm_valid_only_mem function that is then
> > exported for users and puts it to use in almost all existing pm_ops.
> > =

> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> > Cc: David Brownell <david-b@pacbell.net>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: linux-pm@lists.linux-foundation.org
> =

> Looks ok to me. ACK. (But I guess it would be nice to cc rmk or
> something, so we don't conflict with his patches etc?)
> =


I copied Russell and Paul on all three patches.
