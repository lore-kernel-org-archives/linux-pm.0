From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] remove software_suspend()
Date: Wed, 11 Apr 2007 22:18:28 +0200
Message-ID: <200704112218.29433.rjw@sisk.pl>
References: <1176306757.19348.1.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176306757.19348.1.camel@johannes.berg>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 11 April 2007 17:52, Johannes Berg wrote:
> This patch removes software_suspend() and all it's users since
> pm_suspend(PM_SUSPEND_DISK) should be equivalent and there's no
> point in having two interfaces for the same thing.
> =

> The patch also changes the valid_state function to return 0
> (false) for PM_SUSPEND_DISK when SOFTWARE_SUSPEND is not configured
> instead of accepting it and having the whole thing fail later.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

As far as I'm concerned, it's fine.

Greetings,
Rafael
