From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during snapshot/shutdown
Date: Fri, 27 Apr 2007 17:00:52 +0200
Message-ID: <200704271700.52678.rjw@sisk.pl>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
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
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Friday, 27 April 2007 15:29, Pekka J Enberg wrote:
> From: Nigel Cunningham <nigel@nigel.suspend2.net>
> 
> As explained by Nigel, Sendmail and some other programs look at the
> load average and stop delivering when it gets too high.  The CPU
> intensiveness of suspending to disk pushes the load average up quite
> high but post-resume we shouldn't really take that into account.  Not
> updating the load average therefore makes snapshot/shutdown invisible
> to sendmail and so on.
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

This clashes with the recent freezer changes in -mm quite violently.

We're moving the freezer to kernel/freezer.c and we're introducing a special
field in task_struct for the freezer flags.

Please have a look at the freezer changes queued up in -mm and the freezer
patches recently sent.

Greetings,
Rafael
