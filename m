From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] power management: force pm_ops.valid
	callback to be assigned
Date: Thu, 22 Mar 2007 22:15:21 +0100
Message-ID: <200703222215.22040.rjw@sisk.pl>
References: <1174571042.32051.2.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174571042.32051.2.camel@johannes.berg>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 22 March 2007 14:44, Johannes Berg wrote:
> This patch changes the docs and behaviour from "all states valid" to
> "no states valid" if no .valid callback is assigned. Users of pm_ops
> that only need mem sleep can assign pm_valid_only_mem without any
> overhead, others will require more elaborate callbacks.
> =

> Now that all users of pm_ops have a .valid callback this is a safe
> thing to do and prevents things from getting messy again as they
> were before.

Looks okay to me.

Rafael
