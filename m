From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 2/3] Freezer: Use wait queue instead of
	busy looping
Date: Thu, 2 Aug 2007 13:15:18 +0200
Message-ID: <200708021315.18851.rjw@sisk.pl>
References: <200708012328.23939.rjw@sisk.pl> <200708012332.48798.rjw@sisk.pl>
	<20070801164831.ed40546d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070801164831.ed40546d.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Thursday, 2 August 2007 01:48, Andrew Morton wrote:
> On Wed, 1 Aug 2007 23:32:48 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > +/*
> > + * Used to notify try_to_freeze_tasks() that the refrigerator has been entered
> > + * by a task.
> > + */
> > +static int refrigerator_called;
> 
> this is rather icky.

Well, the alternative would be to open code something like wait_event_timeout.
