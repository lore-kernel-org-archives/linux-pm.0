From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 9/9] PM / Hibernate: move non-swap code to
	image.c
Date: Fri, 25 Jun 2010 15:55:12 +0200
Message-ID: <201006251555.13125.rjw__35970.3011032709$1277474241$gmane$org@sisk.pl>
References: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
	<1275468768-28229-9-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275468768-28229-9-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 02, 2010, Jiri Slaby wrote:
> Now, when all the swap-independent code was separated, it's time to
> move it into a separate file called image.c. Although snapshot.c is
> image related too, we want to move the snapshot.c code to mm/,
> because it is rather a memory management so that mm people won't
> forget about hibernation. Hence we don't pollute snapshot.c with
> image processing here.

Makes sense.

> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> ---

Rafael
