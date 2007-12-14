From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: acquire device locks prior to suspending
Date: Fri, 14 Dec 2007 10:32:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712141029001.4768-100000@iolanthe.rowland.org>
References: <20071213133829.6d850a1d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071213133829.6d850a1d.akpm@linux-foundation.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Dec 2007, Andrew Morton wrote:

> Speaking of efficient use of resources: how many other people have tested
> suspend-to-disk with this patch applied?  And on how many machines?

I have no idea -- they don't notify me when they do their testing.  :-)

Anybody who has been testing Greg's development tree for the last month
or two certainly has had that patch installed.  Yours is the second 
complaint I have heard; the first was the CPU hardware monitor driver 
(which Rafael fixed by making it not unregister anything during 
hibernation).

Alan Stern
