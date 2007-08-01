From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -mm 2/3] Freezer: Use wait queue instead of
	busy looping
Date: Wed, 1 Aug 2007 16:48:31 -0700
Message-ID: <20070801164831.ed40546d.akpm__43454.1594623171$1186067463$gmane$org@linux-foundation.org>
References: <200708012328.23939.rjw@sisk.pl> <200708012332.48798.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708012332.48798.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Aug 2007 23:32:48 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> +/*
> + * Used to notify try_to_freeze_tasks() that the refrigerator has been entered
> + * by a task.
> + */
> +static int refrigerator_called;

this is rather icky.
