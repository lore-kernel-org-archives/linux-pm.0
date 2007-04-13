From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 00:18:06 +0200
Message-ID: <200704140018.07367.rjw@sisk.pl>
References: <1175810054.3489.34.camel@johannes.berg>
	<20070413215241.GO28264@elf.ucw.cz>
	<1176501547.7052.130.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176501547.7052.130.camel@johannes.berg>
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

On Friday, 13 April 2007 23:59, Johannes Berg wrote:
> On Fri, 2007-04-13 at 23:52 +0200, Pavel Machek wrote:
> =

> > Look again, this sequence is before taking system snapshot, and then
> > we have to recover and save the snapshot, too.
> =

> I know. But that doesn't make us care.
> =

> As I explained previously, the decrementer exception is pending until it
> is taken. It doesn't matter one bit whether it is pending during the
> snapshot, but it does matter if we need the CPU to go to sleep later
> because it won't when the exception is pending.

Technically, they may be not needed by (u)swsusp, but since (u)swsusp alrea=
dy
uses pm_ops in the platform mode, it formally should use these new hooks in
the platform mode too.  Otherwise it won't make sense to use pm_ops in
(u)swsusp at all, IMHO.

Greetings,
Rafael
