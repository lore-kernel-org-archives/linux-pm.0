From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: pm_wakeup.h
Date: Thu, 12 Jun 2008 10:48:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806121046270.2567-100000@iolanthe.rowland.org>
References: <200806120917.33762.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806120917.33762.rjw@sisk.pl>
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
Cc: Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Jun 2008, Rafael J. Wysocki wrote:

> Hi Alan,
> 
> Can you please tell me what the exact reason for not putting the contents of
> pm_wakeup.h into device.h was?

Just for consistency.  None of the other PM declarations are in 
device.h; they are all in pm.h.

If you would prefer to merge the two files, please feel free to do so.

Alan Stern
