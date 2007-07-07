From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Sat, 07 Jul 2007 12:46:37 +1000
Message-ID: <1183776397.3388.203.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707051713440.2753-100000@iolanthe.rowland.org>
	<1183712354.3388.126.camel@localhost.localdomain>
	<200707061131.08475.oliver@neukum.org> <200707061153.05091.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707061153.05091.rjw@sisk.pl>
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
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-07-06 at 11:53 +0200, Rafael J. Wysocki wrote:
> 
> Moreover, I claim that, in the context of your example, _if_ the task
> is stuck
> at the wait_event_uninterruptible(), _then_ the freezerless suspend
> will
> deadlock with the task.

Why would the task be stuck there if it's not becasue of a freezer ? The
only reason I see would be a dependency on something like kmalloc trying
to push things to disk, or a lock owned by another user process, but the
former is a generic issue I've discussed in a separate mail and the
later is a driver bug imho.

Ben.
