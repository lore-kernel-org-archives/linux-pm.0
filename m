From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Driver core: don't initialize wakeup flags
Date: Mon, 8 Mar 2010 14:00:35 -0800
Message-ID: <20100308220035.GA21390__37657.0133412772$1268085729$gmane$org@kroah.com>
References: <Pine.LNX.4.44L0.1003081645100.1297-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1003081645100.1297-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 08, 2010 at 04:46:19PM -0500, Alan Stern wrote:
> This patch (as1351) removes an unnecessary and unwanted assignment
> from device_initialize().  The wakeup flags are set to 0 along with
> everything else when the device structure is allocated, so we don't
> need to do it again.  Furthermore, the subsystem might already have
> set these flags to their correct values; we don't want to override it.

Does this solve a bug where a subsystem does do this already?  Or can it
wait for 2.6.35?

thanks,

greg k-h
