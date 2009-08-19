From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Wed, 19 Aug 2009 10:42:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908191040050.3001-100000@iolanthe.rowland.org>
References: <20090819020156.GA22638@zhen-devel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090819020156.GA22638@zhen-devel.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@redhat.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Aug 2009, Zhenyu Wang wrote:

> Rafael, as I added this restore long time ago, pci core has changed in some way?
> We had problem when reconfigure agp GTT space in resume, as we must be sure
> gfx device's config space has been restored properly, and as 02:00 gfx device
> restored later than host bridge 00:00 device, that came to my origin patch to
> restore it earlier.

Why did you do it that way?  I mean, why not restore the gfx device's 
config space in its own resume routine instead of in the host bridge's 
resume routine?

Alan Stern
